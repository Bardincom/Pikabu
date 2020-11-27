//
//  FeedViewModel.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import Foundation

class FeedViewModel {
    private var selectedIndexPath: IndexPath?
    private var posts = [Post]()
    private var networkService = NetworkService()

    func numberOfRows() -> Int {
        posts.count
    }

    func fetchAllPosts(completionHandler: @escaping () -> ()) {
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

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType {
        let post = posts[indexPath.row]

        return TableViewCellViewModel(post: post)
    }
}
