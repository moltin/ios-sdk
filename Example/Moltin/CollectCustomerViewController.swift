//
//  CollectCustomerViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 06/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

import Moltin

class CollectCustomerViewController: UIViewController {
    let nameView = EntryView()
    let emailView = EntryView()
    let completion: (Customer) -> ()
    let validatableFields: [Validatable]
    
    init(completion: @escaping (Customer) -> ()) {
        self.completion = completion
        validatableFields = [nameView, emailView]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.17, green:0.22, blue:0.26, alpha:1.00)
        nameView.setPlaceholder("Name")
        emailView.setPlaceholder("Email")
        
        let button = UIButton.moltinButton(withTitle: "Submit", target: self, selector: #selector(submitCustomer))
        
        let stackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [nameView, emailView, button])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            s.isLayoutMarginsRelativeArrangement = true
            s.axis = .vertical
            s.spacing = 10
            return s
        }()
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func submitCustomer() {
        
        validatableFields.forEach { $0.displayValidity() }
        
        let invalidFields = validatableFields.filter { !$0.isValid() }
        
        if invalidFields.count > 0 {
            return
        }
        
        let customer = Customer(name: nameView.textField.text!, email: emailView.textField.text!)
        
        completion(customer)
    }
}
