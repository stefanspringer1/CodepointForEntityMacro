// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "CodepointForEntityMacro",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "CodepointForEntityMacro",
            targets: ["CodepointForEntityMacro"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/stefanspringer1/SwiftUtilities", from: "1.0.0"),
    ],
    targets: [
        .macro(
            name: "CodepointForEntityMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "Utilities", package: "SwiftUtilities"),
            ]
        ),
        .target(
            name: "CodepointForEntityMacro",
            dependencies: ["CodepointForEntityMacros"]
        ),
        .testTarget(
            name: "MacroTests",
            dependencies: [
                "CodepointForEntityMacro",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        )
    ]
)
