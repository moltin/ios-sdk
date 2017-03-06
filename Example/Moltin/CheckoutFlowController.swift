//
//  CheckoutFlowController.swift
//  Moltin
//
//  Created by Oliver Foggin on 06/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

import Moltin

enum AddressType {
    case shipping
    case billing
}

class CollectAddressViewController: UIViewController {
    init(addressType type: AddressType, completion: @escaping (Address) -> ()) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectCustomerViewController: UIViewController {
    init(completion: @escaping (Customer) -> ()) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckoutFlowController {
    let cartID: String
    let navigationController: UINavigationController
    
    var customer: Customer?
    var billingAddress: Address?
    var shippingAddress: Address?
    
    init(cartID: String, navigationController: UINavigationController) {
        self.cartID = cartID
        self.navigationController = navigationController
    }
    
    func start() {
        presentBillingAddressController()
    }
    
    func presentBillingAddressController() {
        let controller = CollectAddressViewController(addressType: .billing) {
            address in
            self.billingAddress = address
            self.presentShippingAddressController()
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentShippingAddressController() {
        let controller = CollectAddressViewController(addressType: .shipping) {
            address in
            self.shippingAddress = address
            
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentCustomerController() {
        let controller = CollectCustomerViewController() {
            customer in
            self.customer = customer
            
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
