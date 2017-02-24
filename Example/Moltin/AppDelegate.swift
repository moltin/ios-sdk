//
//  AppDelegate.swift
//  Moltin
//
//  Created by Oliver Foggin on 02/14/2017.
//  Copyright (c) 2017 Oliver Foggin. All rights reserved.
//

import UIKit

import Moltin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Moltin.clientID = "B7H9MthG8jYduHlGrmKnqO613XCEvsrZ6bwSYo1TWM"
        
        CustomStyles.configure()
        
        return true
    }
}

