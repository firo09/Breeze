# Breeze Flutter → Native iOS 迁移计划

## 阶段 1：技术画像与迁移评估（已完成）
- 识别当前 Flutter 的页面/路由、状态管理、网络层、存储层、平台能力与插件。
- 输出迁移风险、边界假设、分阶段改造顺序。

## 阶段 2：原生 iOS 工程骨架（进行中）
- 新增 `native_ios/` 作为原生迁移工作区，避免直接扰动现有 Flutter 交付链路。
- 建立 `CorePackage`（Swift Package）承载 Core/Feature 代码，先落地可编译核心层。
- 建立统一错误模型、网络抽象、日志、KeyValue 存储抽象。
- 提供 Home 示例 Feature 的 `Model + Service + ViewModel` 端到端。

## 阶段 3：按 Feature 迁移（待开始）
优先级建议：
1. Home / Ranking（读多写少，接口边界清晰）
2. Search / SearchResult（查询链路与分页）
3. ComicInfo / Comments（详情+互动）
4. ComicRead（阅读器，手势和性能敏感）
5. Download / Bookshelf（离线、文件、持久化复杂）
6. More / Settings / WebDAV Sync（配置与同步）

每个 Feature 的 DoD：
- 页面 + ViewModel + Service + Repository 完整闭环。
- 覆盖加载/空态/错误/重试。
- 至少一组 ViewModel 单测。
- 对应 Flutter 页面标注“已迁移/待下线”。

## 阶段 4：规范化与清理（待开始）
- 统一命名、错误映射、日志域、异步风格（全部 async/await）。
- 抽离重复 UI 组件进 DesignSystem。
- 统一依赖注入策略（协议 + 构造注入）。

## 阶段 5：验证与交付（待开始）
- Xcode 构建（iPhone + iPad 模拟器）。
- 关键路径冒烟：登录、浏览、详情、阅读、下载、设置。
- 输出迁移总结、风险闭环与遗留问题。

## 当前批次实际改动
- 新增 `native_ios/CorePackage` 初始骨架并可运行单测。
- 新增迁移文档：
  - `migration_plan.md`
  - `ios_architecture.md`
  - `feature_mapping_from_flutter.md`
  - `known_issues.md`
