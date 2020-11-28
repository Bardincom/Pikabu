//
//  FeedViewModel.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import Foundation

class FeedViewModel: TableViewViewModelType {

    var onAddedStorage: PostBlock?

    // MARK: - Private property

    private var selectedIndexPath: IndexPath?
    private var posts = [Post]()
    private var networkService = NetworkService()

    // MARK: - Methods
    
    func numberOfRows() -> Int {
        posts.count
    }

    func fetchAllPosts(completionHandler: @escaping EmptyBlock) {
        networkService.getRequest().getAllPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let posts):
                    self.posts = posts
                    completionHandler()
                case .failure(let error):
                    print(error.description)
            }
        }
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> Post? {
        return posts[indexPath.row]

//        return TableViewCellViewModel(post: post)
    }

    func pushPostDataLocalStorage(_ post: Post?) {
        onAddedStorage?(post)
    }
}
