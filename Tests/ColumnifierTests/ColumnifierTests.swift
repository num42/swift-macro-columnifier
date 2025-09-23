import MacroTester
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

#if canImport(ColumnifierMacros)
  import ColumnifierMacros

  let testMacros: [String: Macro.Type] = [
    "Columnify": ColumnifyMacro.self,
    "QualifiedColumnName": QualifiedColumnNameMacro.self
  ]
#endif

@Suite("Columnifier Macro Tests")
struct ColumnifierTests {
    private static let macroTestNames = [
        "testColumnifyMacro",
        "testQualifiedColumnNameMacro"
    ]

    @Test("Check correctness of Macro expansion to their snapshots", arguments: Self.macroTestNames)
    func macroExpandsCorrectly(testName: String) {
        MacroTester.testMacro(testName: testName, macros: testMacros)
    }
}
