#if canImport(SwiftUI)
import SwiftUI
import BreezeNativeCore

struct RootTabView: View {
    @EnvironmentObject private var context: AppContext

    var body: some View {
        TabView(selection: Binding(
            get: { context.router.selectedTab },
            set: { context.router.switchTab($0) }
        )) {
            HomePage().tag(AppTab.home)
                .tabItem { Label("Home", systemImage: "house") }

            RankingPage().tag(AppTab.ranking)
                .tabItem { Label("Ranking", systemImage: "chart.bar") }

            BookshelfPage().tag(AppTab.bookshelf)
                .tabItem { Label("Bookshelf", systemImage: "books.vertical") }

            SettingsPage().tag(AppTab.settings)
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}
#endif
