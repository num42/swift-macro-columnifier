// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "Columnifier",
  platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "Columnifier",
      targets: ["Columnifier"]
    ),
    .executable(
      name: "ColumnifierClient",
      targets: ["ColumnifierClient"]
    )
  ],
  dependencies: [
    .package(path: "../MacroTester"),
    // Depend on the Swift 5.9 release of SwiftSyntax
    .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    .package(url: "https://github.com/groue/GRDB.swift.git", from: "6.18.0")
//    .package(
//      url: "https://github.com/realm/SwiftLint",
//      from: "0.53.0"
//    )
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    // Macro implementation that performs the source transformation of a macro.
    .macro(
      name: "ColumnifierMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),

    // Library that exposes a macro as part of its API, which is used in client programs.
    .target(
      name: "Columnifier",
      dependencies: [
        "ColumnifierMacros",
        .product(name: "GRDB", package: "GRDB.swift"),
        .product(name: "CSQLite", package: "GRDB.swift")
      ]
    ),

    // A client of the library, which is able to use the macro in its own code.
    .executableTarget(
      name: "ColumnifierClient",
      dependencies: [
        "Columnifier",
        .product(name: "GRDB", package: "GRDB.swift")
      ]
    ) // ,

    // A test target used to develop the macro implementation.
//    .testTarget(
//      name: "ColumnifierTests",
//      dependencies: [
//        "ColumnifierMacros",
//        .product(name: "MacroTester", package: "MacroTester"),
//        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
//      ]
    // Copying Resources somehow breaks codesigning
//      resources: [
//        // Copy Tests/ExampleTests/Resources directories as-is.
//        // Use to retain directory structure.
//        // Will be at top level in bundle.
//        .copy("Resources")
//      ]
//    )
  ]
)
