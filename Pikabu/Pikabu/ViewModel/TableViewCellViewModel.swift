//
//  TableViewCellViewModel.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    private var post: Post

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

    init(post: Post) {
        self.post = post
    }
}
