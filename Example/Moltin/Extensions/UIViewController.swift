//
//  UIViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 28/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
    func setCartBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "cart"), style: .done, target: self, action: #selector(showCart))
    }
    
    func showCart() {
        let controller = CartViewController()
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    func showLoadingScreen(text: String, completion: (() -> ())? = nil) {
        let controller: UIViewController = navigationController ?? self
        
        controller.present(LoadingViewController(text: text), animated: true, completion: completion)
    }
    
    func hideLoadingScreen(completion: (() -> ())? = nil) {
        let controller: UIViewController = navigationController ?? self
        
        controller.dismiss(animated: true, completion: completion)
    }
}
