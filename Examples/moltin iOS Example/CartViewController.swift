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
    @IBOutlet weak var cartTotalLabel: UILabel!
    @IBOutlet weak var buyNowButtonLabel: UIButton!
    
    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))

    var cartItems: [CartItem] = []
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buyNowButtonLabel.setTitle("Buy Now", for: .normal)
        tableView.register(UINib(nibName: "CheckoutItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckoutCell")
        self.tableView.rowHeight = 120.0
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        //Handle totals some way better
        let total  = cartItems.map { $0.meta.displayPrice.withTax.value.amount }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: (total.reduce(0, +)/100) as NSNumber) ?? "FREE"
        self.cartTotalLabel.text = priceString
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
        let message = success ? "Complete! It Worked" : error?.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutItemTableViewCell
        let cartItem = self.cartItems[indexPath.row]

        cell.qtyLabel.text = String(cartItem.quantity)
        cell.priceNameLabel.text = cartItem.meta.displayPrice.withTax.value.formatted
        cell.productNameLabel.text = cartItem.name
        cell.productImage.load(urlString: self.product?.mainImage?.link["href"])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = "Click checkout to test order"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove from cart"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
