# 已知问题与风险清单

## A. 当前环境限制
1. 当前 CI/容器不包含 Xcode，无法执行 `xcodebuild` 进行 iOS App 真机构建验证。
2. 因此本轮先确保 Swift 核心包（不依赖 UIKit/SwiftUI）可在 Swift toolchain 下编译和测试。

## B. 迁移技术风险
1. **Rust/QJS 请求链路语义复杂**：Bika/JM 请求签名、鉴权与错误语义在 Rust 层，直接替换风险高。
2. **阅读器性能风险**：`ComicRead` 涉及大图加载、手势、分页与历史写入，需专项性能治理。
3. **下载/导出链路复杂**：后台任务、权限、zip 导出、断点续传均依赖平台能力。
4. **全局事件总线迁移风险**：Flutter `event_bus` 迁移到 iOS 后需避免新“隐式耦合”。

## C. 业务语义假设（本轮）
1. 首页分类接口可抽象为 `/categories`，并用统一 `HomeCategory` 承载。
2. iOS 首批仅搭建骨架，不改动线上协议语义。
3. 先迁移“读操作”Feature，再迁移“写操作/离线”Feature。

## D. 待办
1. 增加 iOS App Target（SwiftUI App + Router）。
2. 增加 PermissionService 与 KeychainService。
3. 为 Search/Ranking 落地第二批端到端示例。
4. 将 Flutter Feature 的“已迁移状态”以表格持续维护。
