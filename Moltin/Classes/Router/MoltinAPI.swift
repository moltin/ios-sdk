//
//  MoltinAPI.swift
//  Moltin
//
//  Created by Oliver Foggin on 14/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Alamofire

struct MoltinAPI {
    static func jsonRequest(request: URLRequestConvertible, completion: @escaping (DataResponse<Any>) -> Void) {
        Router.auth.authenticate {
            Alamofire.request(request).responseJSON(completionHandler: completion)
        }
    }
}
