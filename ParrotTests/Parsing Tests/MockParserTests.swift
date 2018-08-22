import XCTest
import Foundation

class MockParserTests: XCTestCase {

    func test_whenFilesDoNotContainAnyMockableToken_thenNoMockEntitiesReturned() {
        let mockEntities = MockParser.mockEntities(in: [testFileWithoutMockToken])
        XCTAssertEqual(mockEntities.count, 0)
    }
    
    func test_whenFilesContainOneMockableToken_thenOneMockEntityReturnedWithCorrectValues() {
        let mockEntities = MockParser.mockEntities(in: [testFileWithoutMockToken, testFileBasic1])
        XCTAssertEqual(mockEntities.count, 1)
        guard let entity = mockEntities.first else { XCTFail(); return }
        XCTAssertEqual(entity.type, "class")
        XCTAssertEqual(entity.name, "MockAwesomeModel")
        XCTAssertEqual(entity.protocolName, "AwesomeModelProtocol")
        XCTAssertEqual(entity.headers.count, 0)
    }
    
    func test_whenMockContainsNoSpacesAroundColonAndFinalModifier_thenEntityStillParsedCorrectly() {
        let mockEntities = MockParser.mockEntities(in: [testFileBasic2])
        XCTAssertEqual(mockEntities.count, 1)
        guard let entity = mockEntities.first else { XCTFail(); return }
        XCTAssertEqual(entity.type, "final class")
        XCTAssertEqual(entity.name, "MockAwesomeModel")
        XCTAssertEqual(entity.protocolName, "AwesomeModelProtocol")
        XCTAssertEqual(entity.headers.count, 0)
    }
    
    func test_whenMockContainsHeaders_thenHeadersArePresentInEntity() {
        let mockEntities = MockParser.mockEntities(in: [testFileWithHeaders])
        XCTAssertEqual(mockEntities.count, 1)
        guard let entity = mockEntities.first else { XCTFail(); return }
        XCTAssertEqual(entity.type, "class")
        XCTAssertEqual(entity.name, "MockAwesomeModel")
        XCTAssertEqual(entity.protocolName, "AwesomeModelProtocol")
        
        let expectedHeaders = [
            "",
            "import Foundation",
            "import XCTest",
            "@testable import MyModule",
            ""
        ]
        
        XCTAssertEqual(entity.headers, expectedHeaders)
    }
    
    func test_whenFilesContainTwoMockableTokens_thenOneMockEntityReturnedWithCorrectValues() {
        let mockEntities = MockParser.mockEntities(in: [testFileWithTwoMocksAndAlsoHeaders])
        XCTAssertEqual(mockEntities.count, 1)
        guard let entity = mockEntities.first else { XCTFail(); return }
        XCTAssertEqual(entity.type, "class")
        XCTAssertEqual(entity.name, "MockAwesomeModel")
        XCTAssertEqual(entity.protocolName, "AwesomeModelProtocol")
        
        let expectedHeaders = [
            "",
            "import Foundation",
            "import XCTest",
            "@testable import MyModule",
            ""
        ]
        
        XCTAssertEqual(entity.headers, expectedHeaders)
    }
    
}

extension MockParserTests {
    
    private var testFileWithoutMockToken: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            " class MockAwesomeModel: AwesomeModelProtocol {",
            "}"        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileBasic1: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "// @@parrot-mock",
            "  class MockAwesomeModel :  AwesomeModelProtocol { ",
            "",
            "}",
            ""
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileBasic2: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "// @@parrot-mock",
            "final class MockAwesomeModel:AwesomeModelProtocol",
            "{",
            "}",
            ""
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithHeaders: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "",
            "import Foundation",
            "import XCTest",
            "@testable import MyModule",
            "",
            "// @@parrot-mock",
            "class MockAwesomeModel: AwesomeModelProtocol",
            "{",
            "}",
            ""
        ]
        return File(url: url, lines: lines)
    }
    
    private var testFileWithTwoMocksAndAlsoHeaders: File {
        let url = URL(string: FileManager.default.currentDirectoryPath)!
        let lines = [
            "",
            "import Foundation",
            "import XCTest",
            "@testable import MyModule",
            "",
            "// @@parrot-mock",
            "class MockAwesomeModel: AwesomeModelProtocol",
            "{",
            "}",
            "",
            "// @@parrot-mock",
            "class MockBestModel: YuuuugeModelProtocol",
            "{",
            "}",
            ""
        ]
        return File(url: url, lines: lines)
    }
    
}

