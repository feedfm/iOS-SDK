// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FeedMedia",
    products: [
        .library(
            name: "FeedMedia",
            targets: ["FeedMedia"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "FeedMedia", path: "FeedMedia.xcframework")
        .target(
            name: "PrivacyInfo",
            path: "Sources",
            resources: [.process("PrivacyInfo.xcprivacy")]
        )
    ]
)
