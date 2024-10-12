// swift-tools-version: 6.0

/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "SwiftUIFrameReader",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "SwiftUIFrameReader", targets: ["SwiftUIFrameReader"])
    ],
    targets: [
        .target(name: "SwiftUIFrameReader")
    ]
)

