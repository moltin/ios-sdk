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
        
        Moltin.product.list { result in
            switch result {
            case .failuer(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

