//
//  AppDelegate.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(
            rootViewController: mainViewController)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        return true
    }
}

