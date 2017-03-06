//
//  EntryView.swift
//  Moltin
//
//  Created by Oliver Foggin on 06/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

protocol Validatable {
    func isValid() -> Bool
    func displayValidity()
}

class EntryView: UIView {
    
    let textField = UITextField()
    let isRequired: Bool
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(isRequired: Bool = true) {
        self.isRequired = isRequired
        
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
        textField.attributedPlaceholder =
            NSMutableAttributedString(string: placeholder,
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
