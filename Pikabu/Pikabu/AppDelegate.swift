//
//  AppDelegate.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 25.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        assembly()
        return true
    }

}

private extension AppDelegate {

    func assembly() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = ViewController()
//        rootViewController.title = Title.weatherViewControllerTitle
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

