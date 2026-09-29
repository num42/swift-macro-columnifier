// swift-tools-version:6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

internal import CompilerPluginSupport
internal import PackageDescription

let name = "Columnifier"

let swiftSettings: [SwiftSetting] = [
  .enableUpcomingFeature("InternalImportsByDefault")
]

let package = Package(
  name: name,
  platforms: [.macOS(.v14), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: name,
      targets: [name]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/num42/swift-macrohelper.git", from: "1.1.0"),
    .package(url: "https://github.com/num42/swift-macrotester.git", from: "2.3.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "603.0.2"),
    .package(url: "https://github.com/groue/GRDB.swift.git", from: "7.5.0"),
  ],
  targets: [
    .macro(
      name: "\(name)Macros",
      dependencies: [
        .product(name: "MacroHelper", package: "swift-macrohelper"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
      ],
      path: "Sources/Internal",
      swiftSettings: swiftSettings
    ),
    .target(
      name: name,
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "GRDB", package: "GRDB.swift"),
        .product(name: "GRDBSQLite", package: "GRDB.swift"),
      ],
      path: "Sources/External",
      swiftSettings: swiftSettings
    ),
    .testTarget(
      name: "\(name)Tests",
      dependencies: [
        .target(name: "\(name)Macros"),
        .product(name: "MacroTester", package: "swift-macrotester"),
        .product(name: "SwiftSyntaxMacroExpansion", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacrosGenericTestSupport", package: "swift-syntax"),
      ],
      path: "Tests/MacroTests",
      resources: [.copy("Resources")],
      swiftSettings: swiftSettings
    ),
  ]
)
