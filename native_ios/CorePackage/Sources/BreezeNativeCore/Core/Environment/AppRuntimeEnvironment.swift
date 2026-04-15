import Foundation

public struct AppRuntimeEnvironment: Sendable {
    public let environment: AppEnvironment
    public let enableVerboseLogging: Bool
    public let requestTimeout: TimeInterval

    public init(
        environment: AppEnvironment,
        enableVerboseLogging: Bool = false,
        requestTimeout: TimeInterval = 20
    ) {
        self.environment = environment
        self.enableVerboseLogging = enableVerboseLogging
        self.requestTimeout = requestTimeout
    }

    public static let development = AppRuntimeEnvironment(
        environment: .development,
        enableVerboseLogging: true,
        requestTimeout: 30
    )

    public static let production = AppRuntimeEnvironment(
        environment: .production,
        enableVerboseLogging: false,
        requestTimeout: 20
    )
}
