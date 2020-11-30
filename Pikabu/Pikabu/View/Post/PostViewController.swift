//
//  PostViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 30.11.2020.
//

import UIKit

final class PostViewController: UIViewController {

    @IBOutlet private var userName: UILabel!
    @IBOutlet private var avatarImage: UIImageView!
    @IBOutlet private var titlePost: UILabel!
    @IBOutlet private var bodyPost: UILabel!
    @IBOutlet var postImageCollectionView: UICollectionView! {
        willSet {
            newValue.register(nibCell: PostImageCollectionViewCell.self)
        }
    }

    private var favoriteButton: UIBarButtonItem!

    var postViewModel: PostViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupUI()
    }
}

extension PostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        postViewModel?.images?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: PostImageCollectionViewCell.self, for: indexPath)

        guard let images = postViewModel?.images else { return cell }

        let image = images[indexPath.row]

        cell.setupImages(image)

        return cell
    }


}

extension PostViewController {
    func setupViewModel() {
        
        postViewModel?.getPostForId(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.titlePost.text = self.postViewModel?.title
                self.bodyPost.text = self.postViewModel?.body
            }
        })
    }

    func setupNavigationBar() {
        favoriteButton = UIBarButtonItem(image: Icons.crown,
                                         style: .plain,
                                         target: self,
                                         action: #selector(pushFavoriteButton))

        let backButton = UIBarButtonItem(image: Icons.chevronLeft,
                                         style: .plain,
                                         target: self,
                                         action: #selector(popViewController))

        backButton.tintColor = Color.styleColor
        favoriteButton.tintColor = Color.styleColor

        navigationItem.rightBarButtonItems = .some([favoriteButton])
        navigationItem.leftBarButtonItem = .some(backButton)
        setupNavigationBar(withTitle: Text.postTitle)
    }

    @objc
    func pushFavoriteButton() {
        print("Добавить в избранное")
    }

    @objc
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func setupFonts() {
        titlePost.font = Fonts.titleFont
        bodyPost.font = Fonts.bodyFont
        userName.font = Fonts.postUserNameFont
    }

    func setupUI() {
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        setupFonts()
        setupNavigationBar()
    }
}
