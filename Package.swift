// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "rss-reader",
    products: [
        .library(
            name: "RSSReader",
            targets: ["RSSReader"]),
    ],
    dependencies: [
		.package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "5.0.1"),
		.package(url: "https://github.com/apple/swift-nio.git", from: "2.21.0")
    ],
    targets: [
        .target(
            name: "RSSReader",
            dependencies: [
				"SWXMLHash",
				.product(name: "NIO", package: "swift-nio")
			]),
		.target(
			name: "Run",
			dependencies: ["RSSReader"]
		),
        .testTarget(
            name: "RSSReaderTests",
            dependencies: ["RSSReader"]),
    ]
)
