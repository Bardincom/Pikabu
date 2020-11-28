//
//  TableViewCell.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet private var userName: UILabel!
    @IBOutlet private var avataImage: UIImageView!
    @IBOutlet private var titlePost: UILabel!
    @IBOutlet private var bodyPost: UILabel!
    @IBOutlet private var imagePost: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!

    public var onAddedStorage: PostBlock?

    private var post: Post? {
        didSet {
            imagePost.isHidden = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFonts()
        setupUI()
    }

    @IBAction func pushFavoriteButton(_ sender: UIButton) {
        onAddedStorage?(post)
    }
    // MARK: - Methods

    func setupPost(_ post: Post?) {
        self.post = post
        titlePost.text = post?.title
        bodyPost.text = post?.body
        guard let image = post?.images?.first else { return }
        imagePost.kf.setImage(with: URL(string: image))
        imagePost.isHidden = false
    }

    private func setupFonts() {
        titlePost.font = Fonts.titleFont
        bodyPost.font = Fonts.bodyFont
        userName.font = Fonts.userNameFont
    }

    private func setupUI() {
        avataImage.layer.cornerRadius = avataImage.frame.height / 2
        favoriteButton.setImage(Icons.crown, for: .normal)
        favoriteButton.tintColor = Color.styleColor

    }
}
