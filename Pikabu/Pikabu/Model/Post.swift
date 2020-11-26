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
}
