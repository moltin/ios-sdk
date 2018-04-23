//
//  Auth.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

struct MoltinAuthCredentials: Codable {
    var clientID: String
    var token: String
    var expires: Date

    init(clientID: String, token: String, expires: Date) {
        self.clientID = clientID
        self.token = token
        self.expires = expires
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

class MoltinAuth {

    internal var http: MoltinHTTP
    internal var config: MoltinConfig

    var credentials: MoltinAuthCredentials? {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(self.credentials), forKey: "Moltin.auth.credentials")
            UserDefaults.standard.synchronize()
        }
    }

    init(withConfiguration config: MoltinConfig) {
        if let data = UserDefaults.standard.value(forKey: "Moltin.auth.credentials") as? Data {
            self.credentials = try? JSONDecoder().decode(MoltinAuthCredentials.self, from: data)
        }

        self.http = MoltinHTTP(withSession: URLSession.shared)
        self.config = config
    }

    private var requiresRefresh: Bool {
        guard let expires = self.credentials?.expires,
            self.credentials?.token != nil,
            self.credentials?.clientID == self.config.clientID else {
                return true
        }

        return expires <= Date()
    }

    func authenticate(completionHandler: @escaping (Result<(token: String?, expires: Date?)>) -> Void) {
        guard self.requiresRefresh else {
            completionHandler(.success(result: (token: self.credentials?.token, expires: self.credentials?.expires)))
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

            self.credentials = MoltinAuthCredentials(
                clientID: self.config.clientID,
                token: accessToken,
                expires: Date(timeIntervalSince1970: TimeInterval(expires))
            )

            completionHandler(.success(result: (token: self.credentials?.token, expires: self.credentials?.expires)))
        }
    }
}
