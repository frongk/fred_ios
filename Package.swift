// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SimplePreviewApp",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SimplePreviewApp", targets: ["SimplePreviewApp"]),
        .executable(name: "PreviewHostApp", targets: ["PreviewHostApp"])
    ],
    targets: [
        .target(name: "SimplePreviewApp", path: "Sources/SimpleApp"),
        .executableTarget(
            name: "PreviewHostApp",
            dependencies: ["SimplePreviewApp"],
            path: "PreviewHostApp"
        )
    ]
)
