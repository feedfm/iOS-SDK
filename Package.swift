// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FeedMedia",
    products: [
        .library(
            name: "FeedMedia",
            targets: ["FeedMediaWrapper"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "FeedMediaWrapper",
        dependencies: ["FeedMedia"],
        path: "FeedMedia-wrapper",
        resources: [.process("Resources/PrivacyInfo.xcprivacy")]),
        
        .binaryTarget(name: "FeedMedia", path: "FeedMedia.xcframework")
    ]
)
