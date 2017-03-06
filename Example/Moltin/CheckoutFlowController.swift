//
//  CheckoutFlowController.swift
//  Moltin
//
//  Created by Oliver Foggin on 06/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

import Moltin

class CollectCustomerViewController: UIViewController {
    let completion: (Customer) -> ()
    
    init(completion: @escaping (Customer) -> ()) {
        self.completion = completion
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        let button: UIButton = {
            let b = UIButton(type: .system)
            b.translatesAutoresizingMaskIntoConstraints = false
            b.setTitle("Complete", for: .normal)
            b.addTarget(self, action: #selector(complete), for: .touchUpInside)
            return b
        }()
        
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    func complete() {
        let customer = Customer(name: "Oliver Foggin", email: "oliverfoggin@me.com")
        completion(customer)
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
        presentCustomerController()
    }
    
    func presentCustomerController() {
        let controller = CollectCustomerViewController() {
            customer in
            self.customer = customer
            self.presentBillingAddressController()
        }
        navigationController.pushViewController(controller, animated: true)
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
