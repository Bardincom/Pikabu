//
//  TableViewCell.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    @IBOutlet private var userName: UILabel!
    @IBOutlet private var avataImage: UIImageView!
    @IBOutlet private var titlePost: UILabel!
    @IBOutlet private var bodyPost: UILabel!
    @IBOutlet private var imagePost: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupFonts()
        avataImage.layer.cornerRadius = avataImage.frame.height / 2
    }

    func setupPost(_ post: TableViewCellViewModelType) {
        imagePost.isHidden = true
        titlePost.text = post.title
        bodyPost.text = post.body
        guard let image = post.images?.first else { return }
        imagePost.kf.setImage(with: URL(string: image))
        imagePost.isHidden = false
    }

    private func setupFonts() {
        titlePost.font = Fonts.titleFont
        bodyPost.font = Fonts.bodyFont
        userName.font = Fonts.userNameFont
    }
}
