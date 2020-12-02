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
        setupNavigationBar(withTitle: Text.favoriteTitle)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
        removePostLocalStorage()
//        addPostLocalStorage()
        checkIsEmptyFavoriteList()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritePostsViewController: UITableViewDataSource {
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

//        cell.onAddedStorage = { [weak self] _ in
//            post?.isFavorite = true
//            self?.favoriteModelView?.pushPostDataLocalStorage(post)
//            self?.selectedCells.insert(indexPath)
//        }

        cell.setupPost(post)
        return cell
    }
}

extension FavoritePostsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }

        if selectedCells.contains(indexPath) {
            cell.setupIsFavorite()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let viewModel = favoriteModelView else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        guard let postViewModel = viewModel.viewModelForSelectedRow() else { return }
        let postViewController = PostViewController()
        postViewController.postViewModel = postViewModel

        if selectedCells.contains(indexPath) {
            postViewController.isFavorite = true
            
        }

        navigationController?.pushViewController(postViewController, animated: true)
    }

}

// MARK: - Methods

private extension FavoritePostsViewController {

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

//    func addPostLocalStorage() {
//        favoriteModelView?.onAddedStorage = { [weak self] post in
//            guard let post = post else {return }
//            self?.postStorage.localPosts.append(post)
//        }
//    }

    

    func checkIsEmptyFavoriteList() {
        favoriteModelView?.numberOfRows() == 0 ? (favoritePostsTableView.isHidden = true) : (favoritePostsTableView.isHidden = false)
    }
}
