import Foundation

@MainActor
public final class RankingViewModel {
    public private(set) var state: LoadingState = .idle
    public private(set) var entries: [RankingEntry] = []
    public private(set) var period: RankingPeriod = .daily

    private let service: RankingService
    private let logger: AppLogger

    public init(service: RankingService, logger: AppLogger) {
        self.service = service
        self.logger = logger
    }

    public func switchPeriod(_ period: RankingPeriod) async {
        self.period = period
        await load()
    }

    public func load() async {
        state = .loading

        do {
            let data = try await service.fetchRanking(period: period)
            entries = data
            state = data.isEmpty ? .empty : .loaded
        } catch {
            let wrapped = AppError.wrap(error)
            logger.error("Load ranking failed: \(wrapped.localizedDescription)")
            state = .failed(message: wrapped.presentation.message)
        }
    }
}
