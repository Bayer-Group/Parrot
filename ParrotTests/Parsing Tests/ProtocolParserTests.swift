
import XCTest

class ProtocolParserTests: XCTestCase {

    func testWhenNoFilesContainSpecifiedProtocolName_ThenNilReturned() {
        let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithoutProtocol], defaultsTable: [:])
        XCTAssertNil(entity)
    }
    
    func testWhenFilesContainSpecifiedProtocol_ThenCorrectEntityReturned() {
        
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithoutProtocol, testFileWithProtocolWithOnlyVariables], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(entity.name, "SomeProtocol")
        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "myVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "myWeakGet", type: "AmazingClass?", defaultReturnValue: "nil", isGetSet: false, isWeak: true),
            Variable(name: "myWeakGetSet", type: "AmazingClass?", defaultReturnValue: "nil", isGetSet: true, isWeak: true)
        ])
    }
    
    func testWhenFilesContainSpecifiedProtocol_WhenClosingCurlyBraceNotIsolated_ThenCorrectEntityReturned() {
        
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithoutProtocol, testFileWithProtocolWithClosingCurlyNotIsolated], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(entity.name, "SomeProtocol")
        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "myVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "myWeakGet", type: "AmazingClass?", defaultReturnValue: "nil", isGetSet: false, isWeak: true),
            Variable(name: "myWeakGetSet", type: "AmazingClass?", defaultReturnValue: "nil", isGetSet: true, isWeak: true)
        ])
    }

    func testWhenFileContainsSpecifiedProtocol_WhenPublic_ThenCorrectEntityReturned() {
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithPublicProtocol], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(entity.name, "SomeProtocol")
        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "myVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "myWeakGet", type: "AmazingClass?", defaultReturnValue: "nil", isGetSet: false, isWeak: true),
            Variable(name: "myWeakGetSet", type: "AmazingClass?", defaultReturnValue: "nil", isGetSet: true, isWeak: true)
        ])
    }
    
    func testProtocolEntity_WhenProtocolComposition_ThenHasDefinitionsFromBothProtocols() {
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocolComposition", in: [testFileWithProtocolComposition], defaultsTable: [:]) else { XCTFail(); return }
     
        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "myVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "composedGet", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "composedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false)
        ])
        
        XCTAssertEqual(Set(entity.functions), [
            Function(name: "woo", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "composedFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil")
        ])
    }
    
    func testProtocolEntity_WhenNestedProtocolComposition_ThenHasDefinitionsFromAllThreeProtocols() {
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocolComposition", in: [testFileWithNestedProtocolComposition], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "myVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "composedGet", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "composedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "nestedGet", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "nestedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false)
        ])
        
        XCTAssertEqual(Set(entity.functions), [
            Function(name: "woo", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "composedFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "nestedFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil")
        ])
    }
    
    func testProtocolEntity_WhenMultipleConformancesAndNesting_ThenHasDefinitionsFromAllProtocols() {
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocolComposition", in: [testFileWithMultipleConformancesAndNesting], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "myVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "composedGet", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "composedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "nestedGet", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "nestedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "anotherComposedGet", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "anotherComposedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false)
        ])
        
        XCTAssertEqual(Set(entity.functions), [
            Function(name: "woo", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "composedFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "nestedFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "anotherComposedFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil")
        ])
    }
    
    func testProtocolEntity_WhenDuplicateProtocolRequirements_ThenDoesNotDuplicateNeededDefinitions() {
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocolComposition", in: [testFileWithDuplicateConformances], defaultsTable: [:]) else { XCTFail(); return }

        XCTAssertEqual(Set(entity.variables), [
            Variable(name: "duplicateVariable", type: "String", defaultReturnValue: "\"\"", isGetSet: false, isWeak: false),
            Variable(name: "myGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false),
            Variable(name: "composedGetSet", type: "Int", defaultReturnValue: "0", isGetSet: true, isWeak: false)
        ])
        
        XCTAssertEqual(Set(entity.functions), [
            Function(name: "duplicateFunction", returnType: "Double?", arguments: [], defaultReturnValue: "nil"),
            Function(name: "myFunc", returnType: "String", arguments: [], defaultReturnValue: "\"\""),
            Function(name: "composedMyFunc", returnType: "String", arguments: [], defaultReturnValue: "\"\"")
        ])
    }
    
    // MARK: - protocolConformances
    func testProtocolConformances_WhenNilFirstLine_EmptyArray() {
        XCTAssertEqual(ProtocolParser.protocolConformances(fromProtocolFirstLine: nil), [])
    }
    
    func testProtocolConformances_WhenNoConformances_EmptyArray() {
        XCTAssertEqual(ProtocolParser.protocolConformances(fromProtocolFirstLine: "protocol Test {"), [])
    }
    
    
    func testProtocolConformances_WhenClassConformance_EmptyArray() {
        XCTAssertEqual(ProtocolParser.protocolConformances(fromProtocolFirstLine: "protocol Test: class {"), [])
    }
    
    func testProtocolConformances_WhenOneConformance_ReturnsConformance() {
        XCTAssertEqual(ProtocolParser.protocolConformances(fromProtocolFirstLine: "protocol Test: TestConformance {"), ["TestConformance"])
    }
    
    func testProtocolConformances_WhenMultipleConformance_ReturnsTrimmedConformances() {
        XCTAssertEqual(ProtocolParser.protocolConformances(fromProtocolFirstLine: "protocol Test: TestConformance, SecondConformance, GoingCrazyNow {"), ["TestConformance", "SecondConformance", "GoingCrazyNow"])
    }
    
    func testProtocolConformances_WhenMultipleConformanceAndClassConformance_ReturnsTrimmedConformancesWithoutClass() {
        XCTAssertEqual(ProtocolParser.protocolConformances(fromProtocolFirstLine: "protocol Test: class, TestConformance, SecondConformance, GoingCrazyNow {"), ["TestConformance", "SecondConformance", "GoingCrazyNow"])
    }
}

