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

    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Text.feedTitle

        setupViewModel()
        displayPost()
    }

    func displayPost() {
        viewModel?.onAddedStorage = { [weak self] post in
            guard let post = post else {
                print("Неудача FeedViewController 40 строка")
                return }
            self?.postStorage.localPosts.append(post)
        }
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)

        guard let viewModel = viewModel else { return cell }
        let post = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.setupPost(post)
        cell.onAddedStorage = { [weak self] post in
            self?.viewModel?.pushPostDataLocalStorage(post)
        }

        return cell
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
