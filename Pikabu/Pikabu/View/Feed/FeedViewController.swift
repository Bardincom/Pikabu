//
//  FeedViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit

class FeedViewController: UIViewController {

    private var viewModel = FeedViewModel()

    @IBOutlet var feedTableView: UITableView! {
        willSet {
            newValue.register(nibCell: TableViewCell.self)
            newValue.tableFooterView = UIView()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchAllPosts { [weak self] in
            DispatchQueue.main.async {
                self?.feedTableView.reloadData()
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)
        let post = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.setupPost(post)

        return cell
    }
}
