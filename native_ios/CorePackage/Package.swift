// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "BreezeNativeCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "BreezeNativeCore",
            targets: ["BreezeNativeCore"]
        )
    ],
    targets: [
        .target(
            name: "BreezeNativeCore"
        ),
        .testTarget(
            name: "BreezeNativeCoreTests",
            dependencies: ["BreezeNativeCore"]
        )
    ]
)
