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
    case getCollection(id: String, include: [MoltinQuery.Include]?)
    
    case listProducts(query: MoltinQuery?)
    case getProduct(id: String, include: [MoltinQuery.Include]?)
    
    case listCurrencies
    case getCurrency(id: String)
    
    case listFiles(query: MoltinQuery?)
    case getFile(id: String)
    
    case listBrands(query: MoltinQuery?)
    case getBrand(id: String, include: [MoltinQuery.Include]?)
    
    case listCategories(query: MoltinQuery?)
    case getCategory(id: String, include: [MoltinQuery.Include]?)
    case getCategoryTree
    
    case getCart(reference: String)
    case listItems(cartID: String)
    case addItem(cartID: String, productID: String, quantity: UInt)
    case addCustomItem(customItem: CustomItem, cartID: String)
    case updateQuantity(cartID: String, itemID: String, quantity: UInt)
    case deleteItem(cartID: String, itemID: String)
    
    case checkout(cartID: String, customer: Customer, billingAddress: Address, shippingAddress: Address)
    case payment(orderID: String, paymentMethod: PaymentMethod)
    
    private var method: HTTPMethod {
        switch self {
        case .authenticate, .addItem, .addCustomItem, .checkout, .payment:
            return .post
        case .updateQuantity:
            return .put
        case .deleteItem:
            return .delete
        default:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .authenticate:
            return "/oauth/access_token"
        case .listCollections:
            return "/v2/collections"
        case .getCollection(let id, let _):
            return "/v2/collections/\(id)"
        case .listProducts:
            return "/v2/products"
        case .getProduct(let id, let _):
            return "/v2/products/\(id)"
        case .listCurrencies:
            return "/v2/currencies"
        case .getCurrency(let id):
            return "/v2/currencies/\(id)"
        case .listFiles:
            return "/v2/files"
        case .getFile(let id):
            return "/v2/files/\(id)"
        case .listBrands:
            return "/v2/brands"
        case .getBrand(let id, let _):
            return "/v2/brands/\(id)"
        case .listCategories:
            return "/v2/categories"
        case .getCategory(let id, let _):
            return "/v2/categories/\(id)"
        case .getCategoryTree:
            return "/v2/categories/tree"
        case .getCart(let id):
            return "/v2/carts/\(id)"
        case .listItems(let id), .addItem(let id, _, _), .addCustomItem(_, let id):
            return "/v2/carts/\(id)/items"
        case .updateQuantity(let cartID, let itemID, _), .deleteItem(let cartID, let itemID):
            return "/v2/carts/\(cartID)/items/\(itemID)"
        case .checkout(let id, _, _, _):
            return "/v2/carts/\(id)/checkout"
        case .payment(let id, _):
            return "/v2/orders/\(id)/payments"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .listProducts(let query),
             .listCollections(let query),
             .listFiles(let query),
             .listBrands(let query),
             .listCategories(let query):
            
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
            
            if let include = query.include, 0 < include.count {
                queryItems.append(URLQueryItem(name: "include", value: include.reduce("") {
                    $0 + ",\($1.rawValue)"
                    }.trimmingCharacters(in: CharacterSet(charactersIn: ","))))
            }
            
            return queryItems
        case .getBrand(let _, let include),
             .getCategory(let _, let include),
             .getCollection(let _, let include),
             .getProduct(let _, let include):
            guard let include = include, 0 < include.count else {
                return nil
            }
            
            return [
                URLQueryItem(name: "include", value: include.reduce("") {
                    $0 + ",\($1.rawValue)"
                    }.trimmingCharacters(in: CharacterSet(charactersIn: ",")))
            ]
        default:
            return nil
        }
    }
    
    private var bodyContent: JSON? {
        switch self {
        case .addItem(_, let productID, let quantity):
            return [
                "data" : [
                    "type" : "cart_item",
                    "id" : productID,
                    "quantity" : quantity
                ]
            ]
        case .addCustomItem(let customItem, _):
            return [
                "data" : [
                    "type" : "custom_item",
                    "name" : customItem.name,
                    "description" : customItem.description,
                    "sku" : customItem.sku,
                    "quantity" : "\(customItem.quantity)",
                    "price" : [
                        "amount" : "\(customItem.price)"
                    ]
                ]
            ]
        case .checkout(_, let customer, let billingAddress, let shippingAddress):
            return [
                "data" : [
                    "customer" : customer.dictionaryRepresentation,
                    "shipping_address" : shippingAddress.dictionaryRepresentation(includeInstructions: true),
                    "billing_address" : billingAddress.dictionaryRepresentation(includeInstructions: false)
                ]
            ]
        case .payment(_, let paymentMethod):
            return ["data" : paymentMethod.dictionary]
        case .updateQuantity(_, let itemID, let quantity):
            return [
                "data" : [
                    "type" : "cart_item",
                    "id" : itemID,
                    "quantity" : quantity
                ]
            ]
        default:
            return nil
        }
    }
    
    private var headers: [String: String] {
        var headerDictionary = ["Accept" : "application/json"]
        
        if let authToken = Router.auth.token {
            headerDictionary["Authorization"] = "Bearer " + authToken
        }
        
        headerDictionary["X-MOLTIN-LANGUAGE"] = Moltin.language
        headerDictionary["X-MOLTIN-LOCALE"] = Moltin.locale
        headerDictionary["X-MOLTIN-CURRENCY"] = Moltin.currencyCode
        
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
