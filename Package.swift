// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "RSSReader",
    products: [
        .library(
            name: "RSSReader",
            targets: ["RSSReader"]),
    ],
    dependencies: [
		.package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "5.0.1")
    ],
    targets: [
        .target(
            name: "RSSReader",
            dependencies: [
				"SWXMLHash"
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
