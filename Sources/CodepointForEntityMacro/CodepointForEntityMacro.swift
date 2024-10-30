import Foundation

/// This macro get you the Unicode codepoint integer value for a String that only contains one Unicode code point.
///
/// In the following exmaple, the macro is expanded to `0x222B`:
///
/// ```swift
/// let result: UInt32 = #codepoint("∫")
/// print("0x\(String(format:"%X", result))") // prints "0x222B"
/// ```
///
/// Note that to convert such a String to `UnicodeScalar`, to do not need any macro:
///
/// ```swift
/// let result: UnicodeScalar = UnicodeScalar("∫")
/// print("0x\(String(format:"%X", result.value))")
/// ```
///
/// In both cases, if the String is composed of more than one scalar or it is empty, the code does not compile.
@freestanding(expression)
public macro codepointForEntity(_ text: String) -> UInt32 = #externalMacro(module: "CodepointForEntityMacros", type: "CodepointForEntity")
