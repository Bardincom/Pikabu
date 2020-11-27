//
//  FeedViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import UIKit

class FeedViewController: UIViewController {


    @IBOutlet var feedTableView: UITableView! {
        willSet {
            newValue.register(nibCell: TableViewCell.self)
            newValue.tableFooterView = UIView()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TableViewCell.self, for: indexPath)

        return cell
    }


}
