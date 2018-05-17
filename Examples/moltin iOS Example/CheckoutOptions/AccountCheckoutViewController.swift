//
//  AccountCheckoutViewController.swift
//  moltin iOS Example
//
//  Created by George FitzGibbons on 5/15/18.
//

import UIKit
import moltin

class AccountCheckoutViewController: UIViewController {
    
    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))

    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var emailFieldLabel: UILabel!
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var nameFieldLabel: UILabel!
    @IBOutlet weak var addressTextInput: UITextField!
    @IBOutlet weak var addressFieldLabel: UILabel!
    @IBOutlet weak var cityTextInput: UITextField!
    @IBOutlet weak var cityFieldLabel: UILabel!
    @IBOutlet weak var zipTextInput: UITextField!
    @IBOutlet weak var zipFieldLabel: UILabel!
    @IBOutlet weak var countryTextInput: UITextField!
    @IBOutlet weak var countryFieldLabel: UILabel!
    @IBOutlet weak var ccNumberInput: UITextField!
    @IBOutlet weak var ccMMYYTextInput: UITextField!
    @IBOutlet weak var ccCVVTextInput: UITextField!

    @IBOutlet weak var ctaButtonLabel: UIButton!
    
    //fields
    var firstName: String? = ""
    var lastName: String? = ""
    var month: String? = ""
    var year: String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: field validation stuff
        let fullName = self.nameTextInput.text ?? ""
        var nameComponents = fullName.components(separatedBy: " ")
        if(nameComponents.count > 0)
        {
            firstName = nameComponents.removeFirst()
            lastName = nameComponents.joined(separator: " ")
        }
        let fullDate = self.ccMMYYTextInput.text ?? ""
        var dateComponents = fullDate.components(separatedBy: "/")
        if(dateComponents.count > 0)
        {
            month = dateComponents.removeFirst()
            year = dateComponents.joined(separator: " ")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func showOrderStatus(withSuccess success: Bool, withError error: Error? = nil) {
        let title = success ? "Order paid!" : "Order error"
        let message = success ? "Complete! It Worked" : error?.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler:  { (action) in
            self.dismiss(animated: false, completion: nil)
            //TODO: Order confirmation Page

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func ctaButtonPressed(_ sender: Any) {
        let customer = Customer(withEmail: emailTextInput.text, withName: nameTextInput.text)
        let address = Address(withFirstName: self.firstName ?? "", withLastName: self.lastName ?? "")
        address.line1 = addressTextInput.text
        address.county = cityTextInput.text
        address.country = countryTextInput.text
        address.postcode = zipTextInput.text
        self.moltin.cart.checkout(cart: AppDelegate.cartID, withCustomer: customer, withBillingAddress: address, withShippingAddress: nil) { (result) in
            switch result {
            case .success(let order):
                self.payForOrder(order)
            default: break
            }
        }
    }
    
    
    func payForOrder(_ order: Order) {
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
                                                            withCardNumber: self.ccNumberInput.text ?? "",
                                                            withExpiryMonth: month ?? "",
                                                            withExpiryYear: year ?? "",
                                                            withCVVNumber: self.ccCVVTextInput.text ?? "")
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
    
    @IBAction func backBarPressed(_ sender: Any) {
        let controller = CartViewController.init(nibName: "CartViewController", bundle: nil)
        
        self.present(controller, animated: false, completion: nil)
    }
    //TODO: Public helpers move somewhere
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 10
    }
}

