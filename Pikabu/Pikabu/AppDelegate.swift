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
        feedViewController.tabBarItem.image = Icons.houseFill
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)

        let favoritePostsViewController = FavoritePostsViewController()
        favoritePostsViewController.tabBarItem.image = Icons.crownFill
        let favoritePostsNavigationController = UINavigationController(rootViewController: favoritePostsViewController)

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Color.styleColor
        tabBarController.setViewControllers([feedNavigationController, favoritePostsNavigationController], animated: false)

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

