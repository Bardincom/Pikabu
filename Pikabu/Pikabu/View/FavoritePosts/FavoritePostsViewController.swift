//
//  FavoritePostsViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import UIKit

class FavoritePostsViewController: UIViewController {

    @IBOutlet private var favoritePostsTableView: UITableView! {
        willSet {
            newValue.register(nibCell: TableViewCell.self)
            newValue.tableFooterView = UIView()
        }
    }

    private var favoriteModelView: TableViewViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Добавить Наблюдателя для определения пусто ли хранилище
//        favoritePostsTableView.isHidden = true
        setupViewModel()
        navigationItem.title = Text.favoriteTitle
    }
}

extension FavoritePostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteModelView?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)

        return cell
    }
}

extension FavoritePostsViewController {
    func setupViewModel() {
        favoriteModelView = FavoriteViewModel()
        favoriteModelView?.fetchAllPosts { [weak self] in
            DispatchQueue.main.async {
                self?.favoritePostsTableView.reloadData()
            }
        }
    }
}
