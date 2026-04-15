#if canImport(SwiftUI)
import SwiftUI
import BreezeNativeCore

@MainActor
final class AppContext: ObservableObject {
    let dependencies: AppDependencyContainer
    let router: AppRouter

    init(dependencies: AppDependencyContainer, router: AppRouter) {
        self.dependencies = dependencies
        self.router = router
    }

    static func bootstrapForLocalXcode() -> AppContext {
        // NOTE: 当前容器无法验证 iOS target，本方法仅供本地 Xcode 挂载时使用。
        let runtime = AppRuntimeEnvironment.development
        let dependencies = AppDependencyContainer.makeDefault(runtime: runtime)
        let router = AppRouter(selectedTab: .home)
        return AppContext(dependencies: dependencies, router: router)
    }
}
#endif
