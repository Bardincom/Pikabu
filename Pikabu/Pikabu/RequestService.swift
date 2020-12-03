//
//  RequestService.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

protocol RequestServiceProtocol {
    func preparationRequest(_ url: URL) -> URLRequest
}

final class RequestService: RequestServiceProtocol {

    func preparationRequest(_ url: URL) -> URLRequest {
        URLRequest(url: url)
    }
}
