// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Pkg",
    dependencies: [
        .package(url: "https://github.com/apple/swift-format.git", .branch("swift-5.5-branch"))
    ],
    targets: []
)
