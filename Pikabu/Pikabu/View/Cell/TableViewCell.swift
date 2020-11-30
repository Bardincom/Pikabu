//
//  TableViewCell.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit
import Kingfisher

final class TableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet private var userName: UILabel!
    @IBOutlet private var avatarImage: UIImageView!
    @IBOutlet private var titlePost: UILabel!
    @IBOutlet private var bodyPost: UILabel!
    @IBOutlet private var imagePost: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!

    // MARK: - CallBack
    public var onAddedStorage: PostBlock?
    public var onRemovedStorage: PostBlock?

    // MARK: - Private property

    private var isFavorite: Bool = false {
        didSet {
            switch isFavorite {
            case true:
                favoriteButton.setImage(Icons.crownFill, for: .normal)
            case false:
                favoriteButton.setImage(Icons.crown, for: .normal)
            }
        }
    }

    private var post: Post?

    // MARK: - LifeCicle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFonts()
        setupUI()
    }

    // MARK: - IBAction Methods

    @IBAction private func pushFavoriteButton(_ sender: UIButton) {
        guard let post = post else { return }
        if isFavorite || post.isFavorite == true {
            onRemovedStorage?(post)
            isFavorite = false
            didRemoveFavoritePost(post)
        } else {
            onAddedStorage?(post)
            isFavorite = true
        }
    }

    // MARK: - Methods

    func setupPost(_ post: Post?) {
        guard let post = post else { return }
        self.post = post
        imagePost.isHidden = true
        titlePost.text = post.title
        bodyPost.text = post.body

        if post.isFavorite ?? false {
            favoriteButton.setImage(Icons.crownFill, for: .normal)
        }

        guard let image = post.images?.first else { return }
        imagePost.kf.setImage(with: URL(string: image))
        imagePost.isHidden = false
    }

    func setupIsFavorite() {
        isFavorite = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isFavorite = false
    }


}

// MARK: - Private Methods

private extension TableViewCell {

    func setupFonts() {
        titlePost.font = Fonts.titleFont
        bodyPost.font = Fonts.bodyFont
        userName.font = Fonts.userNameFont
    }

    func setupUI() {
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        favoriteButton.setImage(Icons.crown, for: .normal)
        favoriteButton.tintColor = Color.styleColor
    }

    func didRemoveFavoritePost(_ post: Post) {
        NotificationCenter.default.post(name: .didRemovePost, object: nil, userInfo: [NotificationKey.postKey : post])
    }
}
