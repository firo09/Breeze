import Testing
@testable import BreezeNativeCore

@MainActor
struct HomeViewModelTests {
    @Test
    func loadSuccessSetsLoadedState() async {
        let service = MockHomeService(result: .success([HomeCategory(id: "1", title: "最新")]))
        let viewModel = HomeViewModel(service: service, logger: ConsoleLogger())

        await viewModel.load()

        #expect(viewModel.categories.count == 1)
        #expect(viewModel.state == .loaded)
    }

    @Test
    func loadEmptySetsEmptyState() async {
        let service = MockHomeService(result: .success([]))
        let viewModel = HomeViewModel(service: service, logger: ConsoleLogger())

        await viewModel.load()

        #expect(viewModel.categories.isEmpty)
        #expect(viewModel.state == .empty)
    }

    @Test
    func loadFailureSetsFailedState() async {
        let service = MockHomeService(result: .failure(MockError.failed))
        let viewModel = HomeViewModel(service: service, logger: ConsoleLogger())

        await viewModel.load()

        guard case .failed = viewModel.state else {
            Issue.record("Expected failed state")
            return
        }
    }
}

private struct MockHomeService: HomeService {
    let result: Result<[HomeCategory], Error>

    @MainActor
    func fetchCategories() async throws -> [HomeCategory] {
        try result.get()
    }
}

private enum MockError: Error {
    case failed
}
