//
//  UICollectionView+Extension.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit

extension UICollectionView {

    func dequeue <T: UICollectionViewCell>(cell identifier: T.Type, for indexPath: IndexPath) -> T {
        let identifierString = String(describing: identifier)
        return dequeueReusableCell(withReuseIdentifier: identifierString, for: indexPath) as! T
    }

    func dequeue <T: UICollectionReusableView>(supplementaryView identifier: T.Type, kind: String, for indexPath: IndexPath) -> T {
        let identifierString = String(describing: identifier)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifierString, for: indexPath) as! T
    }
}

extension UICollectionView {

    func register <T: UICollectionViewCell>(nibCell identifier: T.Type) {
        let identifierString = String(describing: identifier)
        let nib = UINib(nibName: identifierString, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifierString)
    }

    func register <T: UICollectionReusableView>(nibSupplementaryView identifier: T.Type, kind: String) {
        let identifierString = String(describing: identifier)
        let nib = UINib(nibName: identifierString, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifierString)
    }
}
