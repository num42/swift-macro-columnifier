// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let name = "Columnifier"

let package = Package(
  name: name,
  platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: name,
      targets: [name]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/num42/swift-macrotester.git", from: "2.1.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0"),
    .package(url: "https://github.com/groue/GRDB.swift.git", from: "7.5.0"),
  ],
  targets: [
    .macro(
      name: "\(name)Macros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ],
      path: "Sources/Internal"
    ),
    .target(
      name: name,
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "GRDB", package: "GRDB.swift"),
        .product(name: "GRDBSQLite", package: "GRDB.swift"),
      ],
      path: "Sources/External"
    ),
    .testTarget(
      name: "\(name)Tests",
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "MacroTester", package: "swift-macrotester"),
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
      ],
      path: "Tests/MacroTests",
      resources: [.copy("Resources")]
    ),
  ]
)
