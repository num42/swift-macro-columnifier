# Columnifier

Turns key paths into GRDB `Column` values or qualified column name strings.

## Usage

```swift
#Columnify(\User.name)          // Column("name")
#QualifiedColumnName(\User.id)  // "User.id"
```

## Notes

Pass a key path with a root type; the macros are freestanding expressions.
