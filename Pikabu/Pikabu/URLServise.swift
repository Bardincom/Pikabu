//
//  URLServise.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

protocol URLServiceProtocol {
    func preparationURL(_ path: String, _ itemValue: String?) -> URL?
}

final class URLService: URLServiceProtocol {

    private let preparationURLComponents: URLComponentsProtocol

    init(preparationURLComponents: URLComponentsProtocol = URLComponentsService()) {
        self.preparationURLComponents = preparationURLComponents
    }

    func preparationURL(_ path: String, _ itemValue: String?) -> URL? {
        guard let url = preparationURLComponents.preparationURLComponents(path, itemValue)?.url else { return nil }

        return url
    }
}
