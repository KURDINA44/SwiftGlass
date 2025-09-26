// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGlass",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .visionOS(.v1),
        .watchOS(.v10),
        .tvOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftGlass",
            targets: ["SwiftGlass"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftGlass"
        ),
        .testTarget(
            name: "SwiftGlassTests",
            dependencies: ["SwiftGlass"]
        ),
    ]
)
