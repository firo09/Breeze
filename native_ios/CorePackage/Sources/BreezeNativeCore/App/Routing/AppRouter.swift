import Foundation

@MainActor
public final class AppRouter {
    public private(set) var selectedTab: AppTab
    public private(set) var path: [AppRoute]

    public init(selectedTab: AppTab = .home, path: [AppRoute] = []) {
        self.selectedTab = selectedTab
        self.path = path
    }

    public func switchTab(_ tab: AppTab) {
        selectedTab = tab
    }

    public func push(_ route: AppRoute) {
        path.append(route)
    }

    public func replacePath(with routes: [AppRoute]) {
        path = routes
    }

    public func popLast() {
        _ = path.popLast()
    }

    public func popToRoot() {
        path.removeAll()
    }
}
