//
//  CollectAddressViewController.swift
//  Moltin
//
//  Created by Matthew Hallatt on 03/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Moltin
import UIKit

enum AddressType: Int {
    case shipping
    case billing
}

protocol Validatable {
    func isValid() -> Bool
    func displayValidity()
}

class EntryView: UIView {
    
    let textField = UITextField()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.textColor = .lightGray
        textField.tintColor = .lightGray
        addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

extension EntryView: Validatable {
    
    func isValid() -> Bool {
        return true
    }
    
    func displayValidity() {
        if isValid() {
            layer.borderColor = UIColor.red.cgColor
        } else {
            layer.borderColor = UIColor.green.cgColor
        }
    }
    
}

class CollectAddressViewController: UIViewController {
    
    let lineOneEntryView = EntryView()
    let lineTwoEntryView = EntryView()
    let submitButton = UIButton(type: .custom)
    
    let stackView = UIStackView()
    
    let addressType: AddressType
    
    let addressCompletion: (Address) -> ()
    
    init(addressType type: AddressType, completion: @escaping (Address) -> ()) {
        self.addressType = type
        self.addressCompletion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        lineOneEntryView.translatesAutoresizingMaskIntoConstraints = false
        lineOneEntryView.textField.placeholder = "Line One"
        lineOneEntryView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        lineTwoEntryView.translatesAutoresizingMaskIntoConstraints = false
        lineTwoEntryView.textField.placeholder = "Line Two (Optional)"
        lineTwoEntryView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitAddress(sender:)), for: .touchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubviews(subviews: [
            lineOneEntryView,
            lineTwoEntryView,
            submitButton,
            ])
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func submitAddress(sender: UIButton) {
        let address = Address(firstName: "Matt",
                              lastName: "Hallatt",
                              companyName: "Hallatt Co",
                              line1: "Line 1",
                              line2: "Line 2",
                              postcode: "POST CDE",
                              county: "County",
                              country: "Country",
                              shippingInstructions: "Don't get wet")
        addressCompletion(address)
    }
    
}

extension UIStackView {
    func addArrangedSubviews(subviews: [UIView]) {
        subviews.forEach() { addArrangedSubview($0) }
    }
}
