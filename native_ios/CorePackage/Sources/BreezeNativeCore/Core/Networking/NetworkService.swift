import Foundation

public protocol APIEndpoint: Sendable {
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
}

public extension APIEndpoint {
    var method: String { "GET" }
    var queryItems: [URLQueryItem] { [] }
}

public struct NetworkService {
    private let client: HTTPClient
    private let requestBuilder: APIRequestBuilder
    private let decoder: JSONDecoder

    public init(client: HTTPClient, requestBuilder: APIRequestBuilder, decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.requestBuilder = requestBuilder
        self.decoder = decoder
    }

    @MainActor
    public func send<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = try requestBuilder.makeRequest(
            path: endpoint.path,
            method: endpoint.method,
            queryItems: endpoint.queryItems
        )
        return try await client.send(request, decoder: decoder)
    }
}
