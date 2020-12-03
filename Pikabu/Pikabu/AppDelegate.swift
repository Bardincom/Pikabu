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

        if #available(iOS 13.0, *) {
            feedViewController.tabBarItem.image = SFIcons.houseFill
        } else {
            feedViewController.tabBarItem.image = Icons.houseFill
        }
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)


        let favoritePostsViewController = FavoritePostsViewController()
        if #available(iOS 13.0, *) {
            favoritePostsViewController.tabBarItem.image = SFIcons.crownFill
        } else {
            favoritePostsViewController.tabBarItem.image = Icons.starFill
        }
        let favoritePostsNavigationController = UINavigationController(rootViewController: favoritePostsViewController)

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Color.styleColor
        tabBarController.setViewControllers([feedNavigationController, favoritePostsNavigationController], animated: false)

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

