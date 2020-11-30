//
//  UIViewController+Extension.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 30.11.2020.
//

import UIKit

extension UIViewController {
    func setupNavigationBar(withTitle title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

}
