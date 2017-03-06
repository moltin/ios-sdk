//
//  UIButton.swift
//  Moltin
//
//  Created by Oliver Foggin on 06/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

extension UIButton {
    static func moltinButton(withTitle title: String, target: Any?, selector: Selector) -> UIButton {
        let b = UIButton(type: UIButtonType.system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(title, for: .normal)
        b.tintColor = .white
        b.backgroundColor = UIColor(red:0.62, green:0.49, blue:0.75, alpha:1.00)
        b.heightAnchor.constraint(equalToConstant: 44).isActive = true
        b.layer.cornerRadius = 22
        b.layer.masksToBounds = true
        b.addTarget(target, action: selector, for: .touchUpInside)
        return b
    }
}
