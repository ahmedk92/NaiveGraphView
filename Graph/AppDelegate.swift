//
//  AppDelegate.swift
//  Graph
//
//  Created by Ahmed Khalaf on 4/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        makeWindow()
        return true
    }
    
    private func makeWindow() {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}

