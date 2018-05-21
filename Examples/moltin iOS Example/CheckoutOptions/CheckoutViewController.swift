//
//  CheckoutViewController.swift
//  moltin iOS
//
//  Created by George FitzGibbons on 5/3/18.
//  Copyright © 2018 George FitzGibbons. All rights reserved.
//

import UIKit
import moltin

class CheckoutViewController: UIViewController {
    @IBOutlet weak var fullnameTextInput: UITextField!
    @IBOutlet weak var cardNumberTextInput: UITextField!
    @IBOutlet weak var expirationDateTextInput: UITextField!
    @IBOutlet weak var ctaButtonLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underlyingScreenCapture: UIImageView!
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var cvvTextInput: UITextField!
    
    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))

    var screenCapture: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.underlyingScreenCapture.image = screenCapture
        //Style card input
        self.titleLabel.text = "Generic 1-step Checkout"
        self.view.backgroundColor = UIColor(red:237, green:239, blue:240, alpha:1.0)
        checkoutView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ctaButtonPressed(_ sender: Any) {
        let customer = Customer(withEmail: "craig.tweedy@moltin.com", withName: "Craig Tweedy")
        let address = Address(withFirstName: "Craig", withLastName: "Tweedy")
        address.line1 = "1 Silicon Way"
        address.county = "Somewhere"
        address.country = "Fiction"
        address.postcode = "NE1 1AA"
        self.moltin.cart.checkout(cart: AppDelegate.cartID, withCustomer: customer, withBillingAddress: address, withShippingAddress: nil) { (result) in
            switch result {
            case .success(let order):
                self.payForOrder(order)
            default: break
            }
        }
    }
    
    func payForOrder(_ order: Order) {
        let fullName = self.fullnameTextInput.text ?? ""
        var nameComponents = fullName.components(separatedBy: " ")
        var firstName: String? = ""
        var lastName: String? = ""
        //What checks are common
        if(nameComponents.count > 0)
        {
            firstName = nameComponents.removeFirst()
            lastName = nameComponents.joined(separator: " ")
        }
        
        let fullDate = self.expirationDateTextInput.text ?? ""
        var dateComponents = fullDate.components(separatedBy: "/")
        var month: String? = ""
        var year: String? = ""
        if(dateComponents.count > 0)
        {
            month = dateComponents.removeFirst()
            year = dateComponents.joined(separator: " ")
        }
        //Manual Example
//        let paymentMethod = ManuallyAuthorizePayment()
//        self.moltin.cart.pay(forOrderID: order.id, withPaymentMethod: paymentMethod) { (result) in
//            switch result {
//            case .success:
//                DispatchQueue.main.async {
//                    print("manual worked")
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.showOrderStatus(withSuccess: false, withError: error)
//                }
//            }
//        }
        
        //Stripe
        let paymentMethodStripe: PaymentMethod = StripeCard(withFirstName: firstName ?? "",
                                                      withLastName: lastName ?? "",
                                                      withCardNumber: self.cardNumberTextInput.text ?? "",
                                                      withExpiryMonth: month ?? "",
                                                      withExpiryYear: year ?? "",
                                                      withCVVNumber: self.cvvTextInput.text ?? "")
        moltin.cart.pay(forOrderID: order.id,
                        withPaymentMethod: paymentMethodStripe) { (result) in
                            switch result {
                            case .success(let status):
                                DispatchQueue.main.async {
                                    self.showOrderStatus(withSuccess: true)
                                    print("Paid for order: \(status)")
                                }
                            case .failure(let error):
                                DispatchQueue.main.async {
                                    print("Could not pay for order: \(error)")
                                }
                            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        let controller = AccountCheckoutViewController.init(nibName: "AccountCheckoutViewController", bundle: nil)
        
        self.present(controller, animated: false, completion: nil)

    }
    
    private func showOrderStatus(withSuccess success: Bool, withError error: Error? = nil) {
        let title = success ? "Order paid!" : "Order error"
        let message = success ? "Complete! It Worked" : error?.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler:  { (action) in
            self.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

