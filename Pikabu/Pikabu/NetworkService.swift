//
//  NetworkService.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

final class NetworkService {

    private let getService: GETProtocol

    init(getService: GETProtocol = GETService()) {
        self.getService = getService
    }

    func getRequest() -> GETProtocol {
        return getService
    }
}
