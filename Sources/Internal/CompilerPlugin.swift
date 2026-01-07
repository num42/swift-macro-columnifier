import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ColumnifierPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    ColumnifyMacro.self,
    QualifiedColumnNameMacro.self,
  ]
}
