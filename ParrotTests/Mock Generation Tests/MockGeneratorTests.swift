
import XCTest

class MockGeneratorTests: XCTestCase {

    // TODO: Add tests for MockGenerator
    
    // MARK: - formattedGetSetVariable
    func testFormattedGetSetVariable_FirstAndLastLine1Tab_GetSetDefinition2Tabs_Implementation3Tabs() {
        let expectedVariableName = "myGetSet"
        let expectedVariableType = "String"
        let mockImplementationLines = [
            "var \(expectedVariableName): \(expectedVariableType) {",
            "get {",
            "stub.\(expectedVariableName)CallCount += 1",
            "return stub.\(expectedVariableName)ShouldReturn",
            "}",
            "set {",
            "stub.\(expectedVariableName)ShouldReturn = newValue",
            "}",
            "}"
        ]
        
        let expectedFormat =
        """
        \tvar \(expectedVariableName): \(expectedVariableType) {
        \t\tget {
        \t\t\tstub.\(expectedVariableName)CallCount += 1
        \t\t\treturn stub.\(expectedVariableName)ShouldReturn
        \t\t}
        \t\tset {
        \t\t\tstub.\(expectedVariableName)ShouldReturn = newValue
        \t\t}
        \t}
        """
        
        XCTAssertEqual(MockGenerator.formattedGetSetVariable(mockImplementationLines: mockImplementationLines), expectedFormat)
    }
}
