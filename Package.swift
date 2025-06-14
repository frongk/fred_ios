// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FredChartsApp",
    platforms: [
        .iOS(.v16)
    ],
    targets: [
        .executableTarget(
            name: "FredChartsApp",
            path: "Sources/FredChartsApp")
    ]
)
