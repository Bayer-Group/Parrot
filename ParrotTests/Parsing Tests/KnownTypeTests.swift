
import XCTest

class KnownTypeTests: XCTestCase {

    func testUnknownTypeReturnsNil() {
        XCTAssertNil(KnownType.from(declaration: "CustomDelegate"))
    }
    
    func testUnknownOptionalTypeReturnsOptional() {
        XCTAssertEqual(KnownType.from(declaration: "CustomDelegate?"), .optionalType)
    }
    
    func testBasicTypesReturnAppropriateValues() {
        XCTAssertEqual(KnownType.from(declaration: "Int"), .intType)
        XCTAssertEqual(KnownType.from(declaration: "Double"), .doubleType)
        XCTAssertEqual(KnownType.from(declaration: "String"), .stringType)
        XCTAssertEqual(KnownType.from(declaration: "Bool"), .boolType)
    }
    
    func testBasicOptionalTypesReturnAppropriateValues() {
        XCTAssertEqual(KnownType.from(declaration: "Int?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "Double?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "String?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "Bool?"), .optionalType)
    }
    
    func testArrayTypesReturnAppropriateValues() {
        XCTAssertEqual(KnownType.from(declaration: "[Int]"), .arrayType)
        XCTAssertEqual(KnownType.from(declaration: "[Double]"), .arrayType)
        XCTAssertEqual(KnownType.from(declaration: "[String]"), .arrayType)
        XCTAssertEqual(KnownType.from(declaration: "[Bool]"), .arrayType)
        
        XCTAssertEqual(KnownType.from(declaration: "[Int]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[Double]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[String]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[Bool]?"), .optionalType)
    }
    
    func testDictionaryTypesReturnAppropriateValues() {
        XCTAssertEqual(KnownType.from(declaration: "[Int:Int]"), .dictionaryType)
        XCTAssertEqual(KnownType.from(declaration: "[String:Int]"), .dictionaryType)
        XCTAssertEqual(KnownType.from(declaration: "[String:Any]"), .dictionaryType)
        XCTAssertEqual(KnownType.from(declaration: "[Int:Bool]"), .dictionaryType)
        
        XCTAssertEqual(KnownType.from(declaration: "[Int:Int]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[String:Int]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[String:Bool]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[Int:Bool]?"), .optionalType)
    }
    
    func testSetTypesReturnAppropriateValues() {
        XCTAssertEqual(KnownType.from(declaration: "Set<Int>"), .setType)
        XCTAssertEqual(KnownType.from(declaration: "Set<String>"), .setType)
        XCTAssertEqual(KnownType.from(declaration: "Set<Int>?"), .optionalType)
    }
    
    func testNestedArraysAndDictionariesReturnAppropriateValues() {
        XCTAssertEqual(KnownType.from(declaration: "[[Int]]"), .arrayType)
        XCTAssertEqual(KnownType.from(declaration: "[[Double]]"), .arrayType)

        // TODO: Support nested collection types
        
        // Parsing does not yet support this
//        XCTAssertEqual(KnownType.from(declaration: "[[Int:Int]]"), .arrayType)
//        XCTAssertEqual(KnownType.from(declaration: "[[String:Any]]"), .arrayType)
        
        XCTAssertEqual(KnownType.from(declaration: "[Int:[String]]"), .dictionaryType)
        XCTAssertEqual(KnownType.from(declaration: "[Int:[String]]"), .dictionaryType)
        
        XCTAssertEqual(KnownType.from(declaration: "[[Double]]?"), .optionalType)
        XCTAssertEqual(KnownType.from(declaration: "[[String:Bool]]?"), .optionalType)
    }
    
    func testDefaultValues() {
        XCTAssertEqual(KnownType.intType.defaultReturnValue, "0")
        XCTAssertEqual(KnownType.doubleType.defaultReturnValue, "0.0")
        XCTAssertEqual(KnownType.stringType.defaultReturnValue, "\"\"")
        XCTAssertEqual(KnownType.boolType.defaultReturnValue, "false")
        XCTAssertEqual(KnownType.optionalType.defaultReturnValue, "nil")
        XCTAssertEqual(KnownType.arrayType.defaultReturnValue, "[]")
        XCTAssertEqual(KnownType.dictionaryType.defaultReturnValue, "[:]")
        XCTAssertEqual(KnownType.setType.defaultReturnValue, "[]")
    }

    // TODO: Test tuples with known type e.g. [(error: String?, stuff: [String])]
}
