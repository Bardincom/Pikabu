//
//  ViewController.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 25.11.2020.
//

import UIKit

class ViewController: UIViewController {

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed

        networkService.getRequest().getAllPosts { result in
            switch result {
                case .success(let posts):
                    posts.forEach { (post) in
                        print(post.id)
                    }
                case .failure(let error):
                    print(error.description)
            }
        }

        networkService.getRequest().getPost("31") {  result in
//            guard let self = self else { return }
            switch result {
                case .success(let post):
                    print(post.title)
                case .failure(let error):
                    print(error.description)
            }
        }

    }


}

