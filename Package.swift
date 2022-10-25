// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.17.0")
    ],
    targets: [
        .executableTarget(
            name: "Hello",
            dependencies: [
                // .product(name: "JavaScriptKit", package: "JavaScriptKit")
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "--export=wasm_main"], .when(platforms: [.wasi]))
            ]),
        .testTarget(
            name: "HelloTests",
            dependencies: ["Hello"]),
    ]
)
