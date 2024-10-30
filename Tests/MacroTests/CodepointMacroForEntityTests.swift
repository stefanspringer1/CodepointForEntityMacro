import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import CodepointForEntityMacro

final class CodepointForEntityMacroTests: XCTestCase {
    
    func testWithEntityName() throws {
        
        let result: UInt32 = #codepointForEntity("int")
        XCTAssertEqual(
            result,
            0x222B
        )
        
    }
    
    func testWithXMLEntityNotation() throws {
        
        let result: UInt32 = #codepointForEntity("&int;")
        XCTAssertEqual(
            result,
            0x222B
        )
        
    }
    
}
