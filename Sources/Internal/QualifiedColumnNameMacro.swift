public import SwiftDiagnostics
public import SwiftSyntax
public import SwiftSyntaxMacros

public struct QualifiedColumnNameMacro: ExpressionMacro {
  public enum MacroDiagnostic: String, DiagnosticMessage {
    case requiresArgument = "#QualifiedColumnName requires an argument"
    case requiresKeyPath = "#QualifiedColumnName requires a key path argument"
    case requiresRoot = "#QualifiedColumnName requires a root type in the key path"

    public var message: String { rawValue }

    public var diagnosticID: MessageID {
      MessageID(domain: "Columnifier", id: rawValue)
    }

    public var severity: DiagnosticSeverity { .error }
  }

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    guard let argument = node.arguments.first?.expression else {
      let diagnostic = Diagnostic(
        node: Syntax(node),
        message: MacroDiagnostic.requiresArgument
      )
      context.diagnose(diagnostic)
      return "nil"
    }

    guard let keyPath = argument.as(KeyPathExprSyntax.self) else {
      let diagnostic = Diagnostic(
        node: Syntax(node),
        message: MacroDiagnostic.requiresKeyPath
      )
      context.diagnose(diagnostic)
      return "nil"
    }

    guard let root = keyPath.root?.description else {
      let diagnostic = Diagnostic(
        node: Syntax(node),
        message: MacroDiagnostic.requiresRoot
      )
      context.diagnose(diagnostic)
      return "nil"
    }

    let column = keyPath.components.description.replacingOccurrences(of: ".", with: "")

    return "\"\(raw: root).\(raw: column)\""
  }
}
