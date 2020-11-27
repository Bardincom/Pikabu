//
//  TableViewCellViewModelType.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import Foundation

protocol TableViewCellViewModelType: class {
    var id: String { get }
    var title: String { get }
    var body: String? { get }
    var images: [String]? { get }
}
