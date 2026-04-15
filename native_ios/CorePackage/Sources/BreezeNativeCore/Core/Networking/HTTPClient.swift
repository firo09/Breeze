import Foundation
import FoundationNetworking

public protocol HTTPClient {
    @MainActor
    func send<T: Decodable>(_ request: URLRequest, decoder: JSONDecoder) async throws -> T
}

public struct URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    @MainActor
    public func send<T: Decodable>(_ request: URLRequest, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.httpStatus(httpResponse.statusCode)
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.transport(error)
        }
    }
}
