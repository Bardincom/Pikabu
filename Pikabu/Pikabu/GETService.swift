//
//  GETService.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

protocol GETProtocol {
    func getAllPosts(completionHandler: @escaping ResultBlock<[Post]>)

    func getPost(_ itemValue: String?,
                 completionHandler: @escaping ResultBlock<Post>)
}

class GETService: GETProtocol {

    private let urlService: URLServiceProtocol
    private let requestService: RequestServiceProtocol
    private let dataProvider: DataTaskServiceProtocol

    init(urlService: URLServiceProtocol = URLService(),
         requestService: RequestServiceProtocol = RequestService(),
         dataProvider: DataTaskServiceProtocol = DataTaskService()) {
        self.urlService = urlService
        self.requestService = requestService
        self.dataProvider = dataProvider
    }

    func getAllPosts(completionHandler: @escaping ResultBlock<[Post]>) {

        guard let url = urlService.preparationURL(Component.feedPath, nil) else { return }
        let request = requestService.preparationRequest(url)
        dataProvider.dataTask(with: request, completionHandler: completionHandler)
    }

    func getPost(_ itemValue: String?,
                 completionHandler: @escaping ResultBlock<Post>) {

        guard let url = urlService.preparationURL(Component.storyPath, itemValue) else { return }
        let request = requestService.preparationRequest(url)
        dataProvider.dataTask(with: request, completionHandler: completionHandler)
    }

}
