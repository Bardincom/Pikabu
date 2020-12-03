//
//  Icons.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import UIKit

enum Icons {
    static let chevronLeft = UIImage(named: "chevronLeft")
    static let starFill = UIImage(named: "starFill")
    static let houseFill = UIImage(named: "houseFill")
    static let star = UIImage(named: "star")
}

@available(iOS 13.0, *)
enum SFIcons {
    static let chevronLeft = UIImage(systemName: "chevron.left", withConfiguration: Configuration.medium)
    static let crownFill = UIImage(systemName: "crown.fill", withConfiguration: Configuration.medium)
    static let crown = UIImage(systemName: "crown", withConfiguration: Configuration.medium)
    static let houseFill = UIImage(systemName: "house.fill", withConfiguration: Configuration.medium)
}

@available(iOS 13.0, *)
enum Configuration {
    static let black = UIImage.SymbolConfiguration(weight: .black)
    static let bold = UIImage.SymbolConfiguration(weight: .bold)
    static let heavy = UIImage.SymbolConfiguration(weight: .heavy)
    static let light = UIImage.SymbolConfiguration(weight: .light)
    static let medium = UIImage.SymbolConfiguration(weight: .medium)
    static let regular = UIImage.SymbolConfiguration(weight: .regular)
    static let semibold = UIImage.SymbolConfiguration(weight: .semibold)
    static let thin = UIImage.SymbolConfiguration(weight: .thin)
}
