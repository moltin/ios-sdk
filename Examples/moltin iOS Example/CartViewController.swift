//
//  CartViewController.swift
//  moltin iOS Example
//
//  Created by Craig Tweedy on 03/04/2018.
//

import UIKit
import moltin

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))

    var cartItems: [CartItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.moltin.cart.items(forCartID: AppDelegate.cartID) { (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.cartItems = result.data ?? []
                    self.tableView.reloadData()
                }
            default: break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkout(_ sender: Any) {
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
        let paymentMethod = ManuallyAuthorizePayment()
        self.moltin.cart.pay(forOrderID: order.id, withPaymentMethod: paymentMethod) { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.showOrderStatus(withSuccess: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showOrderStatus(withSuccess: false, withError: error)
                }
            }
        }
    }

    func showOrderStatus(withSuccess success: Bool, withError error: Error? = nil) {
        let title = success ? "Order paid!" : "Order error"
        let message = success ? "Complete!" : error?.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }

        let cartItem = self.cartItems[indexPath.row]
        cell.textLabel?.text = cartItem.name

        return cell
    }
}
