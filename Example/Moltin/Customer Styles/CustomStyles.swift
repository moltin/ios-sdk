//
//  CustomStyles.swift
//  Moltin
//
//  Created by Oliver Foggin on 24/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

struct CustomStyles {
    static func configure() {
        navigationBars()
    }
    
    static func navigationBars() {
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor(red:0.18, green:0.22, blue:0.25, alpha:1.00)
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.montserratRegular(size: 21), NSForegroundColorAttributeName: UIColor.white]
    }
}
