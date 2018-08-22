import XCTest

class StringExtensionTests: XCTestCase {
    // MARK: - indices tests
    func test_whenSimpleSubStringCase_ThenCorrectSubstringIndicesReturn(){
        let testString = "{swifty}"
        let startIndex = String.Index(encodedOffset: 0)
        let endIndex = String.Index(encodedOffset: testString.count - 1)
        
        let expected = (startIndex, endIndex)
        guard let result = testString.substringScopeIndexes(enclosingCharacter: .curlyBrackets) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(result == expected)
    }
    
    func test_whenFailingSubstringCase_ThenReturnsNil(){
        let testString = "}swifty{"

        XCTAssertNil(testString.substringScopeIndexes(enclosingCharacter: .curlyBrackets))
    }
    
    // MARK: - substring tests
    func test_WhenSimpleStringWithCurlyBraces_ThenCorrectSubstringReturn(){
        let testString = "{swifty}"
        XCTAssertEqual(testString.substringScopeString(enclosingCharacter: .curlyBrackets), "swifty")
    }
    
    func test_WhenStartCharacterIsNotTheFirstCharacter_ThenCorrectSubstringReturn(){
        let testString = "anythingbut{swifty}"
        XCTAssertEqual(testString.substringScopeString(enclosingCharacter: .curlyBrackets), "swifty")
    }
    
    func test_WhenNothingInCurlyBraces_ThenEmptySubstringReturn(){
        let testString = "{}"
        XCTAssertEqual(testString.substringScopeString(enclosingCharacter: .curlyBrackets), "")
    }
    
    func test_WhenStringEndsWithStartCharacter_ThenReturnsNil(){
        let testString = "anythingbut{"
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .curlyBrackets))
    }
    
    func test_WhenOnlyHasAClosingCharacter_ThenReturnsNil(){
        let testString = "{"
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .curlyBrackets))
    }
    
    func test_WhenStringStartsWithEndCharacterAndEndsWithStartCharacter_ThenReturnsNil(){
        let testString = "}anythingbut{"
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .curlyBrackets))
    }
    
    func test_WhenStringHasNothingBetweenCurlyBraces_ThenReturnsNil(){
        let testString = "}{"
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .curlyBrackets))
    }
    
    
    func test_WhenStringHasNothing_ThenReturnsNil(){
        let testString = ""
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .curlyBrackets))
    }
    
    func test_WhenStringHasWhitespaceAndNewLines_ThenReturnsSubstring(){
        let testString = "     anythingbut{sw\nifty}    "
        XCTAssertEqual(testString.substringScopeString(enclosingCharacter: .curlyBrackets), "sw\nifty")
    }
    
    //    MARK: - nested tests
    func test_WhenFunctionHasCompletionBlock_ThenReturnsParameters(){
        let testString = "func myFunction(name: String, completion: ()-> ())"
        XCTAssertEqual(testString.substringScopeString(enclosingCharacter: .parenthesis), "name: String, completion: ()-> ()")
    }
    
    func test_WhenFunctionHasCompletionBlockAndClosureReturnValue_ThenReturnsParameters(){
        let testString = "func myFunction(name: String, completion: ()-> ()) -> () -> ()"
        XCTAssertEqual(testString.substringScopeString(enclosingCharacter: .parenthesis), "name: String, completion: ()-> ()")
    }
    
    func test_WhenFunctionHasNestedOpeningAndNoClosing_ThenReturnsNil(){
        let testString = "func myFunction(name: String, completion: (((("
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .parenthesis))
    }
    
    func test_WhenFunctionIsMissingCorrectClosing_ThenReturnsNil(){
        let testString = "func myFunction(name: String, completion: ()-> () -> () -> ()"
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .parenthesis))
    }
    
    func test_WhenStringHasCloseOpenClose_InvalidInput() {
        let testString = ") -> ()"
        
        XCTAssertNil(testString.substringScopeString(enclosingCharacter: .parenthesis))
    }
    
    // TODO: Individual tests for the components separated by, ignoring enclosing character  
}
