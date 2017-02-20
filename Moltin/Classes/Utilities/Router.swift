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

enum Router: URLRequestConvertible {
    static let baseURLString: String = {
        return "https://api.moltin.com"
    }()
    
    static let auth = Auth()
    
    case authenticate
    
    case listCollections(query: MoltinQuery?)
    case getCollection(id: String)
    
    case listProducts(query: MoltinQuery?)
    case getProduct(id: String)
    
    case listCurrencies
    case getCurrency(id: String)
    
    private var method: HTTPMethod {
        switch self {
        case .listCollections, .getCollection, .listProducts, .getProduct, .listCurrencies, .getCurrency:
            return .get
        case .authenticate:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .authenticate:
            return "/oauth/access_token"
        case .listCollections:
            return "/v2/collections"
        case .getCollection(let id):
            return "/v2/collections/\(id)"
        case .listProducts:
            return "/v2/products"
        case .getProduct(let id):
            return "/v2/prodcuts/\(id)"
        case .listCurrencies:
            return "/v2/currencies"
        case .getCurrency(let id):
            return "/v2/currencies/\(id)"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .listProducts(let query), .listCollections(let query):
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
                }.trimmingCharacters(in: CharacterSet(charactersIn: ","))))
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
            headerDictionary["Authorization"] = "Bearer " + authToken
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
