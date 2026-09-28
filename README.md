# Columnifier

Turns key paths into GRDB `Column` values or qualified column name strings.

## Requirements

- Swift 6.3 toolchain or later (tested with Xcode 27)
- Platforms: macOS 14, iOS 13, tvOS 13, watchOS 6, macCatalyst 13

## Usage

```swift
#Columnify(\User.name)          // Column("name")
#QualifiedColumnName(\User.id)  // "User.id"
```

## Notes

Pass a key path with a root type; the macros are freestanding expressions.
