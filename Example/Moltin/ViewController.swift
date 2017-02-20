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
        
//        Moltin.product.list { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let result):
//                print(result)
//            }
//        }
//        
//        Moltin.currency.list { result in
//            print(result)
//        }
        
        let query = MoltinQuery(offset: nil, limit: 10, sort: nil, filter: nil, include: [.categories])

        Moltin.product.list(withQuery: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let products):
                products.forEach { print($0.name) }
            }
        }
        
//        Moltin.collection.list(withQuery: query) { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let collections):
//                collections.forEach { print($0.name) }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
