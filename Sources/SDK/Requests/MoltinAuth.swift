//
//  Auth.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

class MoltinAuth {

    internal var http: MoltinHTTP
    internal var config: MoltinConfig

    var token: String? {
        didSet {
            UserDefaults.standard.set(self.token, forKey: "Moltin.auth.token")
            UserDefaults.standard.synchronize()
        }
    }

    var expires: Date? {
        didSet {
            UserDefaults.standard.set(self.expires, forKey: "Moltin.auth.expires")
            UserDefaults.standard.synchronize()
        }
    }

    init(withConfiguration config: MoltinConfig) {
        self.token = UserDefaults.standard.value(forKey: "Moltin.auth.token") as? String
        self.expires = UserDefaults.standard.value(forKey: "Moltin.auth.expires") as? Date

        self.http = MoltinHTTP(withSession: URLSession.shared)
        self.config = config
    }

    private var requiresRefresh: Bool {
        guard let expires = self.expires,
            self.token != nil else {
                return true
        }

        return expires <= Date()
    }

    func authenticate(completionHandler: @escaping (Result<(token: String?, expires: Date?)>) -> Void) {
        guard self.requiresRefresh else {
            completionHandler(.success(result: (self.token, self.expires)))
            return
        }

        var urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: "/oauth/access_token",
                withQueryParameters: [],
                includeVersion: false
            )
        } catch {
            completionHandler(.failure(error: error))
            return
        }

        var request = self.http.configureRequest(urlRequest, withToken: nil, withConfig: self.config)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let data = "client_id=\(self.config.clientID)&grant_type=implicit".data(using: .utf8, allowLossyConversion: false)
        request.httpBody = data

        self.http.executeRequest(request) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error: error))
                return
            }

            guard let data = data else {
                completionHandler(.failure(error: MoltinError.couldNotAuthenticate))
                return
            }

            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
            let json = jsonObject as? [String: Any]

            guard
                let accessToken = json?["access_token"] as? String,
                let expires = json?["expires"] as? Int else {
                    completionHandler(.failure(error: MoltinError.couldNotAuthenticate))
                    return
            }

            self.token = accessToken
            self.expires = Date(timeIntervalSince1970: TimeInterval(expires))

            completionHandler(.success(result: (self.token, self.expires)))
        }
    }
}
