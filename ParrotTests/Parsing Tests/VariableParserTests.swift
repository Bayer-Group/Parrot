
import XCTest

class VariableParserTests: XCTestCase {

    func testWhenInvalidStringGivenToParser_ThenNilIsReturned() {
        XCTAssertNil(Variable.from(declaration: "", defaultsTable: [:]))
        XCTAssertNil(Variable.from(declaration: "     ", defaultsTable: [:]))
        XCTAssertNil(Variable.from(declaration: "   \n  \t  \n ", defaultsTable: [:]))
        XCTAssertNil(Variable.from(declaration: " func wooh() -> String", defaultsTable: [:]))
        XCTAssertNil(Variable.from(declaration: " weak  doubleGet : Double {  get  } ", defaultsTable: [:]))
        XCTAssertNil(Variable.from(declaration: " var  doubleGet : Double {  set  } ", defaultsTable: [:]))
    }
    
    func testWhenDoubleGetIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "var   doubleGet : Double {  get  } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
         
        XCTAssertEqual(result.name, "doubleGet")
        XCTAssertEqual(result.type, "Double")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, false)
        XCTAssertEqual(result.defaultReturnValue, "0.0")
    }
    
    func testWhenOptionalIntGetSetIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "    var   optionalIntGetSet : Int? {  get  set } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "optionalIntGetSet")
        XCTAssertEqual(result.type, "Int?")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, true)
        XCTAssertEqual(result.defaultReturnValue, "nil")
    }
    
    func testWhenOptionalStringSetGetIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "   /t  /n   var   optionalStringSetGet : String? { set get }   /n  "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "optionalStringSetGet")
        XCTAssertEqual(result.type, "String?")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, true)
        XCTAssertEqual(result.defaultReturnValue, "nil")
    }
    
    func testWhenWeakDelegateIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "   weak   var   optionalDelegate : Delegate? { get set } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "optionalDelegate")
        XCTAssertEqual(result.type, "Delegate?")
        XCTAssertEqual(result.isWeak, true)
        XCTAssertEqual(result.isGetSet, true)
        XCTAssertEqual(result.defaultReturnValue, "nil")
    }
    
    func testWhenVarWithArrayReturnIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "var myArray:[Double] {  get  } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "myArray")
        XCTAssertEqual(result.type, "[Double]")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, false)
        XCTAssertEqual(result.defaultReturnValue, "[]")
    }
    
    func testWhenVarWithOptionalArrayReturnIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "var myArray : [String]? {  get  } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "myArray")
        XCTAssertEqual(result.type, "[String]?")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, false)
        XCTAssertEqual(result.defaultReturnValue, "nil")
    }
    
    // TODO: Support Dictionaries as return values for variables
    
//    func testWhenVarWithDictionaryReturnIsPassed_ThenCorrectVariableIsCreated() {
//        let declaration = "var myDict : [Int:String] {  get  } "
//        guard let result = Variable.from(declaration: declaration) else { XCTFail(); return }
//
//        XCTAssertEqual(result.name, "myDict")
//        XCTAssertEqual(result.type, "[Int:String]")
//        XCTAssertEqual(result.isWeak, false)
//        XCTAssertEqual(result.isGetSet, false)
//        XCTAssertEqual(result.defaultReturnValue, "[:]")
//    }
//
//    func testWhenVarWithOptionalDictionaryReturnIsPassed_ThenCorrectVariableIsCreated() {
//        let declaration = "var myDict : [Int:Double]? {  get  } "
//        guard let result = Variable.from(declaration: declaration) else { XCTFail(); return }
//
//        XCTAssertEqual(result.name, "myDict")
//        XCTAssertEqual(result.type, "[Int:Double]")
//        XCTAssertEqual(result.isWeak, false)
//        XCTAssertEqual(result.isGetSet, false)
//        XCTAssertEqual(result.defaultReturnValue, "nil")
//    }
    
    func testWhenVarWithSetReturnIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "var mySet: Set<Int> {  get  } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "mySet")
        XCTAssertEqual(result.type, "Set<Int>")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, false)
        XCTAssertEqual(result.defaultReturnValue, "[]")
    }
    
    func testWhenVarWithOptionalSetReturnIsPassed_ThenCorrectVariableIsCreated() {
        let declaration = "var mySet: Set<Int>? {  get  } "
        guard let result = Variable.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "mySet")
        XCTAssertEqual(result.type, "Set<Int>?")
        XCTAssertEqual(result.isWeak, false)
        XCTAssertEqual(result.isGetSet, false)
        XCTAssertEqual(result.defaultReturnValue, "nil")
    }
    
    // MARK: Defaults table
    // TODO: this is the basic use case, could likely be more robust
    
    func testWhenCustomTypePresentedWithMatchingDefaultsTableEntry_ThenTableEntryIsUsed() {
        let declaration = "var myCustom: CustomProtocol { get }"
        let mockDefaultsTable = ["CustomProtocol": "CustomDefitition(test: \"\")"]
        
        guard let result = Variable.from(declaration: declaration, defaultsTable: mockDefaultsTable) else { XCTFail(); return  }
        
        XCTAssertEqual(result.defaultReturnValue, mockDefaultsTable["CustomProtocol"])
    }
    

    func testWhenKnownTypeHasMatchingDefaultsTableEntry_ThenTableEntryIsUsed() {
        let declaration = "var myCustom: Int { get }"
        let mockDefaultsTable = ["Int": "Int(exactly: 3.33)"]
        
        guard let result = Variable.from(declaration: declaration, defaultsTable: mockDefaultsTable) else { XCTFail(); return  }
        
        XCTAssertEqual(result.defaultReturnValue, mockDefaultsTable["Int"])
    }
}
