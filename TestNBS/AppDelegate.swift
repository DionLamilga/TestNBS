//
//  AppDelegate.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = TabbarController()
            window?.makeKeyAndVisible()
            return true
        }
}

