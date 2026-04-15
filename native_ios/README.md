# Native iOS Workspace

该目录用于承载 Flutter → Native iOS 迁移产物。

当前包含：
- `CorePackage/`：可独立编译测试的 Swift Package（Core 基础设施 + Home/Ranking/Search 的 MVVM 迁移骨架）。
- `AppShell/`：SwiftUI App 壳工程源码组织（需本地 Xcode 建 target 后验证）。

## 当前阶段边界
- ✅ 在容器内可验证：`CorePackage` 的 Swift 编译/测试。
- ⚠️ 在容器内不可验证：iOS Target、签名能力、权限能力、后台下载、SwiftUI 预览。

## Xcode 收口清单
详见：`native_ios/xcode_handoff_checklist.md`
