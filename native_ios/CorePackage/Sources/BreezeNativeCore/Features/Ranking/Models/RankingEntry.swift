import Foundation

public struct RankingEntry: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let category: String
    public let likes: Int

    public init(id: String, title: String, category: String, likes: Int) {
        self.id = id
        self.title = title
        self.category = category
        self.likes = likes
    }
}
