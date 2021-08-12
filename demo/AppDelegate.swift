//
//  AppDelegate.swift
//  demo
//
//  Created by 甘世清 on 2021/6/18.
//

import UIKit
import AMapFoundationKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

 var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        AMapServices.shared().apiKey = MapAppKey
        
        return true
    }

  


}

