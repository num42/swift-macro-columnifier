import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct QualifiedColumnNameMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    guard let argument = node.arguments.first?.expression else {
      fatalError("compiler bug: the macro does not have any arguments")
    }

    let root = argument.as(KeyPathExprSyntax.self)!.root!.description
    let column = argument.as(KeyPathExprSyntax.self)!.components.description.replacingOccurrences(
      of: ".", with: "")

    return "\"\(raw: root).\(raw: column)\""
  }
}
