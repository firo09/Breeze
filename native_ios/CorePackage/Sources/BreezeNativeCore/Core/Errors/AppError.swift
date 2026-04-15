import Foundation

public enum ErrorSeverity: Sendable {
    case info
    case warning
    case critical
}

public struct ErrorPresentation: Sendable {
    public let title: String
    public let message: String
    public let severity: ErrorSeverity

    public init(title: String, message: String, severity: ErrorSeverity) {
        self.title = title
        self.message = message
        self.severity = severity
    }
}

public enum AppError: LocalizedError, Sendable {
    case network(NetworkError)
    case storage(String)
    case business(message: String)
    case unknown(message: String)

    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return error.errorDescription
        case .storage(let reason):
            return reason
        case .business(let message):
            return message
        case .unknown(let message):
            return message
        }
    }

    public var presentation: ErrorPresentation {
        switch self {
        case .network:
            return ErrorPresentation(title: "网络异常", message: errorDescription ?? "请稍后重试", severity: .warning)
        case .storage:
            return ErrorPresentation(title: "存储异常", message: errorDescription ?? "请检查存储权限", severity: .warning)
        case .business:
            return ErrorPresentation(title: "操作失败", message: errorDescription ?? "请稍后重试", severity: .info)
        case .unknown:
            return ErrorPresentation(title: "未知错误", message: errorDescription ?? "发生未知错误", severity: .critical)
        }
    }

    public static func wrap(_ error: Error) -> AppError {
        if let appError = error as? AppError {
            return appError
        }

        if let networkError = error as? NetworkError {
            return .network(networkError)
        }

        return .unknown(message: error.localizedDescription)
    }
}
