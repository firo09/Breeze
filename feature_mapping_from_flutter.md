# Flutter Feature 到 iOS Feature 映射

## 1. 顶层导航
Flutter 当前主入口（底部 4 Tab）：
- Home
- Ranking
- Bookshelf
- More

iOS 目标：
- iPhone：`TabView`
- iPad：`NavigationSplitView` 或左侧 Sidebar

## 2. 路由映射（首批）
| Flutter 路由 | iOS Feature | 说明 |
|---|---|---|
| `HomeRoute` | `Features/Home` | 首页分类与关键词 |
| `RankingListRoute` | `Features/Ranking` | 排行榜入口 |
| `SearchRoute` / `SearchResultRoute` | `Features/Search` | 搜索与结果分页 |
| `ComicInfoRoute` | `Features/ComicInfo` | 漫画详情、章节、操作 |
| `ComicReadRoute` | `Features/ComicRead` | 阅读器（高优先性能优化） |
| `DownloadRoute` / `DownloadTaskRoute` | `Features/Download` | 下载、任务管理、导出 |
| `BookshelfRoute` | `Features/Bookshelf` | 收藏、历史、离线 |
| `MoreRoute` + Setting Routes | `Features/Settings` | 用户信息与配置 |

## 3. 状态管理映射
- Flutter: `bloc/cubit + event_bus`
- iOS: `MVVM + @Observable/@StateObject + async/await`
- 全局事件（如登录失效、手动同步）改为：
  - `AppRouter` 层统一处理
  - 或 `NotificationCenter`（仅跨 feature 事件）

## 4. 网络层映射
- Flutter 现状：Bika/JM 请求经 Rust/QJS 构建签名和请求逻辑。
- iOS 方案：
  - 短期：保留 Rust Core 能力边界，iOS 以 Swift Service 包装。
  - 中期：逐步替换可替换接口为纯 Swift + URLSession。

## 5. 存储层映射
- Flutter：ObjectBox + SharedPreferences + 文件系统。
- iOS：
  - 用户偏好：UserDefaults
  - 历史/收藏/下载索引：SwiftData（优先）
  - 文件：FileManager + 后台下载目录管理

## 6. 已识别平台特有逻辑
- 后台下载与通知
- 图片保存相册权限
- 文件导入导出
- 登录态失效与自动签到
- WebDAV / S3 同步
- Rust FFI（flutter_rust_bridge）
