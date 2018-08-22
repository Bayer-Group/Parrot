import XCTest

class FunctionParserTests: XCTestCase {

    // MARK: Functions with no arguments and void return values
    
    func testBasicEmptyFunctionParsedCorrectly() {
        let declaration = " func  basicFunc ( )  "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }

        XCTAssertEqual(result.name, "basicFunc")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    func testBasicEmptyFunctionWithVoidParsedCorrectly() {
        let declaration = "func basicFunc2()->Void "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc2")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    func testBasicEmptyFunctionWithSpacesAndWithVoidParsedCorrectly() {
        let declaration = " func   basicFunc2   ( )  ->  Void  "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc2")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 0)
    }

    func testBasicEmptyFunctionWithSwiftVoidParsedCorrectly() {
        let declaration = " func  basicFunc3() -> Swift.Void   "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }

        XCTAssertEqual(result.name, "basicFunc3")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 0)
    }

    func testBasicEmptyFunctionWithEmptyClosureParsedCorrectly() {
        let declaration = " func  basicFunc4() -> () "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }

        XCTAssertEqual(result.name, "basicFunc4")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    // MARK: Functions with simple argument labels
    
    func testFunctionWithOneArgumentParsedCorrectlyCorrectly() {
        let declaration = " func  basicFunc(name:String)  "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 1)
        
        guard let arg1 = result.arguments.first else { XCTFail(); return }
        XCTAssertEqual(arg1.name, "name")
        XCTAssertEqual(arg1.type, "String")
        XCTAssertEqual(arg1.externalName, nil)
    }
    
    func testFunctionWithOneArgumentAndSpacesParsedCorrectlyCorrectly() {
        let declaration = " func  basicFunc ( age : Int )  "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 1)
        
        guard let arg1 = result.arguments.first else { XCTFail(); return }
        XCTAssertEqual(arg1.name, "age")
        XCTAssertEqual(arg1.type, "Int")
        XCTAssertEqual(arg1.externalName, nil)
    }
    
    func testFunctionWithThreeArgumentsAndSpacesParsedCorrectlyCorrectly() {
        let declaration = " func  basicFunc ( age : Int, name: String  , job  : String? )  "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 3)
        
        guard let arg1 = result.arguments.first,
            let arg2 = result.arguments.element(at: 1),
            let arg3 = result.arguments.element(at: 2)
        else { XCTFail(); return }
        
        XCTAssertEqual(arg1.name, "age")
        XCTAssertEqual(arg1.type, "Int")
        XCTAssertEqual(arg1.externalName, nil)
        
        XCTAssertEqual(arg2.name, "name")
        XCTAssertEqual(arg2.type, "String")
        XCTAssertEqual(arg2.externalName, nil)
        
        XCTAssertEqual(arg3.name, "job")
        XCTAssertEqual(arg3.type, "String?")
        XCTAssertEqual(arg3.externalName, nil)
    }
    
    // MARK: Functions with simple return values
    
    func testBasicEmptyFunctionWithSimpleReturnTypeParsedCorrectly() {
        let declaration = " func  basicFunc4() -> Bool "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc4")
        XCTAssertEqual(result.returnType, "Bool")
        XCTAssertEqual(result.defaultReturnValue, "false")
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    func testBasicEmptyFunctionWithSimpleOptionalReturnTypeParsedCorrectly() {
        let declaration = "func basicFunc4()->Int?"
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc4")
        XCTAssertEqual(result.returnType, "Int?")
        XCTAssertEqual(result.defaultReturnValue, "nil")
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    func testFunctionWithTwoArgumentsAndSimpleReturnValueCorrectlyCorrectly() {
        let declaration = " func  basicFunc ( address : String , distance: Double? ) -> Double "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc")
        XCTAssertEqual(result.returnType, "Double")
        XCTAssertEqual(result.defaultReturnValue, "0.0")
        XCTAssertEqual(result.arguments.count, 2)
        
        guard let arg1 = result.arguments.first,
            let arg2 = result.arguments.element(at: 1)
        else { XCTFail(); return }
        
        XCTAssertEqual(arg1.name, "address")
        XCTAssertEqual(arg1.type, "String")
        XCTAssertEqual(arg1.externalName, nil)
        
        XCTAssertEqual(arg2.name, "distance")
        XCTAssertEqual(arg2.type, "Double?")
        XCTAssertEqual(arg2.externalName, nil)
    }
    
    func testFunctionWithArgumentWithExternalNameParsedCorrectly() {
        let declaration = " func basicFuncWith(external name: String)"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.arguments.first?.name, "name")
        XCTAssertEqual(result.arguments.first?.externalName, "external")
        XCTAssertEqual(result.arguments.first?.type, "String")
    }
    
    func testFunctionWithMultipleArguementsWithExternalNamesParsedCorrectly() {
        let declaration = " func basicFuncWith( external name: String,external two :Int)"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.arguments.first?.name, "name")
        XCTAssertEqual(result.arguments.first?.externalName, "external")
        XCTAssertEqual(result.arguments.first?.type, "String")
        XCTAssertEqual(result.arguments[1].name, "two")
        XCTAssertEqual(result.arguments[1].externalName, "external")
        XCTAssertEqual(result.arguments[1].type, "Int")
    }
    
    // MARK: Functions with collection arguments and return values
    
    // TODO: Write tests to verify that Arrays, Dictionaries, and Sets can all be passed in as arguments,
    // and returned as well. Check for Optional of each too.
    
    func testFunctionWithArrayAsArgumentParsedCorrectly() {
        let declaration = " func  basicFunc4() -> Bool "
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "basicFunc4")
        XCTAssertEqual(result.returnType, "Bool")
        XCTAssertEqual(result.defaultReturnValue, "false")
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    // MARK: - completion as argument
    func testFunctionWithCompletionAsArgumentParsedCorrectly() {
        let declaration = "func completionFunc(completion: @escaping () -> ())"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "completionFunc")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.defaultReturnValue, nil)
        XCTAssertEqual(result.arguments.count, 1)
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "completion")
        XCTAssertEqual(result.arguments[0].type, "@escaping () -> ()")
    }
    
    func testFunctionWithFunctionAsArgumentParameterInCompletionParsedCorrectly() {
        let declaration = "func testFuncAsArg(completion: @escaping ([String]) -> ())"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncAsArg")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.arguments.count, 1)
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "completion")
        XCTAssertEqual(result.arguments[0].type, "@escaping ([String]) -> ()")
    }
    
    func testFunctionWithFunctionAsArgumentMultipleParametersParsedCorrectly() {
        let declaration = "func testFuncAsArg(completion: @escaping (String?, String?) -> ())"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncAsArg")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.arguments.count, 1)
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "completion")
        XCTAssertEqual(result.arguments[0].type, "@escaping (String?, String?) -> ()")
    }
    
    func testFunctionWithFunctionArgumentAndReturnTypeParsedCorrectly() {
        let declaration = "func testFuncAsArg(completion: @escaping (String?,String?) -> ()) -> Bool"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncAsArg")
        XCTAssertEqual(result.returnType, "Bool")
        XCTAssertEqual(result.arguments.count, 1)
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "completion")
        XCTAssertEqual(result.arguments[0].type, "@escaping (String?,String?) -> ()")
    }
    
    func testFunctionWithFunctionAsArgumentMultipleParameters_AndOtherArgs_ParsedCorrectly() {
        let declaration = "func testFuncAsArg(token: String, completion: @escaping (String?,String?) -> ())"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncAsArg")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.arguments.count, 2)
        
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "token")
        XCTAssertEqual(result.arguments[0].type, "String")
        
        XCTAssertEqual(result.arguments[1].externalName, nil)
        XCTAssertEqual(result.arguments[1].name, "completion")
        XCTAssertEqual(result.arguments[1].type, "@escaping (String?,String?) -> ()")
    }
    
    // MARK: - Tuples
    // TODO: let declaration = "func testTupleAsArg(parameters: (myString: String, myBool: Bool, optionalInt: Int?))"
    
    func testFunctionWithTupleParameter_ParsedCorrectly() {
        let declaration = "func testTupleAsArg(parameters: (String, Bool, Int?))"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testTupleAsArg")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.arguments.count, 1)
        
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "parameters")
        XCTAssertEqual(result.arguments[0].type, "(String, Bool, Int?)")
    }
    
    func testFunctionWithFunctionAsArgumentMultipleParameters_AndATupleArg_ParsedCorrectly() {
        let declaration = "func testFuncAsArg(parameters: (String, Bool, Int?), completion: @escaping (String?,String?) -> ()) -> Int"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncAsArg")
        XCTAssertEqual(result.returnType, "Int")
        XCTAssertEqual(result.arguments.count, 2)
        
        XCTAssertEqual(result.arguments[0].externalName, nil)
        XCTAssertEqual(result.arguments[0].name, "parameters")
        XCTAssertEqual(result.arguments[0].type, "(String, Bool, Int?)")
        
        XCTAssertEqual(result.arguments[1].externalName, nil)
        XCTAssertEqual(result.arguments[1].name, "completion")
        XCTAssertEqual(result.arguments[1].type, "@escaping (String?,String?) -> ()")
    }
    
    // MARK: - Dictionaries
    func testFunctionFrom_DictionaryParameterParsedCorrectly() {
        let declaration = "func testFuncDictionary(dictionary: [String: Any])"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncDictionary")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.arguments.count, 1)
        
        XCTAssertEqual(result.arguments.first?.externalName, nil)
        XCTAssertEqual(result.arguments.first?.name, "dictionary")
        XCTAssertEqual(result.arguments.first?.type, "[String: Any]")
    }
    
    func testFunctionFrom_DictionaryAndOtherParametersParsedCorrectly() {
        let declaration = "func testFuncDictAndOthers(my string: String, dictionary: [String: [String]], other things: [Int])"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFuncDictAndOthers")
        XCTAssertEqual(result.returnType, nil)
        XCTAssertEqual(result.arguments.count, 3)
        
        let firstArg = result.arguments[0]
        let secondArg = result.arguments[1]
        let thirdArg = result.arguments[2]
        
        XCTAssertEqual(firstArg.externalName, "my")
        XCTAssertEqual(firstArg.name, "string")
        XCTAssertEqual(firstArg.type, "String")
        
        XCTAssertEqual(secondArg.externalName, nil)
        XCTAssertEqual(secondArg.name, "dictionary")
        XCTAssertEqual(secondArg.type, "[String: [String]]")
        
        XCTAssertEqual(thirdArg.externalName, "other")
        XCTAssertEqual(thirdArg.name, "things")
        XCTAssertEqual(thirdArg.type, "[Int]")
    }
    
    func testFunctionFrom_DictionaryReturnParsedCorrectly() {
        let declaration = "func testFuncDictionary() -> [String: Any]"

        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }

        XCTAssertEqual(result.name, "testFuncDictionary")
        XCTAssertEqual(result.returnType, "[String: Any]")
        XCTAssertEqual(result.defaultReturnValue, "[:]")
        XCTAssertEqual(result.arguments.count, 0)
    }
    
    func testFunctionFrom_DictionaryParameterAndReturnType() {
        let declaration = "func testFunc(dictionary: [String: Int], completion: @escaping (Result?, ServiceError?) -> ()) -> [Int: Int]"
        
        guard let result = Function.from(declaration: declaration, defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(result.name, "testFunc")
        XCTAssertEqual(result.defaultReturnValue, "[:]")
        XCTAssertEqual(result.returnType, "[Int: Int]")
        XCTAssertEqual(result.arguments.count, 2)
        
        let firstArg = result.arguments[0]
        let secondArg = result.arguments[1]
        
        XCTAssertEqual(firstArg.externalName, nil)
        XCTAssertEqual(firstArg.name, "dictionary")
        XCTAssertEqual(firstArg.type, "[String: Int]")
        
        XCTAssertEqual(secondArg.externalName, nil)
        XCTAssertEqual(secondArg.name, "completion")
        XCTAssertEqual(secondArg.type, "@escaping (Result?, ServiceError?) -> ()")
        
    }
    
    // MARK: - Defaults table
    // TODO: this is the basic use case, could likely be more robust
    
    func testWhenCustomTypePresentedWithMatchingDefaultsTableEntry_ThenTableEntryIsUsed() {
        let declaration = "func customReturn() -> CustomType"
        let mockDefaultsTable = ["CustomType": "CustomType(string: \"Custom\")"]
        
        guard let result = Function.from(declaration: declaration, defaultsTable: mockDefaultsTable) else { XCTFail(); return }
        
        XCTAssertEqual(result.defaultReturnValue, mockDefaultsTable["CustomType"])
    }
    
    
    func testWhenKnownTypeHasMatchingDefaultsTableEntry_ThenTableEntryIsUsed() {
        let declaration = "func customReturn() -> String?"
        let mockDefaultsTable = ["String?": "String(\"c\")"]
        
        guard let result = Function.from(declaration: declaration, defaultsTable: mockDefaultsTable) else { XCTFail(); return }
        
        XCTAssertEqual(result.defaultReturnValue, mockDefaultsTable["String?"])
    }
}
