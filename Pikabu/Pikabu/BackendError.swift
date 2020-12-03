//
//  BackendError.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

enum BackendError: Error, CustomStringConvertible {
    case badRequest // 400
    case notFound // 404
    case otherError // other error

    var description: String {
        switch self {
            case .notFound: return "Данные не найдены"
            case .badRequest: return "Неверный запрос"
            case .otherError: return "Проверьте интернет соединение"
        }
    }
}
