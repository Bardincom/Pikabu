//
//  PostImageCollectionViewCell.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 30.11.2020.
//

import UIKit

class PostImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var imagePost: UIImageView!

    func setupImages(_ image: String) {
        imagePost.kf.setImage(with: URL(string: image))
    }
}
