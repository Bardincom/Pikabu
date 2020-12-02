//
//  FeedViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet private var feedTableView: UITableView! {
        willSet {
            newValue.register(nibCell: TableViewCell.self)
            newValue.tableFooterView = UIView()
        }
    }

    var postStorage = PostStorage.shared

    // MARK: - Private property

    private var viewModel: TableViewViewModelType?
    private var selectedCells: SelectPost = [:]

    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(withTitle: Text.feedTitle)
        setupViewModel()
        addPostLocalStorage()
        removePostLocalStorage()
        addObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)

        guard let viewModel = viewModel else { return cell }
        var post = viewModel.cellViewModel(forIndexPath: indexPath)

        cell.onAddedStorage = { [weak self] _ in
            post?.isFavorite = true
            self?.selectedCells.updateValue(post, forKey: indexPath)
            self?.viewModel?.pushPostDataLocalStorage(post)
        }

        cell.onRemovedStorage = { [weak self] _ in
            post?.isFavorite = false
            self?.viewModel?.popPostDataLocalStorage(post)
            self?.selectedCells.removeValue(forKey: indexPath)
        }

        cell.setupPost(post)

        return cell
    }
}

extension FeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }

        if let _ = selectedCells[indexPath] {
            cell.setupIsFavorite()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let viewModel = viewModel else { return }

        viewModel.selectRow(atIndexPath: indexPath)
        guard let postViewModel = viewModel.viewModelForSelectedRow() else { return }
        let postViewController = PostViewController()
        postViewController.postViewModel = postViewModel

        var post = viewModel.cellViewModel(forIndexPath: indexPath)

        postViewController.onAddedStorage = { [weak self] _ in
            post?.isFavorite = true
            self?.selectedCells.updateValue(post, forKey: indexPath)
            self?.viewModel?.pushPostDataLocalStorage(post)
            self?.feedTableView.reloadData()
        }

        if let _ = selectedCells[indexPath] {
            postViewController.isFavorite = true
        }

        navigationController?.pushViewController(postViewController, animated: true)
    }
    

}

// MARK: - Methods

extension FeedViewController {

    func setupViewModel() {
        viewModel = FeedViewModel()
        viewModel?.fetchAllPosts { [weak self] in
            DispatchQueue.main.async {
                self?.checkIsConnectivity()
                self?.feedTableView.reloadData()
            }
        }
    }

    func addPostLocalStorage() {
        viewModel?.onAddedStorage = { [weak self] post in
            guard let post = post else {return }
            self?.postStorage.localPosts.append(post)
        }
    }

    func removePostLocalStorage() {
        viewModel?.onRemovedStorage = { [weak self] post in

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

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeFavoritePost), name: .didRemovePost, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(addFavoritePost), name: .didAddedPost, object: nil)
    }

    @objc
    func removeFavoritePost(_ notification: Notification) {
        guard
            let post = notification.userInfo?[NotificationKey.postKey] as? Post,
            let indexPath = selectedCells.first(where: { $0.value == post})
        else {
            return
        }

        selectedCells.removeValue(forKey: indexPath.key)
        viewModel?.popPostDataLocalStorage(post)

        DispatchQueue.main.async {
            self.feedTableView.reloadData()
        }
    }

//    @objc
//    func addFavoritePost(_ notification: Notification) {
//        guard let post = notification.object as? Post,
//              let indexPath = notification.userInfo?["IndexPath"] as? IndexPath
////              let indexPath = selectedCells.first(where: { $0.value == post})
//        else {
//            return
//        }
//        print(indexPath)
//        self.selectedCells.updateValue(post, forKey: indexPath)
////        viewModel?.pushPostDataLocalStorage(post)
//        DispatchQueue.main.async {
//            self.feedTableView.reloadData()
//        }
//    }

    func checkIsConnectivity() {
        viewModel?.numberOfRows() == 0 ? (feedTableView.isHidden = true) : (feedTableView.isHidden = false)
    }
}
