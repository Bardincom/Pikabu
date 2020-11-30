//
//  PostStorage.swift
//  Pikabu
//
//  Created by Aleksey Bardin on 28.11.2020.
//

import Foundation

public final class PostStorage {

    // MARK: - Property

    public static let shared: PostStorage = .init()

    var localPosts: [Post] = [] {
        didSet {
            self.save()
        }
    }

    // MARK: - Private Property

    private lazy var userDefaults: UserDefaults = .standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()

    // MARK: - Init

    private init() {
        userDefaults.setValue(nil, forKey: StorageKey.postKey)
        guard let data = userDefaults.data(forKey: StorageKey.postKey) else { return }

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

            userDefaults.setValue(data, forKey: StorageKey.postKey)
        }
        catch {
            print("Ошибка кодирования публикации. Сохранение невозможно.", error)
        }
    }

    func removePost(_ index: Int) {
        localPosts.remove(at: index)
    }
}
