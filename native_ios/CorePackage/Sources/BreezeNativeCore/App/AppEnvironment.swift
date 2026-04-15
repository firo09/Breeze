import Foundation

public enum AppEnvironment: String, Sendable {
    case production
    case staging
    case development

    public var baseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://picaapi.picacomic.com")!
        case .staging:
            return URL(string: "https://staging-api.example.com")!
        case .development:
            return URL(string: "http://127.0.0.1:7879")!
        }
    }
}
