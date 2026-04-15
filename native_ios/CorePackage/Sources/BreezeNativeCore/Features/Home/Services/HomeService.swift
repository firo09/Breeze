import Foundation

public protocol HomeService {
    @MainActor
    func fetchCategories() async throws -> [HomeCategory]
}

public struct RemoteHomeService: HomeService {
    private let client: HTTPClient
    private let requestBuilder: APIRequestBuilder

    public init(client: HTTPClient, requestBuilder: APIRequestBuilder) {
        self.client = client
        self.requestBuilder = requestBuilder
    }

    @MainActor
    public func fetchCategories() async throws -> [HomeCategory] {
        let request = try requestBuilder.makeRequest(path: "categories")
        let response: CategoryEnvelope = try await client.send(request, decoder: JSONDecoder())
        return response.categories
    }
}

private struct CategoryEnvelope: Codable {
    let categories: [HomeCategory]
}
