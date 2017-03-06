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

class CollectAddressViewController: UIViewController {
    
    let firstNameEntryView = EntryView()
    let lastNameEntryView = EntryView()
    let companyNameEntryView = EntryView(isRequired: false)
    let lineOneEntryView = EntryView()
    let lineTwoEntryView = EntryView(isRequired: false)
    let countyEntryView = EntryView()
    let postcodeEntryView = EntryView()
    let countryEntryView = EntryView()
    let shippingInstructionsEntryView = EntryView(isRequired: false)
    
    let validatableFields: [Validatable]
    
    let addressType: AddressType
    
    let addressCompletion: (Address) -> ()
    
    init(addressType type: AddressType, completion: @escaping (Address) -> ()) {
        self.addressType = type
        self.addressCompletion = completion
        
        validatableFields = [firstNameEntryView,
                             lastNameEntryView,
                             lineOneEntryView,
                             lineTwoEntryView,
                             countyEntryView,
                             postcodeEntryView,
                             countryEntryView]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = addressType == .billing ? "Billing Address" : "Shipping Address"
        
        view.backgroundColor = UIColor(red:0.17, green:0.22, blue:0.26, alpha:1.00)
        
        firstNameEntryView.setPlaceholder("First Name")
        lastNameEntryView.setPlaceholder("Last Name")
        
        companyNameEntryView.setPlaceholder("Company Name (Optional)")
        
        lineOneEntryView.setPlaceholder("Line One")
        lineTwoEntryView.setPlaceholder("Line Two (Optional)")
        
        countyEntryView.setPlaceholder("County")
        postcodeEntryView.setPlaceholder("Postcode")
        countryEntryView.setPlaceholder("Country")
        shippingInstructionsEntryView.setPlaceholder("Shipping Instructions (Optional)")
        
        let nameStackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [firstNameEntryView,lastNameEntryView])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.distribution = .fillEqually
            s.spacing = 20
            return s
        }()
        
        let countyPostcodeStackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [countyEntryView, postcodeEntryView])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.distribution = .fillEqually
            s.spacing = 20
            return s
        }()
        
        let submitButton = UIButton.moltinButton(withTitle: "Submit", target: self, selector: #selector(submitAddress))
        
        let stackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [nameStackView, companyNameEntryView, lineOneEntryView, lineTwoEntryView, countyPostcodeStackView, countryEntryView, submitButton])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.axis = .vertical
            s.spacing = 10
            if addressType == .shipping {
                s.insertArrangedSubview(shippingInstructionsEntryView, at: 6)
            }
            return s
        }()
        
        view.addSubview(stackView)
        
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
    }
    
    func submitAddress() {
        
        validatableFields.forEach { field in
            field.displayValidity()
        }
        
        let invalidCount = validatableFields.reduce(0) { result, item in
            result + (item.isValid() ? 0 : 1)
        }
        
        if invalidCount > 0 {
            return
        }
        
        let address = Address(firstName: firstNameEntryView.textField.text!,
                              lastName: lastNameEntryView.textField.text!,
                              companyName: companyNameEntryView.textField.text,
                              line1: lineOneEntryView.textField.text!,
                              line2: lineTwoEntryView.textField.text,
                              postcode: postcodeEntryView.textField.text!,
                              county: countyEntryView.textField.text!,
                              country: countryEntryView.textField.text!,
                              shippingInstructions: shippingInstructionsEntryView.textField.text)
        addressCompletion(address)
    }
    
}

extension UIStackView {
    func addArrangedSubviews(subviews: [UIView]) {
        subviews.forEach() { addArrangedSubview($0) }
    }
}
