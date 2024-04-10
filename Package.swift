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
        .target(name: "FeedMediaWrapper",
        dependencies: ["FeedMedia"],
        path:"Sources"
        resources: [.process("PrivacyInfo.xcprivacy")]),
        
        .binaryTarget(name: "FeedMedia", path: "FeedMedia.xcframework")
    ]
)
