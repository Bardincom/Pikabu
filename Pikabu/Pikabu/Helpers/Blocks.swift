//
//  Blocks.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 28.11.2020.
//

import Foundation

typealias EmptyBlock = () -> Void
typealias PostBlock = (Post?) -> Void
typealias SelectPost = [IndexPath: Post?]
