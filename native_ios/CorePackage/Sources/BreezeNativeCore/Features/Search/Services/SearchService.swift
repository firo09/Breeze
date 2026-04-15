import Foundation

public protocol SearchService {
    @MainActor
    func search(keyword: String, page: Int) async throws -> [SearchResultItem]
}

public struct RemoteSearchService: SearchService {
    private struct SearchEndpoint: APIEndpoint {
        let path: String = "search"
        let queryItems: [URLQueryItem]

        init(keyword: String, page: Int) {
            self.queryItems = [
                URLQueryItem(name: "keyword", value: keyword),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }

    private struct SearchEnvelope: Codable {
        let items: [SearchResultItem]
    }

    private let networkService: NetworkService

    public init(networkService: NetworkService) {
        self.networkService = networkService
    }

    @MainActor
    public func search(keyword: String, page: Int) async throws -> [SearchResultItem] {
        let endpoint = SearchEndpoint(keyword: keyword, page: page)
        let response: SearchEnvelope = try await networkService.send(endpoint)
        return response.items
    }
}
