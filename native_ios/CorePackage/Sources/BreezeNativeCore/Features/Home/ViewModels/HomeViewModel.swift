import Foundation

@MainActor
public final class HomeViewModel {
    public private(set) var categories: [HomeCategory] = []
    public private(set) var state: LoadingState = .idle

    private let service: HomeService
    private let logger: AppLogger

    public init(service: HomeService, logger: AppLogger) {
        self.service = service
        self.logger = logger
    }

    public func load() async {
        state = .loading

        do {
            categories = try await service.fetchCategories()
            state = categories.isEmpty ? .empty : .loaded
        } catch {
            logger.error("Load home categories failed: \(error.localizedDescription)")
            state = .failed(message: error.localizedDescription)
        }
    }
}

public enum LoadingState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case failed(message: String)
}
