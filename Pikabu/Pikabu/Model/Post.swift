//
//  Post.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 25.11.2020.
//

import Foundation

struct Post: Codable {
    var id: Int
    var title: String
    var body: String?
    var images: [String]?

    var isFavorite: Bool? = false
}

extension Post: Equatable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        return
            lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.body == rhs.body
            && lhs.images == rhs.images
    }
}
