import GRDBSQLite
import GRDB

@freestanding(expression)
public macro Columnify<S, T>(_ value: KeyPath<S, T>) -> Column = #externalMacro(
  module: "ColumnifierMacros",
  type: "ColumnifyMacro"
)

@freestanding(expression)
public macro QualifiedColumnName<S, T>(_ value: KeyPath<S, T>) -> String = #externalMacro(
  module: "ColumnifierMacros",
  type: "QualifiedColumnNameMacro"
)
