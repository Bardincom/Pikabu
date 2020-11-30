//
//  FavoriteViewModel.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 28.11.2020.
//

import Foundation

class FavoriteViewModel: TableViewViewModelType {

    var onAddedStorage: PostBlock?
    var onRemovedStorage: PostBlock?

    // MARK: - Private property

    private var selectedIndexPath: IndexPath?
    private var posts = [Post]()
    private var postStorage = PostStorage.shared

    // MARK: - Methods

    func numberOfRows() -> Int {
        posts.count
    }

    func fetchAllPosts(completionHandler: @escaping EmptyBlock) {
        posts = postStorage.localPosts
        completionHandler()
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> Post? {
        posts[indexPath.row]
    }

    func pushPostDataLocalStorage(_ post: Post?) {
        onAddedStorage?(post)
    }

    func popPostDataLocalStorage(_ post: Post?) {
        onRemovedStorage?(post)
    }
}
