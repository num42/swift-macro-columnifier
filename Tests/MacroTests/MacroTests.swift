internal import MacroTester
internal import SwiftSyntaxMacros
internal import SwiftSyntaxMacrosTestSupport
internal import Testing

#if canImport(ColumnifierMacros)
  import ColumnifierMacros

  let testMacros: [String: Macro.Type] = [
    "Columnify": ColumnifyMacro.self,
    "QualifiedColumnName": QualifiedColumnNameMacro.self,
  ]

  @Suite
  struct ColumnifierMacroTests {
    @Test func columnifyMacro() {
      MacroTester.testMacro(macros: testMacros)
    }

    @Test func qualifiedColumnNameMacro() {
      MacroTester.testMacro(macros: testMacros)
    }
  }
#endif