extension ProtocolParserTests {
    
    private var testFileWithoutProtocol: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            " class AwesomeModel {",
            "}"
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithProtocolWithOnlyVariables: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "protocol SomeProtocol: class {",
                " var myVariable : String { get }",
                "var myGetSet : Int { get set }",
                "  weak var myWeakGet: AmazingClass? { get }",
                "weak var myWeakGetSet: AmazingClass? { set get }",
                "func woo() -> Double?",
            "}"
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithProtocolWithClosingCurlyNotIsolated: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "protocol SomeProtocol: class {",
            " var myVariable : String { get }",
            "var myGetSet : Int { get set }",
            "  weak var myWeakGet: AmazingClass? { get }",
            "weak var myWeakGetSet: AmazingClass? { set get }",
            "func woo() -> Double?}"
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithPublicProtocol: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "public protocol SomeProtocol: class {",
            " var myVariable : String { get }",
            "var myGetSet : Int { get set }",
            "  weak var myWeakGet: AmazingClass? { get }",
            "weak var myWeakGetSet: AmazingClass? { set get }",
            "func woo() -> Double?",
            "}"
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithProtocolComposition: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "protocol SomeProtocolComposition: class, ComposedProtocol {",
            " var myVariable : String { get }",
            "var myGetSet : Int { get set }",
            "func woo() -> Double?",
            "}",
            "protocol ComposedProtocol: class {",
            " var composedGet : String { get }",
            "var composedGetSet : Int { get set }",
            "func composedFunction() -> Double?",
            "}",
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithNestedProtocolComposition: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "protocol SomeProtocolComposition: class, ComposedProtocol {",
            " var myVariable : String { get }",
            "var myGetSet : Int { get set }",
            "func woo() -> Double?",
            "}",
            "protocol ComposedProtocol: class, NestedComposition {",
            " var composedGet : String { get }",
            "var composedGetSet : Int { get set }",
            "func composedFunction() -> Double?",
            "}",
            "protocol NestedComposition {",
            " var nestedGet : String { get }",
            "var nestedGetSet : Int { get set }",
            "func nestedFunction() -> Double?",
            "}",
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithMultipleConformancesAndNesting: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "protocol SomeProtocolComposition: class, ComposedProtocol, AnotherComposedProtocol {",
            " var myVariable : String { get }",
            "var myGetSet : Int { get set }",
            "func woo() -> Double?",
            "}",
            "protocol AnotherComposedProtocol {",
            " var anotherComposedGet : String { get }",
            "var anotherComposedGetSet : Int { get set }",
            "func anotherComposedFunction() -> Double?",
            "}",
            "protocol ComposedProtocol: class, NestedComposition {",
            " var composedGet : String { get }",
            "var composedGetSet : Int { get set }",
            "func composedFunction() -> Double?",
            "}",
            "protocol NestedComposition {",
            " var nestedGet : String { get }",
            "var nestedGetSet : Int { get set }",
            "func nestedFunction() -> Double?",
            "}",
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithDuplicateConformances: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "protocol SomeProtocolComposition: class, ComposedProtocol {",
            " var duplicateVariable : String { get }",
            "var myGetSet : Int { get set }",
            "func duplicateFunction() -> Double?",
            "func myFunc() -> String",
            "}",
            "protocol ComposedProtocol: class {",
            " var duplicateVariable : String { get }",
            "var composedGetSet : Int { get set }",
            "func duplicateFunction() -> Double?",
            "func composedMyFunc() -> String",
            "}",
        ]
        return File(url: url, lines: lines)
    }
    // TODO: Defaults Table tests?
}
