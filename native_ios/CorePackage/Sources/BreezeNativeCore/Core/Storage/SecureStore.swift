import Foundation

public protocol SecureStore: Sendable {
    func set(_ value: Data, forKey key: String) throws
    func data(forKey key: String) throws -> Data?
    func removeValue(forKey key: String) throws
}

public final class InMemorySecureStore: SecureStore, @unchecked Sendable {
    private var values: [String: Data]

    public init(values: [String: Data] = [:]) {
        self.values = values
    }

    public func set(_ value: Data, forKey key: String) throws {
        values[key] = value
    }

    public func data(forKey key: String) throws -> Data? {
        values[key]
    }

    public func removeValue(forKey key: String) throws {
        values[key] = nil
    }
}

public enum StorageError: LocalizedError, Sendable {
    case unsupportedInCurrentEnvironment(String)

    public var errorDescription: String? {
        switch self {
        case .unsupportedInCurrentEnvironment(let detail):
            return detail
        }
    }
}
