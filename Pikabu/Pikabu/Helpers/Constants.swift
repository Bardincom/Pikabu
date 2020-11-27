//
//  Constants.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit

@available(iOS 13.0, *)
public enum Constants {
    static let symbolWeight = UIImage.SymbolConfiguration(weight: .regular)
    static let cornerRadiusButton: CGFloat = 5
}

@available(iOS 13.0, *)
public enum Buttons {
    static let feed = UIImage(systemName: "house.fill", withConfiguration: Constants.symbolWeight)
    static let newPost = UIImage(systemName: "plus.app.fill", withConfiguration: Constants.symbolWeight)
    static let profile = UIImage(systemName: "person.fill", withConfiguration: Constants.symbolWeight)
    static let back = UIImage(systemName: "chevron.left", withConfiguration: Constants.symbolWeight)
}

enum Icon {
    static let feed = UIImage(named: "")
}
