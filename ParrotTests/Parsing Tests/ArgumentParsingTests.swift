import XCTest

class ArgumentParsingTests: XCTestCase {
    // TODO: Simple Cases for argument parsing

    // MARK: - Escaping completion blocks
    func testCompletionBlockArgumentWithEscapingAnnotation_ParsedWithAnnotationAsPartOfTheType() {
        guard let result = Argument.from(declaration: "completion: @escaping () -> ()") else { XCTFail(); return }
        
        XCTAssertEqual(result.externalName,  nil)
        XCTAssertEqual(result.name,  "completion")
        XCTAssertEqual(result.type,  "@escaping () -> ()")
    }
    
    func testArgumentParsing_WhenCompletionBlockWithOneParameter_GetsCorrectTypeDefinition() {
        guard let result = Argument.from(declaration: "completion: @escaping (String?) -> ()") else { XCTFail(); return }
        
        XCTAssertEqual(result.externalName, nil)
        XCTAssertEqual(result.name, "completion")
        XCTAssertEqual(result.type, "@escaping (String?) -> ()")
    }
    
    func testArgumentParsing_WhenCompletionBlockWithMultipleParameters_GetsCorrectTypeDefinition() {
        guard let result = Argument.from(declaration: "completion: @escaping (String?, String?) -> ()") else { XCTFail(); return }
        
        XCTAssertEqual(result.externalName, nil)
        XCTAssertEqual(result.name, "completion")
        XCTAssertEqual(result.type, "@escaping (String?, String?) -> ()")
    }
    
    func testArgumentParsing_WithCompletionBlockOddSpacing_GetsCorrectDefinition() {
        guard let result = Argument.from(declaration: "completion: @escaping ( String? , String?)->( )") else { XCTFail(); return }
        
        XCTAssertEqual(result.externalName, nil)
        XCTAssertEqual(result.name, "completion")
        XCTAssertEqual(result.type, "@escaping ( String? , String?)->( )")
    }
    
    
    // MARK: - Arguments From Arguments String

    func testArgumentsFromArgumentsString() {
        let result = Argument.argumentsFrom(argumentsString: "token: String, intArray: [Int], tuple: (Int?, String, [Int])?")

        XCTAssertEqual(result.count, 3)
        let firstArg = result[0]
        XCTAssertEqual(firstArg.externalName, nil)
        XCTAssertEqual(firstArg.name, "token")
        XCTAssertEqual(firstArg.type, "String")

        let secondArg = result[1]
        XCTAssertEqual(secondArg.externalName, nil)
        XCTAssertEqual(secondArg.name, "intArray")
        XCTAssertEqual(secondArg.type, "[Int]")

        let thirdArg = result[2]
        XCTAssertEqual(thirdArg.externalName, nil)
        XCTAssertEqual(thirdArg.name, "tuple")
        XCTAssertEqual(thirdArg.type, "(Int?, String, [Int])?")
    }

    func testArgumentsFromArgumentsString_OverlyComplicated() {
        let result = Argument.argumentsFrom(argumentsString: "external tuple: (Int?, String, [Int])?, the completion: @escaping ([Test], ServiceError?) -> (Int?, [Test], (String?, Test?) -> ())")
        
        XCTAssertEqual(result.count, 2)
        
        let firstArg = result[0]
        XCTAssertEqual(firstArg.externalName, "external")
        XCTAssertEqual(firstArg.name, "tuple")
        XCTAssertEqual(firstArg.type, "(Int?, String, [Int])?")
        
        let secondArg = result[1]
        XCTAssertEqual(secondArg.externalName, "the")
        XCTAssertEqual(secondArg.name, "completion")
        XCTAssertEqual(secondArg.type, "@escaping ([Test], ServiceError?) -> (Int?, [Test], (String?, Test?) -> ())")
    }
    
    func testArgumentsFromArgumentsString_Dictionary() {
        let result = Argument.argumentsFrom(argumentsString: "my dictionary: [String: Any], the string :String?")
        
        XCTAssertEqual(result.count, 2)
        
        let firstArg = result[0]
        XCTAssertEqual(firstArg.externalName, "my")
        XCTAssertEqual(firstArg.name, "dictionary")
        XCTAssertEqual(firstArg.type, "[String: Any]")
        
        let secondArg = result[1]
        XCTAssertEqual(secondArg.externalName, "the")
        XCTAssertEqual(secondArg.name, "string")
        XCTAssertEqual(secondArg.type, "String?")
    }
    
    func testArgumentsFromArgumentsString_CompletionWithDictionary() {
        let result = Argument.argumentsFrom(argumentsString: "test int: Int, completion: @escaping ([String: Any], Error?) -> (), the string: String?")
        
        XCTAssertEqual(result.count, 3)
        
        let firstArg = result[0]
        XCTAssertEqual(firstArg.externalName, "test")
        XCTAssertEqual(firstArg.name, "int")
        XCTAssertEqual(firstArg.type, "Int")
        
        let secondArg = result[1]
        XCTAssertEqual(secondArg.externalName, nil)
        XCTAssertEqual(secondArg.name, "completion")
        XCTAssertEqual(secondArg.type, "@escaping ([String: Any], Error?) -> ()")
        
        let thirdArg = result[2]
        XCTAssertEqual(thirdArg.externalName, "the")
        XCTAssertEqual(thirdArg.name, "string")
        XCTAssertEqual(thirdArg.type, "String?")
    }
}
