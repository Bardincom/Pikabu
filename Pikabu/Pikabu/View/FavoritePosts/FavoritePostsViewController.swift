//
//  FavoritePostsViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 27.11.2020.
//

import UIKit

final class FavoritePostsViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private var favoritePostsTableView: UITableView! {
        willSet {
            newValue.register(nibCell: TableViewCell.self)
            newValue.tableFooterView = UIView()
        }
    }

    // MARK: - Private property
    
    private var postStorage = PostStorage.shared
    private var favoriteModelView: TableViewViewModelType?
    private var selectedCells: Set<IndexPath> = []

    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Text.favoriteTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
        removePostLocalStorage()
        checkIsEmptyFavoriteList()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritePostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteModelView?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)

        guard let favoriteModelView = favoriteModelView else { return cell }
        var post = favoriteModelView.cellViewModel(forIndexPath: indexPath)

        cell.onRemovedStorage = { [weak self] _ in
            post?.isFavorite = false
            self?.favoriteModelView?.popPostDataLocalStorage(post)
            self?.selectedCells.remove(indexPath)
        }

        cell.setupPost(post)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        
        if selectedCells.contains(indexPath) {
            cell.setupIsFavorite()
        }
    }
}

// MARK: - Methods

extension FavoritePostsViewController {
    func setupViewModel() {
        favoriteModelView = FavoriteViewModel()
        favoriteModelView?.fetchAllPosts { [weak self] in
            DispatchQueue.main.async {
                self?.favoritePostsTableView.reloadData()
            }
        }
    }

    func removePostLocalStorage() {
        favoriteModelView?.onRemovedStorage = { [weak self] post in
            guard
                let self = self,
                let post = post,
                let index = self.postStorage.localPosts.firstIndex(where: { (removePost) -> Bool in
                    removePost == post
                })
            else {
                return
            }
            self.postStorage.removePost(index)
        }
    }

    func checkIsEmptyFavoriteList() {
        favoriteModelView?.numberOfRows() == 0 ? (favoritePostsTableView.isHidden = true) : (favoritePostsTableView.isHidden = false)
    }
}
