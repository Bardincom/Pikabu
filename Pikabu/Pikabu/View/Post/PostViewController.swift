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
    private var post: Post?
    private var postStorage = PostStorage.shared
    public var onAddedStorage: PostBlock?
    
    public var isFavorite: Bool = false
//    public var indexPath: IndexPath?
    public var postViewModel: PostViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        addPostLocalStorage()
//        print(indexPath)
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

private extension PostViewController {

    func addPostLocalStorage() {
//        onAddedStorage = { [weak self] post in
//            guard let post = post else {return }
//            self?.postStorage.localPosts.append(post)
//        }
    }

    func setupViewModel() {
        postViewModel?.getPostForId(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.post = self.postViewModel?.post
                self.titlePost.text = self.postViewModel?.title
                self.bodyPost.text = self.postViewModel?.body
//                self.indexPath = self.postViewModel?.indexPath
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
        guard var post = post else { return }
        isFavorite = !isFavorite
        switch isFavorite {
            case false:
                didRemoveFavoritePost(post)
                favoriteButton.image = Icons.crown
            case true:
                post.isFavorite = true
                onAddedStorage?(post)
//                didAddedFavoritePost(post)
                favoriteButton.image = Icons.crownFill
        }

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
        setupFavoriteButton()

    }

    func setupFavoriteButton() {
        switch isFavorite {
            case false:
                favoriteButton.image = Icons.crown
            case true:
                favoriteButton.image = Icons.crownFill
        }
    }

    func didRemoveFavoritePost(_ post: Post) {
        NotificationCenter.default.post(name: .didRemovePost, object: nil, userInfo: [NotificationKey.postKey : post])
    }

//    func didAddedFavoritePost(_ post: Post) {
//        print(post.title, indexPath)
//        NotificationCenter.default.post(name: .didAddedPost, object: post, userInfo: ["IndexPath" : indexPath])
//    }
}
