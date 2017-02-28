//
//  CartViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 28/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    static var cartReference: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cart"
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(close))
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
}
