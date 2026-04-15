#if canImport(SwiftUI)
import SwiftUI
import BreezeNativeCore

struct AppRouteViewFactory {
    @ViewBuilder
    static func makeDestination(for route: AppRoute) -> some View {
        switch route {
        case .search:
            SearchPage()
        case .comicDetail(let id):
            Text("Comic Detail: \(id)")
        case .reader(let comicID, let chapterID):
            Text("Reader \(comicID)-\(chapterID)")
        case .downloads:
            Text("Downloads")
        case .tab:
            EmptyView()
        }
    }
}
#endif
