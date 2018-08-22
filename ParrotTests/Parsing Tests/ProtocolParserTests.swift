
import XCTest

class ProtocolParserTests: XCTestCase {

    func testWhenNoFilesContainSpecifiedProtocolName_ThenNilReturned() {
        let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithoutProtocol], defaultsTable: [:])
        XCTAssertNil(entity)
    }
    
    func testWhenFilesContainSpecifiedProtocol_ThenCorrectEntityReturned() {
        
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithoutProtocol, testFileWithProtocolWithOnlyVariables], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(entity.name, "SomeProtocol")
        if entity.variables.count != 4 { XCTFail(); return }
        
        XCTAssertEqual(entity.variables[0].name, "myVariable")
        XCTAssertEqual(entity.variables[0].type, "String")
        XCTAssertEqual(entity.variables[0].isGetSet, false)
        XCTAssertEqual(entity.variables[0].isWeak, false)
        
        XCTAssertEqual(entity.variables[1].name, "myGetSet")
        XCTAssertEqual(entity.variables[1].type, "Int")
        XCTAssertEqual(entity.variables[1].isGetSet, true)
        XCTAssertEqual(entity.variables[1].isWeak, false)
        
        XCTAssertEqual(entity.variables[2].name, "myWeakGet")
        XCTAssertEqual(entity.variables[2].type, "AmazingClass?")
        XCTAssertEqual(entity.variables[2].isGetSet, false)
        XCTAssertEqual(entity.variables[2].isWeak, true)
        
        XCTAssertEqual(entity.variables[3].name, "myWeakGetSet")
        XCTAssertEqual(entity.variables[3].type, "AmazingClass?")
        XCTAssertEqual(entity.variables[3].isGetSet, true)
        XCTAssertEqual(entity.variables[3].isWeak, true)
    }
    
    func testWhenFilesContainSpecifiedProtocol_ThenCorrectEntityReturned2() {
        
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithoutProtocol, testFileWithProtocolWithClosingCurlyNotIsolated], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(entity.name, "SomeProtocol")
        if entity.variables.count != 4 { XCTFail(); return }
        
        XCTAssertEqual(entity.variables[0].name, "myVariable")
        XCTAssertEqual(entity.variables[0].type, "String")
        XCTAssertEqual(entity.variables[0].isGetSet, false)
        XCTAssertEqual(entity.variables[0].isWeak, false)
        
        XCTAssertEqual(entity.variables[1].name, "myGetSet")
        XCTAssertEqual(entity.variables[1].type, "Int")
        XCTAssertEqual(entity.variables[1].isGetSet, true)
        XCTAssertEqual(entity.variables[1].isWeak, false)
        
        XCTAssertEqual(entity.variables[2].name, "myWeakGet")
        XCTAssertEqual(entity.variables[2].type, "AmazingClass?")
        XCTAssertEqual(entity.variables[2].isGetSet, false)
        XCTAssertEqual(entity.variables[2].isWeak, true)
        
        XCTAssertEqual(entity.variables[3].name, "myWeakGetSet")
        XCTAssertEqual(entity.variables[3].type, "AmazingClass?")
        XCTAssertEqual(entity.variables[3].isGetSet, true)
        XCTAssertEqual(entity.variables[3].isWeak, true)
    }

    func testWhenFileContainsSpecifiedProtocol_WhenPublic_ThenCorrectEntityReturned() {
        guard let entity = ProtocolParser.protocolEntity(with: "SomeProtocol", in: [testFileWithPublicProtocol], defaultsTable: [:]) else { XCTFail(); return }
        
        XCTAssertEqual(entity.name, "SomeProtocol")
        if entity.variables.count != 4 { XCTFail(); return }
        
        XCTAssertEqual(entity.variables[0].name, "myVariable")
        XCTAssertEqual(entity.variables[0].type, "String")
        XCTAssertEqual(entity.variables[0].isGetSet, false)
        XCTAssertEqual(entity.variables[0].isWeak, false)
        
        XCTAssertEqual(entity.variables[1].name, "myGetSet")
        XCTAssertEqual(entity.variables[1].type, "Int")
        XCTAssertEqual(entity.variables[1].isGetSet, true)
        XCTAssertEqual(entity.variables[1].isWeak, false)
        
        XCTAssertEqual(entity.variables[2].name, "myWeakGet")
        XCTAssertEqual(entity.variables[2].type, "AmazingClass?")
        XCTAssertEqual(entity.variables[2].isGetSet, false)
        XCTAssertEqual(entity.variables[2].isWeak, true)
        
        XCTAssertEqual(entity.variables[3].name, "myWeakGetSet")
        XCTAssertEqual(entity.variables[3].type, "AmazingClass?")
        XCTAssertEqual(entity.variables[3].isGetSet, true)
        XCTAssertEqual(entity.variables[3].isWeak, true)
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
    // TODO: Defaults Table tests?
}
