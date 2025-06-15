// Package.swift
import PackageDescription

let package = Package(
    name: "FredChartsApp",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "FredChartsApp", targets: ["FredChartsApp"])
    ],
    targets: [
        .target(
            name: "FredChartsApp",
            path: "Sources/FredChartsApp"
        ),
        .testTarget(
            name: "FredChartsAppTests",
            dependencies: ["FredChartsApp"],
            path: "Tests/FredChartsAppTests"
        )
    ]
)
