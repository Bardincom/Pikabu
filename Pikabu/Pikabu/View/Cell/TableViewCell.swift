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
    @IBOutlet private var avatarImage: UIImageView!
    @IBOutlet private var titlePost: UILabel!
    @IBOutlet private var bodyPost: UILabel!
    @IBOutlet private var imagePost: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!

    private var post: Post?

    var isFavorite: Bool = false {
        didSet {
            switch isFavorite {
            case true:
                favoriteButton.setImage(Icons.crownFill, for: .normal)
            case false:
                favoriteButton.setImage(Icons.crown, for: .normal)
            }
        }
    }

    public var onAddedStorage: PostBlock?
    public var onRemovedStorage: PostBlock?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFonts()
        setupUI()
    }

    @IBAction func pushFavoriteButton(_ sender: UIButton) {
        if isFavorite || post?.isFavorite == true {
            onRemovedStorage?(post)
            isFavorite = false
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

    private func setupFonts() {
        titlePost.font = Fonts.titleFont
        bodyPost.font = Fonts.bodyFont
        userName.font = Fonts.userNameFont
    }

    private func setupUI() {
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        favoriteButton.setImage(Icons.crown, for: .normal)
        favoriteButton.tintColor = Color.styleColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isFavorite = false
    }
}
