import Foundation

public protocol KeyValueStore {
    func bool(forKey key: String) -> Bool
    func set(_ value: Bool, forKey key: String)
}

public final class UserDefaultsStore: KeyValueStore, @unchecked Sendable {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func bool(forKey key: String) -> Bool {
        userDefaults.bool(forKey: key)
    }

    public func set(_ value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
}
