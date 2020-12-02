//
//  PostViewModel.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 30.11.2020.
//

import Foundation

class PostViewModel {

//    var onAddedStorage: PostBlock?
    
//    var indexPath: IndexPath?

    var post: Post
    private var networkService = NetworkService()

    var id: String {
        String(post.id)
    }

    var title: String {
        post.title
    }

    var body: String? {
        post.body
    }
    var images: [String]? {
        post.images
    }

    var isFavorite: Bool? {
        post.isFavorite
    }

    init(post: Post) {
        self.post = post
    }

    func getPostForId(completionHandler: @escaping EmptyBlock) {
        networkService.getRequest().getPost(id) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let post):
                    self.post = post
                    completionHandler()
                case .failure(let error):
                    print(error.description)
                    completionHandler()
            }
        }
    }

//    func pushPostDataLocalStorage(_ post: Post?) {
//        onAddedStorage?(post)
//    }
}
