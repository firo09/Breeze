import Foundation

public enum AppTab: String, CaseIterable, Sendable {
    case home
    case ranking
    case bookshelf
    case settings
}

public enum AppRoute: Hashable, Sendable {
    case tab(AppTab)
    case search(keyword: String)
    case comicDetail(id: String)
    case reader(comicID: String, chapterID: String)
    case downloads
}
