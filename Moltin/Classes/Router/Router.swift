//
//  Router.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

public enum Result<T> {
    case success(result: T)
    case failuer(error: Error)
}

enum Router: URLRequestConvertible {
    static let baseURLString: String = {
        return "https://api.moltin.com"
    }()
    
    static let auth = Auth()
    
    case authenticate
    
    case listProducts(query: ProductQuery?)
    case getProduct(id: String)
    
    private var method: HTTPMethod {
        switch self {
        case .listProducts, .getProduct:
            return .get
        case .authenticate:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .authenticate:
            return "/oauth/access_token"
        case .listProducts:
            return "/v2/products"
        case .getProduct(let id):
            return "/v2/prdocuts/\(id)"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .listProducts(let query):
            guard let query = query else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = []
            
            if let offset = query.offset {
                queryItems.append(URLQueryItem(name: "page[offset]", value: "\(offset)"))
            }
            
            if let limit = query.limit {
                queryItems.append(URLQueryItem(name: "page[limit]", value: "\(limit)"))
            }
            
            if let sort = query.sort {
                queryItems.append(URLQueryItem(name: "sort", value: "\(sort)"))
            }
            
            if let filter = query.filter {
                queryItems.append(URLQueryItem(name: "filter", value: "\(filter)"))
            }
            
            if let include = query.include {
                queryItems.append(URLQueryItem(name: "include", value: include.reduce("") {
                    $0 + ",\($1.rawValue)"
                }))
            }
            
            return queryItems
        default:
            return nil
        }
    }
    
    private var bodyContent: JSON? {
        switch self {
        default:
            return nil
        }
    }
    
    private var headers: [String: String] {
        var headerDictionary = ["Accept" : "application/json"]
        
        if let authToken = Router.auth.token {
            headerDictionary["Authorization"] = authToken
        }
        
        switch self {
        case .authenticate:
            headerDictionary["Content-Type"] = "application/x-www-form-urlencoded"
        default:
            headerDictionary["Content-Type"] = "application/json"
        }
        
        return headerDictionary
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: Router.baseURLString)!
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: bodyContent)
        
        return urlRequest
    }
}
