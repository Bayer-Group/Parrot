import XCTest

class DefaultsParserTests: XCTestCase {
    // Notes:
    // Assumes line starts with 'let' and is on one line
    // Might need to handle computed vars and/or function types
    // Techincally could make a computed var a valid way to define a default return type
    
    // Right now it takes first definition of class in defaults file
    
    // Doesn't handle commented out edge case of block comments containing definitions
    
    func testDefaultsParser_DictionaryEntryForEachLine() {
        let lines = [
            "let test0: TestClass0 = TestClass0()",
            "let test1 :TestClass1 = TestClass1(myInt: 10)",
            "let test2 : TestClass2 = TestClass2(myString: \"string\", external internal: 0)",
            "let test3:TestClass3 = TestClass3( test: Test(), again again: Again() )",
            "let  test4: TestClass4   =   TestClass4 ()"
        ]
        
        let resultTable = DefaultsParser.defaultsTable(from: lines)
        
        XCTAssertEqual(resultTable.count, 5)
        XCTAssertEqual(resultTable["TestClass0"], "TestClass0()")
        XCTAssertEqual(resultTable["TestClass1"], "TestClass1(myInt: 10)")
        XCTAssertEqual(resultTable["TestClass2"], "TestClass2(myString: \"string\", external internal: 0)")
        XCTAssertEqual(resultTable["TestClass3"], "TestClass3( test: Test(), again again: Again() )")
        XCTAssertEqual(resultTable["TestClass4"], "TestClass4 ()")
    }
    
    func testDefaultsParser_DoesNotOverriteDuplicateTypes() {
        let lines = [
            "let test: Test = Test(a test: Test())",
            "let testRepeated: Test = Test(b test: test)",
        ]
        
        let resultTable = DefaultsParser.defaultsTable(from: lines)
        
        XCTAssertEqual(resultTable.count, 1)
        XCTAssertEqual(resultTable["Test"], "Test(a test: Test())")
    }
    
    func testDefaultsParser_IgnoresComments() {
        let lines = [
            "  // I am a comment",
            "//let anOldSecondOne: Type = Old()",
            "let def: Type = Type()",
            "//I am another comment",
            " /// let anOldOne: OldOneProtocol = Old()"
        ]
        
        let resultTable = DefaultsParser.defaultsTable(from: lines)
        
        XCTAssertEqual(resultTable.count, 1)
        XCTAssertEqual(resultTable["Type"], "Type()")
    }
    
//    func testDefaultsParser_IgnoresBlockComments() {
//        let lines = [
//            "/* a block comment let test: Test = Test()",
//            "let aSneakyTest: Sneaky = Sneaky()",
//            "let aSneakyTest2: Sneaky2 = Sneaky2()*/",
//            "/*let def: TypeProtocol = Type(test: test)*/",
//            "let def: TypeProtocol = Type()"
//        ]
//
//        let resultTable = DefaultsParser.defaultsTable(from: lines)
//
//        XCTAssertEqual(resultTable.count, 1)
//        XCTAssertEqual(resultTable["TypeProtocol"], "Type()")
//    }
    
    func testDefaultsParser_IgnoresImports() {
        let lines = [
            "import RiseKit",
            "let def: Type = Type()",
            "@testable import Parrot",
            "let def2: Type2 = Type2(type: type)"
        ]
        
        let resultTable = DefaultsParser.defaultsTable(from: lines)
        
        XCTAssertEqual(resultTable.count, 2)
        XCTAssertEqual(resultTable["Type"], "Type()")
        XCTAssertEqual(resultTable["Type2"], "Type2(type: type)")
    }
    
    func testDefaultsParser_RequiresTypeDefinedByColonType() {
        let lines = [
            "let iDontKnowType = Type()",
            "let thisIsWhy: ProtocolImMocking = Type()"
        ]
        
        let resultTable = DefaultsParser.defaultsTable(from: lines)
        
        XCTAssertEqual(resultTable.count, 1)
        XCTAssertEqual(resultTable["ProtocolImMocking"], "Type()")
    }
    
    func testDefaultsParser_ReadsInOptionalTypesAsTableValues() {
        let lines = [
            "let customOptional: Custom? = Custom()",
            "let knownOptional: Int? = Int(exactly: 3.14)"
        ]
        
        let resultTable = DefaultsParser.defaultsTable(from: lines)
        
        XCTAssertEqual(resultTable.count, 2)
        XCTAssertEqual(resultTable["Custom?"], "Custom()")
        XCTAssertEqual(resultTable["Int?"], "Int(exactly: 3.14)")
    }
}
