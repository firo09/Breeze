import Testing
@testable import BreezeNativeCore

@MainActor
struct SearchViewModelTests {
    @Test
    func searchSuccessSetsLoaded() async {
        let service = MockSearchService(resultForPage: [
            1: .success([SearchResultItem(id: "c1", title: "foo", author: "bar")])
        ])
        let viewModel = SearchViewModel(service: service, logger: ConsoleLogger())

        await viewModel.search("foo")

        #expect(viewModel.items.count == 1)
        #expect(viewModel.state == .loaded)
    }

    @Test
    func paginationAppendsItems() async {
        let service = MockSearchService(resultForPage: [
            1: .success([
                SearchResultItem(id: "1", title: "A", author: "x"),
                SearchResultItem(id: "2", title: "B", author: "x"),
                SearchResultItem(id: "3", title: "C", author: "x")
            ]),
            2: .success([SearchResultItem(id: "4", title: "D", author: "x")])
        ])
        let viewModel = SearchViewModel(service: service, logger: ConsoleLogger())

        await viewModel.search("foo")
        await viewModel.loadNextPageIfNeeded(currentItemID: "3")

        #expect(viewModel.items.count == 4)
        #expect(viewModel.state == .loaded)
    }
}

private struct MockSearchService: SearchService {
    let resultForPage: [Int: Result<[SearchResultItem], Error>]

    @MainActor
    func search(keyword: String, page: Int) async throws -> [SearchResultItem] {
        _ = keyword
        guard let result = resultForPage[page] else {
            return []
        }
        return try result.get()
    }
}
