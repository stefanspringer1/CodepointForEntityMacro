# CodepointForEntityMacro

This macro is like the [CodepointMacro](https://github.com/stefanspringer1/CodepointMacro) but for named character references (entities) as defined in [SwiftUtilities](https://github.com/stefanspringer1/SwiftUtilities) (which should follow [the W3C definitions](https://dev.w3.org/html5/spec-LC/named-character-references.html)).

In the following exmaple, the macro is expanded to `0x222B`:

```swift
let result: UInt32 = #codepointForEntity("int")
print("0x\(String(format: "%X", result))") // prints "0x222B"
```

You can also use the XML notation instead of the entity name:

```swift
let result: UInt32 = #codepointForEntity("&int;")
print("0x\(String(format:" %X", result))") // prints "0x222B"
```
