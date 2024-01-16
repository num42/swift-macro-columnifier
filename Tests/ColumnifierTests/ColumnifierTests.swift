import MacroTester
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ColumnifierMacros)
  import ColumnifierMacros

  let testMacros: [String: Macro.Type] = [
    "Columnify": ColumnifyMacro.self,
    "QualifiedColumnName": QualifiedColumnNameMacro.self
  ]
#endif

final class ColumnifierTests: XCTestCase {
  func testColumnifyMacro() throws {
    testMacro(macros: testMacros)
  }

  func testQualifiedColumnNameMacro() throws {
    testMacro(macros: testMacros)
  }
}
