
import XCTest

class FunctionGeneratorTests: XCTestCase {
    
    // TODO: Add more tests for FunctionGenerator
    
    // MARK: - CallCount
    func testFunctionGeneratorStubEntriesGeneratesCallCountStub() {
        let testFunction = Function(name: "basicFunction", returnType: nil, arguments: [], defaultReturnValue: nil)
        
        let result = testFunction.stubEntries
        
        XCTAssertEqual(result[0], "var basicFunctionCallCount = 0")
    }
    
    // MARK: - ShouldReturn
    func testFunctionGeneratorStubEntriesGeneratesShouldReturnStubUsingDefaultReturnValue() {
        let testFunction = Function(name: "basicFunction", returnType: "String", arguments: [], defaultReturnValue: "test")
        
        let result = testFunction.stubEntries
        
        XCTAssertTrue(result.contains("var basicFunctionShouldReturn: String = test"))
    }
    
    func testFunctionGeneratorStubEntriesGeneratesShouldReturnStubNoDefaultReturnValue() {
        let testFunction = Function(name: "basicFunction", returnType: "Int", arguments: [], defaultReturnValue: nil)
        
        let result = testFunction.stubEntries
        
        XCTAssertTrue(result.contains("var basicFunctionShouldReturn: Int = <#Default return value#>"))
    }
    
    func testFunctionGeneratorStubEntriesGeneratesShouldReturnStubNoDefaultReturnValueString() {
        let testFunction = Function(name: "basicFunction", returnType: "String", arguments: [], defaultReturnValue: "")
        
        let result = testFunction.stubEntries
        
        // Comparison does not catch \"\"
        XCTAssertTrue(result.contains("var basicFunctionShouldReturn: String = "))
    }
    
    // MARK: - CalledWith
    func testFunctionGeneratorStubEntriesGeneratesCalledWithForOneArgument() {
        let testArgument = Argument(name: "testArgument", type: "Int", externalName: nil)
        let testFunction = Function(name: "basicFunction", returnType: "String", arguments: [testArgument], defaultReturnValue: "test")
        
        XCTAssertTrue(testFunction.stubEntries.contains("var basicFunctionCalledWith = [Int]()"))
    }
    
    func testFunctionGeneratorStubEntriesGeneratesCalledWithTupleForMoreThanOneArgument() {
        let testArgument1 = Argument(name: "testArgument1", type: "Int", externalName: nil)
        let testArgument2 = Argument(name: "testArgument2", type: "String", externalName: "externalTest")
        let testFunction = Function(name: "basicFunction", returnType: "String", arguments: [testArgument1, testArgument2], defaultReturnValue: "test")
        
        XCTAssertTrue(testFunction.stubEntries.contains("var basicFunctionCalledWith = [(testArgument1: Int, testArgument2: String)]()"))
    }
    
    // TODO: more robust tests on closure arguments
    func testFunctionGeneratorStubEntriesRemovesEscapingAnnotationFromArgumentTypes() {
        let testEscapingArgument = Argument(name: "testEscapingArgument", type: "@escaping () -> ()", externalName: nil)
        let testFunction = Function(name: "functionWithEscapingArgument", returnType: nil, arguments: [testEscapingArgument], defaultReturnValue: nil)
        
        XCTAssertEqual(testFunction.stubEntries[1], "var functionWithEscapingArgumentCalledWith = [() -> ()]()")
    }
    
    // TODO: Smart Completion Return Value for Stub
}

