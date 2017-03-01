//
//  CartStepperView.swift
//  Moltin
//
//  Created by Oliver Foggin on 01/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CartStepperView: UIControl {
    var value: UInt {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    private let valueLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.montserratRegular(size: 16)
        l.textAlignment = .center
        return l
    }()
    
    private lazy var plusButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor(red:0.39, green:0.46, blue:0.51, alpha:1.00)
        b.setTitle("+", for: .normal)
        b.titleLabel?.textColor = .white
        b.titleLabel?.font = UIFont.montserratHairline(size: 16)
        b.addTarget(self, action: #selector(increment), for: .touchUpInside)
        b.widthAnchor.constraint(equalTo: b.heightAnchor).isActive = true
        return b
    }()
    
    private lazy var minusButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor(red:0.39, green:0.46, blue:0.51, alpha:1.00)
        b.setTitle("-", for: .normal)
        b.titleLabel?.textColor = .white
        b.titleLabel?.font = UIFont.montserratHairline(size: 16)
        b.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        b.widthAnchor.constraint(equalTo: b.heightAnchor).isActive = true
        return b
    }()
    
    init(initialValue: UInt) {
        value = initialValue
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        valueLabel.text = "\(value)"
        
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        backgroundColor = UIColor(red:0.13, green:0.17, blue:0.20, alpha:1.00)
        
        let stackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [minusButton, valueLabel, plusButton])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.spacing = 8
            s.axis = .horizontal
            s.distribution = .fill
            s.alignment = .fill
            return s
        }()
        
        addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func increment() {
        value += 1
        sendActions(for: .valueChanged)
    }
    
    @objc private func decrement() {
        guard value > 0 else {
            return
        }
        
        value -= 1
        sendActions(for: .valueChanged)
    }
}
