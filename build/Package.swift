// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "OpenAPIClient",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "OpenAPIClient", targets: ["OpenAPIClient"])
    ],
    targets: [
        .target(name: "OpenAPIClient")
    ]
)
