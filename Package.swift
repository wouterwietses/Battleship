// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "Battleship",
    platforms: [
       .macOS(.v13)
    ],
    products: [
        .library(name: "Battleship", targets: ["Battleship"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.7.0"),
        .package(url: "https://github.com/swift-server/swift-openapi-vapor", from: "1.0.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.1"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
    ],
    targets: [
        .target(
            name: "Battleship",
            dependencies: [],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "BattleshipTests",
            dependencies: [
                .target(name: "Battleship"),
            ],
            swiftSettings: swiftSettings
        ),
        .executableTarget(
            name: "Api",
            dependencies: [
                .target(name: "Battleship"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIVapor", package: "swift-openapi-vapor"),
            ],
            swiftSettings: swiftSettings,
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
            ]
        ),
        .testTarget(
            name: "ApiTests", 
            dependencies: [
                .target(name: "Api"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
