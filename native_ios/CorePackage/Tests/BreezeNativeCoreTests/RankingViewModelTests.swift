import Testing
@testable import BreezeNativeCore

@MainActor
struct RankingViewModelTests {
    @Test
    func loadSuccessSetsLoaded() async {
        let service = MockRankingService(result: .success([RankingEntry(id: "1", title: "A", category: "Hot", likes: 100)]))
        let viewModel = RankingViewModel(service: service, logger: ConsoleLogger())

        await viewModel.load()

        #expect(viewModel.entries.count == 1)
        #expect(viewModel.state == .loaded)
    }

    @Test
    func loadFailureSetsFailed() async {
        let service = MockRankingService(result: .failure(NetworkError.invalidResponse))
        let viewModel = RankingViewModel(service: service, logger: ConsoleLogger())

        await viewModel.load()

        guard case .failed = viewModel.state else {
            Issue.record("Expected failed state")
            return
        }
    }
}

private struct MockRankingService: RankingService {
    let result: Result<[RankingEntry], Error>

    @MainActor
    func fetchRanking(period: RankingPeriod) async throws -> [RankingEntry] {
        _ = period
        return try result.get()
    }
}
