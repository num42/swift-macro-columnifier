import MacroTester
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

#if canImport(ColumnifierMacros)
  import ColumnifierMacros

  let testMacros: [String: Macro.Type] = [
    "Columnify": ColumnifyMacro.self,
    "QualifiedColumnName": QualifiedColumnNameMacro.self,
  ]
#endif

@Suite("Columnifier Macro Tests")
struct ColumnifierTests {
  @Test func columnifyMacro() {
    MacroTester.testMacro(macros: testMacros)
  }

  @Test func qualifiedColumnNameMacro() {
    MacroTester.testMacro(macros: testMacros)
  }
}
