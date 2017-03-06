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
    var isRequired = true
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red:0.23, green:0.29, blue:0.33, alpha:1.00)
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.font = .montserratBold(size: 14)
        textField.textColor = .white
        addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setPlaceholder(_ placeholder: String) {
        textField.attributedPlaceholder = NSMutableAttributedString(string: placeholder,
                                                                    attributes: [NSForegroundColorAttributeName: UIColor(red:0.39, green:0.46, blue:0.51, alpha:1.00),
                                                                                 NSFontAttributeName: UIFont.montserratBold(size: 14)])
    }
    
}

extension EntryView: Validatable {
    
    func isValid() -> Bool {
        if !isRequired {
            return true
        }
        
        guard let text = textField.text else {
            return false
        }
        
        return text.characters.count > 0
    }
    
    func displayValidity() {
        if isValid() {
            layer.borderColor = UIColor.clear.cgColor
        } else {
            layer.borderColor = UIColor.red.cgColor
        }
    }
    
}

class CollectAddressViewController: UIViewController {
    
    let firstNameEntryView = EntryView()
    let lastNameEntryView = EntryView()
    let companyNameEntryView = EntryView()
    let lineOneEntryView = EntryView()
    let lineTwoEntryView = EntryView()
    let countyEntryView = EntryView()
    let postcodeEntryView = EntryView()
    let countryEntryView = EntryView()
    let shippingInstructionsEntryView = EntryView()
    let submitButton = UIButton(type: .custom)
    
    var validatableFields: [Validatable] = []
    
    let nameStackView = UIStackView()
    let countyPostcodeStackView = UIStackView()
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
        
        view.backgroundColor = UIColor(red:0.17, green:0.22, blue:0.26, alpha:1.00)
        
        firstNameEntryView.setPlaceholder("First Name")
        lastNameEntryView.setPlaceholder("Last Name")
        companyNameEntryView.setPlaceholder("Company Name (Optional)")
        companyNameEntryView.isRequired = false
        
        lineOneEntryView.setPlaceholder("Line One")
        lineTwoEntryView.setPlaceholder("Line Two (Optional)")
        lineTwoEntryView.isRequired = false
        
        countyEntryView.setPlaceholder("County")
        postcodeEntryView.setPlaceholder("Postcode")
        countryEntryView.setPlaceholder("Country")
        shippingInstructionsEntryView.setPlaceholder("Shipping Instructions (Optional)")
        shippingInstructionsEntryView.isRequired = false
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitAddress), for: .touchUpInside)
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.distribution = .fillEqually
        nameStackView.spacing = 20
        nameStackView.addArrangedSubviews(subviews: [firstNameEntryView,
                                                     lastNameEntryView])
        
        countyPostcodeStackView.translatesAutoresizingMaskIntoConstraints = false
        countyPostcodeStackView.distribution = .fillEqually
        countyPostcodeStackView.spacing = 20
        countyPostcodeStackView.addArrangedSubviews(subviews: [countyEntryView,
                                                               postcodeEntryView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubviews(subviews: [nameStackView,
                                                 companyNameEntryView,
                                                 lineOneEntryView,
                                                 lineTwoEntryView,
                                                 countyPostcodeStackView,
                                                 countryEntryView,
                                                 shippingInstructionsEntryView,
                                                 submitButton,
                                                 ])
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        
        validatableFields = [firstNameEntryView,
                             lastNameEntryView,
                             lineOneEntryView,
                             lineTwoEntryView,
                             countyEntryView,
                             postcodeEntryView,
                             countryEntryView]
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
                              companyName: companyNameEntryView.textField.text!,
                              line1: lineOneEntryView.textField.text!,
                              line2: lineTwoEntryView.textField.text!,
                              postcode: postcodeEntryView.textField.text!,
                              county: countyEntryView.textField.text!,
                              country: countryEntryView.textField.text!,
                              shippingInstructions: "Don't get wet")
        addressCompletion(address)
    }
    
}

extension UIStackView {
    func addArrangedSubviews(subviews: [UIView]) {
        subviews.forEach() { addArrangedSubview($0) }
    }
}
