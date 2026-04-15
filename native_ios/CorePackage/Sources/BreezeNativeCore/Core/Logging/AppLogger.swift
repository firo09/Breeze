import Foundation

public protocol AppLogger {
    func info(_ message: String)
    func error(_ message: String)
}

public struct ConsoleLogger: AppLogger {
    public init() {}

    public func info(_ message: String) {
        print("ℹ️ [Breeze] \(message)")
    }

    public func error(_ message: String) {
        print("❌ [Breeze] \(message)")
    }
}
