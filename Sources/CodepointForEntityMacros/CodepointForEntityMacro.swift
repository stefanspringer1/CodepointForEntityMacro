import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation
import Utilities

fileprivate let entities = Dictionary(uniqueKeysWithValues: characterEntities.map { key, value in (key, String(value)) })
    .merging(w3cFormulaEntitiesWithSingleCodepoint.map { key, value in (key, String(value)) }, uniquingKeysWith: { (old,_) in old })

/// An error with a description.
///
/// When printing such an error, its descrition is printed.
struct CodepointForEntityError: LocalizedError, CustomStringConvertible {

    private let message: String

    public init(_ message: String) {
        self.message = message
    }
    
    public var description: String { message }
    
    public var errorDescription: String? { message }
}

public struct CodepointForEntity: ExpressionMacro {
    public static func expansion<Node: FreestandingMacroExpansionSyntax,
                                 Context: MacroExpansionContext>(of node: Node,
                                                                 in context: Context) throws -> ExprSyntax {
        
        guard
            /// 1. Grab the first (and only) Macro argument.
            let argument = node.argumentList.first?.expression,
            /// 2. Ensure the argument contains of a single String literal segment.
            let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
            segments.count == 1,
            /// 3. Grab the actual String literal segment.
            case .stringSegment(let literalSegment)? = segments.first
        else {
            throw CodepointForEntityError("macro requires static string literal")
        }
        
        var text = literalSegment.content.text
        if text.hasPrefix("&") && text.hasSuffix(";") {
            text = String(text.dropFirst().dropLast())
        }
        
        guard let translated = entities[text] else {
            throw CodepointForEntityError("Unkown entity \"\(text)\"")
        }
        
        let scalars = translated.unicodeScalars
        if scalars.count > 1 {
            throw CodepointForEntityError("String contains more than one Unicode scalar")
        }
        guard let scalar = scalars.first else {
            throw CodepointForEntityError("String is empty")
        }
        
        let expr: ExprSyntax = "0x\(raw: String(format:"%X", scalar.value))"
        return ExprSyntax(expr)

    }
}
