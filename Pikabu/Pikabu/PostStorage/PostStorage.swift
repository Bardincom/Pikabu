//
//  PostStorage.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 28.11.2020.
//

import Foundation

public final class PostStorage {

    public static let shared: PostStorage = .init()

    var localPosts: [Post] = [] {
        didSet {
            self.save()
        }
    }

    private lazy var userDefaults: UserDefaults = .standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()

    // MARK: - Private

    private init() {

        guard let data = userDefaults.data(forKey: "posts") else { return}

        do {
            localPosts = try decoder.decode([Post].self, from: data)
            print(localPosts.count)

        }
        catch {
            print("Ошибка декодирования сохранённых публикаций", error)
        }

    }
}

// MARK: - Methods

extension PostStorage {

    private func save() {
        do {
            let data = try encoder.encode(localPosts)
            print(data)

            userDefaults.setValue(data, forKey: "posts")
        }
        catch {
            print("Ошибка кодирования локации для сохранения", error)
        }
    }
}
