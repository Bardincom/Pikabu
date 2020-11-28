//
//  FavoriteViewModel.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 28.11.2020.
//

import Foundation

class FavoriteViewModel: TableViewViewModelType {

    var onAddedStorage: PostBlock?

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

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let post = posts[indexPath.row]

        return TableViewCellViewModel(post: post)
    }

    func pushPostDataLocalStorage(_ post: TableViewCellViewModelType?) {
        
    }
}
