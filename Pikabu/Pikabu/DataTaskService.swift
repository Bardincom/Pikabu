//
//  DataTaskService.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 26.11.2020.
//

import Foundation

typealias ResultBlock<T> = (Result<T, BackendError>) -> Void

protocol DataTaskServiceProtocol {
    func dataTask<T: Codable>(with request: URLRequest, completionHandler: @escaping ResultBlock<T>)
}

class DataTaskService: DataTaskServiceProtocol {

    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let decoder = JSONDecoder()

    /// Получение данных после запроса
    func dataTask<T: Codable>(with request: URLRequest, completionHandler: @escaping ResultBlock<T>) {
        
        session.configuration.waitsForConnectivity = true
        session.configuration.timeoutIntervalForResource = 60

        let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.didChangesForConnectivity()
                print("Возникла ошибка: \(error.localizedDescription)")
                completionHandler(.failure(.otherError))
            }

            guard let httpResponse = self.checkResponse(response: response, completionHandler: completionHandler) else { return }
            guard self.checkBackendErrorStatus(httpResponse: httpResponse, completionHandler: completionHandler) else { return }
            guard let data = data else { return }

            do {
                let result = try self.decoder.decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.notFound))
            }
        }
        dataTask.resume()
    }

    /// Проверка статуса запроса
    private func checkBackendErrorStatus<T>(httpResponse: HTTPURLResponse,
                                    completionHandler: @escaping ResultBlock<T>) -> Bool {
        guard httpResponse.statusCode == 200 else {
            let backendError: BackendError

            switch httpResponse.statusCode {
                case 400: backendError = .badRequest
                case 404: backendError = .notFound
                default: backendError = .otherError
            }

            completionHandler(.failure(backendError))
            return false
        }
        return true
    }

    /// Проверка ответа с сервера
    private func checkResponse<T>(response: URLResponse?,
                          completionHandler: @escaping ResultBlock<T>) -> HTTPURLResponse? {

        guard let httpResponse = response as? HTTPURLResponse else {

            let backendError = BackendError.otherError
            completionHandler(.failure(backendError))
            return nil}
        return httpResponse
    }

    private func didChangesForConnectivity() {
        NotificationCenter.default.post(name: .didChangesForConnectivity, object: nil)
    }
}

