//
//  FeedViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit

class FeedViewController: UIViewController {
    
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
    private var selectedCells: Set<IndexPath> = []

    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Text.feedTitle
        setupViewModel()
        addPostLocalStorage()
        removePostLocalStorage()
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
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)

        guard let viewModel = viewModel else { return cell }
        var post = viewModel.cellViewModel(forIndexPath: indexPath)

        cell.onAddedStorage = { [weak self] _ in
            post?.isFavorite = true
            self?.selectedCells.insert(indexPath)
            self?.viewModel?.pushPostDataLocalStorage(post)
        }

        cell.onRemovedStorage = { [weak self] _ in
            post?.isFavorite = false
            self?.viewModel?.popPostDataLocalStorage(post)
            self?.selectedCells.remove(indexPath)
        }

        cell.setupPost(post)

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }

        if selectedCells.contains(indexPath) {
            cell.isFavorite = true
        }
    }
}

extension FeedViewController {
    func setupViewModel() {
        viewModel = FeedViewModel()
        viewModel?.fetchAllPosts { [weak self] in
            DispatchQueue.main.async {
                self?.feedTableView.reloadData()
            }
        }
    }
}
