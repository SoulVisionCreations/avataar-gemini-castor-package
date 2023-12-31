// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeminiPackage",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GeminiPackage",
            targets: ["GeminiPackageTarget"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/maxxfrazer/FocusEntity.git", from: "2.3.0"),
         .package(url: "https://github.com/onevcat/Kingfisher", from : "7.6.2"),
         .package(url: "https://github.com/mixpanel/mixpanel-swift.git", from: "4.1.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GeminiPackageTarget",
            dependencies: [
                .target(
                    name: "GeminiFrameworkWrapper",
                    condition: .when(platforms: [.iOS])
                ),
            ],
            path: "GeminiPackage"
        ),
        .target(
            name: "GeminiFrameworkWrapper",
            dependencies: [
                .target(
                    name: "GeminiCastorFramework",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "FocusEntity", package: "FocusEntity",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "Kingfisher", package: "Kingfisher",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "Mixpanel", package: "mixpanel-swift",
                    condition: .when(platforms: [.iOS])
                )
            ],
            path: "GeminiFrameworkWrapper"
        ),
        .binaryTarget(
            name: "GeminiCastorFramework",
            path: "./Sources/GeminiCastorFramework.xcframework"
        )
    ]
)
