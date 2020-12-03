//
//  URLComponentsService.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

protocol URLComponentsProtocol {
    func preparationURLComponents(_ path: String,_ itemValue: String?) -> URLComponents?
}

final class URLComponentsService: URLComponentsProtocol {

    func preparationURLComponents(_ path: String,_ itemValue: String?) -> URLComponents? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Component.scheme
        urlComponents.host = Component.host
        urlComponents.path = path
        guard let value = itemValue else { return urlComponents }
        urlComponents.queryItems = [
            URLQueryItem(name: QueryItem.name, value: "\(value)"),
        ]

        return urlComponents
    }
}
