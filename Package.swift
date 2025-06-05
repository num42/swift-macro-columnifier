// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let name = "Columnifier"

let package = Package(
  name: name,
  platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: name,
      targets: [name]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/num42/swift-macrotester.git", from: "1.0.2"),
    .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.1"),
    .package(url: "https://github.com/groue/GRDB.swift.git", from: "7.0.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    // Macro implementation that performs the source transformation of a macro.
    .macro(
      name: "\(name)Macros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    // Library that exposes a macro as part of its API, which is used in client programs.
    .target(
      name: name,
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "GRDB", package: "GRDB.swift"),
        .product(name: "CSQLite", package: "GRDB.swift")
      ]
    ),
    // A test target used to develop the macro implementation.
    .testTarget(
      name: "\(name)Tests",
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "MacroTester", package: "swift-macrotester"),
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
      ],
    // Copying Resources somehow breaks codesigning
      resources: [
        // Copy Tests/ExampleTests/Resources directories as-is.
        // Use to retain directory structure.
        // Will be at top level in bundle.
        .copy("Resources")
      ]
    )
  ]
)
