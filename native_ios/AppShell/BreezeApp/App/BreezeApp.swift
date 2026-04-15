#if canImport(SwiftUI)
import SwiftUI
import BreezeNativeCore

@main
struct BreezeApp: App {
    @StateObject private var appContext = AppContext.bootstrapForLocalXcode()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appContext)
        }
    }
}
#endif
