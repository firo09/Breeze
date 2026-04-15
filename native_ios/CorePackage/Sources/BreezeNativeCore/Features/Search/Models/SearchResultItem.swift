import Foundation

public struct SearchResultItem: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let author: String

    public init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}
