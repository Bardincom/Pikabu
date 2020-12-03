//
//  TableViewViewModelType.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 28.11.2020.
//

import Foundation

protocol TableViewViewModelType {
    var onAddedStorage: PostBlock? {get set}
    var onRemovedStorage: PostBlock? {get set}

    func numberOfRows() -> Int
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> Post?

    func viewModelForSelectedRow() -> PostViewModel?

    func selectRow(atIndexPath indexPath: IndexPath)

    func fetchAllPosts(completionHandler: @escaping EmptyBlock)

    func pushPostDataLocalStorage(_ post: Post?)

    func popPostDataLocalStorage(_ post: Post?)
}
