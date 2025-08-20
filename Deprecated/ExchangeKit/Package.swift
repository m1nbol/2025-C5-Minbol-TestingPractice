// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

//import PackageDescription
//
//let package = Package(
//    name: "ExchangeKit",
//    products: [
//        // Products define the executables and libraries a package produces, making them visible to other packages.
//        .library(
//            name: "ExchangeKit",
//            targets: ["ExchangeKit"]),
//    ],
//    targets: [
//        // Targets are the basic building blocks of a package, defining a module or a test suite.
//        // Targets can depend on other targets in this package and products from dependencies.
//        .target(
//            name: "ExchangeKit"),
//        .testTarget(
//            name: "ExchangeKitTests",
//            dependencies: ["ExchangeKit"]
//        ),
//    ]
//)

import PackageDescription

let package = Package(
    name: "ExchangeKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "ExchangeKit", targets: ["ExchangeKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0")
    ],
    targets: [
        .target(
            name: "ExchangeKit",
            dependencies: [
                .product(name: "Moya", package: "Moya")
            ]
        ),
        .testTarget(
            name: "ExchangeKitTests",
            dependencies: ["ExchangeKit"]
        )
    ]
)
