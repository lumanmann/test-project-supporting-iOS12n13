//
//  AppDelegate.swift
//  ProjectSupportingIOS12n13
//
//  Created by Natalie Ng on 2019/11/13.
//  Copyright © 2019 Natalie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }



}

