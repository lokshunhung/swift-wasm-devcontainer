// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
        .package(url: "https://github.com/apple/swift-format.git", .branch("release/5.7")),
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.17.0")
    ],
    targets: [
        .executableTarget(
            name: "Hello",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit")
            ]),
        .testTarget(
            name: "HelloTests",
            dependencies: ["Hello"]),
    ]
)
