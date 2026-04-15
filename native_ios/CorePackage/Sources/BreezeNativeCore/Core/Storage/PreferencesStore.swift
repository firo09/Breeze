import Foundation

public protocol PreferencesStore: Sendable {
    func setCodableValue<T: Encodable>(_ value: T, forKey key: String) throws
    func codableValue<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T?
    func removeValue(forKey key: String)
}

public struct UserDefaultsPreferencesStore: PreferencesStore, @unchecked Sendable {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func setCodableValue<T: Encodable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        userDefaults.set(data, forKey: key)
    }

    public func codableValue<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    public func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
