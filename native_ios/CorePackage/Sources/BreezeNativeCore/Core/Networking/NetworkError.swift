import Foundation

public enum NetworkError: Error, LocalizedError, Sendable {
    case invalidRequest
    case invalidResponse
    case httpStatus(Int)
    case decoding(Error)
    case transport(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "请求参数无效。"
        case .invalidResponse:
            return "服务器响应无效。"
        case .httpStatus(let statusCode):
            return "服务器返回错误状态码: \(statusCode)。"
        case .decoding:
            return "数据解析失败。"
        case .transport(let error):
            return "网络异常: \(error.localizedDescription)"
        }
    }
}
