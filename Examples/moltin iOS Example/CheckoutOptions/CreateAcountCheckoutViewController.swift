//
//  CreateAccountCheckoutViewController.swift
//  moltin iOS
//
//  Created by George FitzGibbons on 5/3/18.
//  Copyright © 2018 George FitzGibbons. All rights reserved.
//

import UIKit
import moltin

class CreateAccountCheckoutViewController: UIViewController {

    
    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))


    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func showOrderStatus(withSuccess success: Bool, withError error: Error? = nil) {
        let title = success ? "Order paid!" : "Order error"
        let message = success ? "Complete! It Worked" : error?.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler:  { (action) in
            self.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

