//
//  ViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 02/14/2017.
//  Copyright (c) 2017 Oliver Foggin. All rights reserved.
//

import UIKit
import Moltin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let query = MoltinQuery(offset: nil, limit: nil, sort: nil, filter: nil, include: [.categories])
//
//        Moltin.product.list(withQuery: query) { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let products):
//                products.forEach { print($0.name) }
//            }
//        }
        
        Moltin.currency.list { _ in }
        
//        Moltin.category.getTree { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let products):
//                products.forEach { print($0.name) }
//            }
//        }
        
//        Moltin.collection.list { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let products):
//                products.forEach { print($0.name) }
//            }
//        }
        
//        Moltin.cart.getNewCart {
//            result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let cart):
//                print(cart?.id)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
