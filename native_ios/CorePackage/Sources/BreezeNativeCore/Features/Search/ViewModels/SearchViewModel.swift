import Foundation

@MainActor
public final class SearchViewModel {
    public private(set) var keyword: String = ""
    public private(set) var state: LoadingState = .idle
    public private(set) var page: Int = 1
    public private(set) var items: [SearchResultItem] = []

    private let service: SearchService
    private let logger: AppLogger

    public init(service: SearchService, logger: AppLogger) {
        self.service = service
        self.logger = logger
    }

    public func search(_ keyword: String) async {
        self.keyword = keyword
        self.page = 1
        self.items = []
        await loadCurrentPage()
    }

    public func loadNextPageIfNeeded(currentItemID: String) async {
        guard let index = items.firstIndex(where: { $0.id == currentItemID }) else {
            return
        }

        let threshold = max(items.count - 3, 0)
        guard index >= threshold, state == .loaded else {
            return
        }

        page += 1
        await loadCurrentPage(append: true)
    }

    private func loadCurrentPage(append: Bool = false) async {
        guard !keyword.isEmpty else {
            state = .idle
            return
        }

        state = .loading

        do {
            let data = try await service.search(keyword: keyword, page: page)
            if append {
                items += data
            } else {
                items = data
            }
            state = items.isEmpty ? .empty : .loaded
        } catch {
            let wrapped = AppError.wrap(error)
            logger.error("Search failed: \(wrapped.localizedDescription)")
            state = .failed(message: wrapped.presentation.message)
        }
    }
}
