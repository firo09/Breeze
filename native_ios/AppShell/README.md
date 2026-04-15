# Breeze iOS App Shell（Xcode 收口用）

> 说明：本目录为 **SwiftUI App 壳工程源码骨架**，用于回到本地 Mac 后由 Xcode 创建 iOS Target 并接手收口。
>
> 当前 CI/容器环境无法构建 `*.xcodeproj` / `*.xcworkspace`，因此此处代码仅做结构化迁移与组织，不声明“完整可运行”。

## 目录说明
- `BreezeApp/App`: App 入口与容器组装
- `BreezeApp/Routing`: SwiftUI 路由承载
- `BreezeApp/Environment`: 注入 `BreezeNativeCore` 依赖
- `BreezeApp/Features/*`: 各 Feature 的 SwiftUI 页面外壳
- `BreezeApp/DesignSystem`: 与 Core Design Token 对齐的 UI 层 token
- `BreezeApp/Shared`: 通用组件

## 本地 Xcode 收口必要动作（简版）
1. 新建 iOS App Target（iOS 17+）。
2. 通过 SPM 引入 `../CorePackage`。
3. 将本目录源码加入 target membership。
4. 在 `BreezeApp.swift` 设置真实 `AppRuntimeEnvironment` 与 `AppDependencyContainer`。
5. 补齐真实 API 字段映射与鉴权 header。
6. 连接真机调试权限能力（通知、相册、后台下载等）。
