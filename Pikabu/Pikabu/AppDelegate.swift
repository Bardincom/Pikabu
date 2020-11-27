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

        let feedViewController = FeedViewController()
//        feedViewController.tabBarItem.image = Asset.IconAssets.feed.image
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)



        let tabBarController = UITabBarController()
//        tabBarController.tabBar.backgroundColor = Asset.ColorAssets.viewBackground.color
        tabBarController.setViewControllers([feedNavigationController], animated: false)

//        rootViewController.title = Title.weatherViewControllerTitle

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

