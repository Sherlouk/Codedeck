// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Codedeck",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .library(name: "Codedeck", targets: ["Codedeck"]),
        .library(name: "HIDSwift", targets: ["HIDSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Codedeck", dependencies: ["HIDSwift"]),
        .testTarget(name: "CodedeckTests", dependencies: ["Codedeck"]),
        
        .target(name: "HIDSwift", dependencies: []),
        .testTarget(name: "HIDSwiftTests", dependencies: ["HIDSwift"]),
    ]
)
