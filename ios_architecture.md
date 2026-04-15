# 原生 iOS 目标架构说明

## 1. 架构总览
采用 **SwiftUI + MVVM + Service/Repository + Core 能力层**。

```text
App
  AppEntry
  AppRouter
  AppEnvironment

Features
  Home
    Views
    ViewModels
    Models
    Services
  Ranking
  Search
  ComicInfo
  ComicRead
  Download
  Bookshelf
  Settings

Core
  Networking
  Storage
  Logging
  Utilities
  Extensions
  DesignSystem
```

## 2. 分层职责
- **View (SwiftUI)**：只处理渲染与用户事件，不做 IO。
- **ViewModel**：状态编排、调用 Service、输出 UI State。
- **Service/Repository**：协议抽象外部能力（网络、文件、权限、数据库）。
- **Core**：通用基础设施（HTTP 客户端、错误模型、日志、存储）。

## 3. 状态规范
统一 `LoadingState`：
- `idle`
- `loading`
- `loaded`
- `empty`
- `failed(message:)`

后续复杂页面可扩展为独立 State 枚举，但保持错误与加载语义一致。

## 4. 网络规范
- 统一走 `URLSession` 封装（当前已落地 `HTTPClient` + `APIRequestBuilder`）。
- 请求模型与响应模型均使用 `Codable`。
- 错误统一映射为 `NetworkError`，ViewModel 再转为用户可见提示。

## 5. 存储规范
- 偏好配置：`UserDefaults`。
- 凭证：`Keychain`（待落地）。
- 下载索引/历史：优先 SwiftData，若性能或兼容性受限再评估 Core Data。
- 文件实体统一放 App 沙盒 `Application Support`。

## 6. 平台能力替代策略
- Flutter plugin → iOS 原生能力替代：
  - `image_picker` → `PhotosPicker`/`UIImagePickerController`
  - `file_selector` → `UIDocumentPickerViewController`
  - `background_downloader` → `URLSessionConfiguration.background`
  - `flutter_local_notifications` → `UNUserNotificationCenter`
  - `permission_guard` → 各系统权限 API + 统一 PermissionService

## 7. 当前已落地（第一轮）
`native_ios/CorePackage` 已提供：
- `AppEnvironment`
- `NetworkError` / `HTTPClient` / `APIRequestBuilder`
- `AppLogger` / `ConsoleLogger`
- `KeyValueStore` / `UserDefaultsStore`
- 示例 Feature：`HomeCategory` / `RemoteHomeService` / `HomeViewModel`
- 对应单元测试 `HomeViewModelTests`
