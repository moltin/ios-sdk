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
    let completion: (Result<Order?>) -> ()
    
    var customer: Customer?
    var billingAddress: Address?
    var shippingAddress: Address?
    
    init(cartID: String, navigationController: UINavigationController, completion: @escaping (Result<Order?>) -> ()) {
        self.cartID = cartID
        self.navigationController = navigationController
        self.completion = completion
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
            self.checkout()
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func checkout() {
        guard let customer = customer,
            let shippingAddress = shippingAddress,
            let billingAddress = billingAddress else {
                self.completion(Result.failure(error: NSError(domain: "", code: 1, userInfo: nil)))
                return
        }
        
        Moltin.checkout.checkout(cartWithID: cartID, forCustomer: customer, withBillinagAddress: billingAddress, andShippingAddress: shippingAddress, completion: completion)
    }
}
