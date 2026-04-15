# 本地 Xcode 收口清单（Mac 上执行）

> 目标：将仓库当前迁移产物收口为可运行 iOS App。  
> 注意：以下步骤中标记 **[Xcode-only]** 的内容无法在当前容器验证。

## 1) 建立 iOS App Target [Xcode-only]
1. 在 `native_ios` 下创建 `BreezeApp.xcodeproj`（或 workspace）。
2. 新建 iOS App（SwiftUI lifecycle，iOS 17+）。
3. 将 `AppShell/BreezeApp/**` 文件加入 target membership。

## 2) 引入 CorePackage [Xcode-only]
1. 通过 `Package Dependencies` 添加本地包：`native_ios/CorePackage`。
2. 确认 `BreezeNativeCore` 被 app target 正确链接。

## 3) 配置 Build Settings [Xcode-only]
1. 按环境拆分配置：Debug / Staging / Release。
2. 通过 `.xcconfig` 注入 baseURL、feature flags、日志级别。
3. 如需 Rust FFI，配置 bridging/静态库链接参数。

## 4) 完善运行时注入 [Xcode-only]
1. 在 `BreezeApp/App/AppContext.swift` 中接入真实依赖：
   - 登录 token 注入
   - 鉴权 header
   - request timeout / retry policy
2. 在 `EnvironmentPlaceholders.swift` 补齐配置下发策略。

## 5) 路由收口 [Xcode-only]
1. 将 Flutter 路由映射逐个绑定到 `AppRoute`。
2. 在 `AppRouteViewFactory` 中替换占位页为真实页面。
3. 深链（Universal Link）/推送跳转统一落到 `AppRouter`。

## 6) 数据层收口 [Xcode-only]
1. 对齐真实 API 字段（当前仅通用 envelope 占位）。
2. 接入错误码映射到 `AppError`。
3. 补齐分页策略、空态策略、重试策略。

## 7) 存储与安全收口 [Xcode-only]
1. 用 Keychain 实现 `SecureStore` 的生产版本。
2. 用 SwiftData/CoreData 承载历史、收藏、下载索引。
3. 做数据迁移方案（Flutter 历史数据 -> iOS 本地）。

## 8) 系统能力与权限 [Xcode-only]
1. 通知：`UNUserNotificationCenter`。
2. 相册/文件访问权限声明与申请。
3. 后台下载：`URLSessionConfiguration.background` + 恢复策略。

## 9) 质量保障
1. 单测扩展到 Ranking/Search ViewModel。
2. 增加 snapshot/UI test（tab 导航、路由跳转、空态/错误态）。
3. 真机验证：登录、下载、阅读连续性。

## 10) 发布前检查 [Xcode-only]
1. App Transport Security / 证书策略。
2. 隐私清单与权限文案。
3. Archive + TestFlight smoke test。
