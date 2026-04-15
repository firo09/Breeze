import Foundation

public protocol RankingService {
    @MainActor
    func fetchRanking(period: RankingPeriod) async throws -> [RankingEntry]
}

public enum RankingPeriod: String, CaseIterable, Sendable {
    case daily
    case weekly
    case monthly
}

public struct RemoteRankingService: RankingService {
    private struct RankingEndpoint: APIEndpoint {
        let path: String = "ranking"
        let queryItems: [URLQueryItem]

        init(period: RankingPeriod) {
            self.queryItems = [URLQueryItem(name: "period", value: period.rawValue)]
        }
    }

    private struct RankingEnvelope: Codable {
        let entries: [RankingEntry]
    }

    private let networkService: NetworkService

    public init(networkService: NetworkService) {
        self.networkService = networkService
    }

    @MainActor
    public func fetchRanking(period: RankingPeriod) async throws -> [RankingEntry] {
        let endpoint = RankingEndpoint(period: period)
        let response: RankingEnvelope = try await networkService.send(endpoint)
        return response.entries
    }
}
