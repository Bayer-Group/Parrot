import XCTest

class MapForDuplicateFunctionNamesTests: XCTestCase {
    // the current implementation passes this test because it overwrites some of the same functions multiple times
    // TODO: nested known types for return types

    func testNoDuplicateNames_NoChanges() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "Thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "Thing2")]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test2", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let result = testFunctions.mapForDuplicateNames()
        
        XCTAssertEqual(testFunctions, result)
    }
    
    func testTwoDuplicateNames_DifferentFirstExternalVariableName_AppendsExternalNamesToFunctionNames() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "Thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "Thing2")]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.externalName! }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_DifferentFirstExternalVariableName_CamelCasesNewName() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing2")]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.externalName!.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_NoExternalVariableName_AppendsFirstArgumentNameToFunctionNames() {
        let firstFunctionArguments = [Argument(name: "Thing1", type: "String", externalName: nil)]
        let secondFunctionArguments = [Argument(name: "Thing2", type: "String", externalName: nil)]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.name }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_NoExternalVariableName_CamelCasesNewName() {
        let firstFunctionArguments = [Argument(name: "thing1", type: "String", externalName: nil)]
        let secondFunctionArguments = [Argument(name: "thing2", type: "String", externalName: nil)]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.name.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoSetsOfTwoDuplicateNames_EachHavingExternalVariableNames_RenamesBothSets() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing2")]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil), Function(name: "test2", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test2", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.externalName!.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OneHavingAnExternalVariableName_RenamesUsingMixedExternalAndInternalVariableNames() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: nil)]
        let testFunctions = [Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil), Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFirstFunctionName = testFunctions[0].name + testFunctions[0].arguments.first!.externalName!.stringCapitalizingFirstLetter()
        let expectedSecondFunctionName = testFunctions[1].name + testFunctions[1].arguments.first!.name.stringCapitalizingFirstLetter()
        XCTAssertEqual(resultingNames, [expectedFirstFunctionName, expectedSecondFunctionName])
    }
    
    func testThreeDuplicateNames_EachHavingAnExternalVariableName_RenamesAllThree() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing2")]
        let thirdFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing3")]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: thirdFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.externalName!.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoSetsOfThreeDuplicateNamesMixed_EachHavingAnExternalVariableName_RenamesAllSixFunctionsWithExternalNames() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing2")]
        let thirdFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing3")]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: thirdFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: thirdFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.externalName!.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testThreeDuplicateNames_EachHavingNoExternalVariableName_RenamesAllThree() {
        let firstFunctionArguments = [Argument(name: "thing1", type: "String", externalName: nil)]
        let secondFunctionArguments = [Argument(name: "thing2", type: "String", externalName: nil)]
        let thirdFunctionArguments = [Argument(name: "thing3", type: "String", externalName: nil)]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: thirdFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.name.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoSetsOfThreeDuplicateNamesMixed_EachHavingNoExternalVariableName_RenamesAllSixFunctionsWithExternalNames() {
        let firstFunctionArguments = [Argument(name: "thing1", type: "String", externalName: nil)]
        let secondFunctionArguments = [Argument(name: "thing2", type: "String", externalName: nil)]
        let thirdFunctionArguments = [Argument(name: "thing3", type: "String", externalName: nil)]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: thirdFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: thirdFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map { $0.name + $0.arguments.first!.name.stringCapitalizingFirstLetter() }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_MatchingFirstExternalVariableName_HasDifferentSecondExternalVariableName_RenamesUsingFirstAndSecondExternalVariableName_CamelCased() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "matching"), Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "matching"), Argument(name: "thing", type: "String", externalName: "thing2")]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map {
            $0.name
            + $0.arguments[0].externalName!.stringCapitalizingFirstLetter()
            + $0.arguments[1].externalName!.stringCapitalizingFirstLetter()
        }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_MatchingFirstVariableName_HasDifferentSecondVariableName_RenamesUsingFirstAndSecondVariableNames_CamelCased() {
        let firstFunctionArguments = [Argument(name: "matching", type: "String", externalName: nil), Argument(name: "thing1", type: "String", externalName: nil)]
        let secondFunctionArguments = [Argument(name: "matching", type: "String", externalName: nil), Argument(name: "thing2", type: "String", externalName: nil)]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map {
            $0.name
                + $0.arguments[0].name.stringCapitalizingFirstLetter()
                + $0.arguments[1].name.stringCapitalizingFirstLetter()
        }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_MatchingMoreThanOneParameterName_EventuallyHasDifferentVariableName_RenamesUntilUnique_CamelCased() {
        let firstFunctionArguments = [
            Argument(name: "matching", type: "String", externalName: nil),
            Argument(name: "matchingAgain", type: "String", externalName: nil),
            Argument(name: "matchingAgain", type: "String", externalName: nil),
            Argument(name: "matchingAgain", type: "String", externalName: nil),
            Argument(name: "thing1", type: "String", externalName: nil)
        ]
        
        let secondFunctionArguments = [
            Argument(name: "matching", type: "String", externalName: nil),
            Argument(name: "matchingAgain", type: "String", externalName: nil),
            Argument(name: "matchingAgain", type: "String", externalName: nil),
            Argument(name: "matchingAgain", type: "String", externalName: nil),
            Argument(name: "thing2", type: "String", externalName: nil)]
        
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map {
            $0.name
                + $0.arguments[0].name.stringCapitalizingFirstLetter()
                + $0.arguments[1].name.stringCapitalizingFirstLetter()
                + $0.arguments[2].name.stringCapitalizingFirstLetter()
                + $0.arguments[3].name.stringCapitalizingFirstLetter()
                + $0.arguments[4].name.stringCapitalizingFirstLetter()
        }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoSetsOfDuplicateNames_WhereMoreThanOneVariableNameNeedsToBeAppended() {
        let firstFunctionArguments = [Argument(name: "matching", type: "String", externalName: nil), Argument(name: "thing1", type: "String", externalName: nil)]
        let secondFunctionArguments = [Argument(name: "matching", type: "String", externalName: nil), Argument(name: "thing2", type: "String", externalName: nil)]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test2", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = testFunctions.map {
            $0.name
                + $0.arguments[0].name.stringCapitalizingFirstLetter()
                + $0.arguments[1].name.stringCapitalizingFirstLetter()
        }
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OneOtherFunction_DoesNotModifyTheNonMatching() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing2")]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "otherFunction", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + testFunctions[0].arguments.first!.externalName!.stringCapitalizingFirstLetter(),
            testFunctions[1].name,
            testFunctions[2].name + testFunctions[2].arguments.first!.externalName!.stringCapitalizingFirstLetter()
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyOneHasAnArgumentWithExternalName_JustRenamesTheOneAbleToHaveAVariableNameAppended() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "thing1")]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: [], defaultReturnValue: nil),
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + testFunctions[0].arguments.first!.externalName!.stringCapitalizingFirstLetter(),
            testFunctions[1].name
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyOneHasAnArgumentWithoutExternalName_JustRenamesTheOneAbleToHaveAVariableNameAppended() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: nil)]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: [], defaultReturnValue: nil),
            ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + testFunctions[0].arguments.first!.name.stringCapitalizingFirstLetter(),
            testFunctions[1].name
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_FirstParameterNameTheSame_OnlyOneHasASecondParameter_JustRenamesTheOneAbleToHaveAVariableNameAppended() {
        let firstFunctionArguments = [Argument(name: "thing", type: "String", externalName: "matching"), Argument(name: "thing", type: "String", externalName: "thing1")]
        let secondFunctionArguments = [Argument(name: "thing", type: "String", externalName: "matching")]
        let testFunctions = [
            Function(name: "test", returnType: nil, arguments: firstFunctionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: secondFunctionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + testFunctions[0].arguments[0].externalName!.stringCapitalizingFirstLetter() + testFunctions[0].arguments[1].externalName!.stringCapitalizingFirstLetter(),
            testFunctions[1].name + testFunctions[1].arguments.first!.externalName!.stringCapitalizingFirstLetter()
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyDifferByTheirReturnTypes_SimpleTypes_AppendsReturnTypeNameToFunctionName() {
        let testFunctions = [
            Function(name: "test", returnType: "String", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: "Int", arguments: [], defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + "ReturnsString",
            testFunctions[1].name + "ReturnsInt"
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_WithSameParameterNames_OnlyDifferByTheirReturnTypes_PrimativeAndNonPrimativeType_AppendsReturnTypeNameToFunctionName() {
        let functionArguments = [Argument(name: "matching", type: "String", externalName: nil)]
        let testFunctions = [
            Function(name: "test", returnType: "Data", arguments: functionArguments, defaultReturnValue: nil),
            Function(name: "test", returnType: "Double", arguments: functionArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + testFunctions[0].arguments[0].name.stringCapitalizingFirstLetter() + "ReturnsData",
            testFunctions[1].name + testFunctions[1].arguments[0].name.stringCapitalizingFirstLetter() + "ReturnsDouble"
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyDifferByTheirReturnTypes_OptionalTypes_AppendsReturnTypeNameToFunctionName() {
        let testFunctions = [
            Function(name: "test", returnType: "String?", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: "Int?", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: "String", arguments: [], defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + "ReturnsOptionalString",
            testFunctions[1].name + "ReturnsOptionalInt",
            testFunctions[2].name + "ReturnsString"
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyDifferByTheirReturnTypes_ArrayTypes_AppendsReturnTypeNameToFunctionName() {
        let testFunctions = [
            Function(name: "test", returnType: "[String]", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: "[Int]", arguments: [], defaultReturnValue: nil),
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + "ReturnsArrayOfStrings",
            testFunctions[1].name + "ReturnsArrayOfInts",
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyDifferByTheirReturnTypes_DictionaryTypes_AppendsReturnTypeNameToFunctionName() {
        let testFunctions = [
            Function(name: "test", returnType: "[String : Any]", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: "[UUID:Data]", arguments: [], defaultReturnValue: nil),
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + "ReturnsDictionaryOfStringToAny",
            testFunctions[1].name + "ReturnsDictionaryOfUUIDToData",
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyDifferByTheirReturnTypes_SetTypes_AppendsReturnTypeNameToFunctionName() {
        let testFunctions = [
            Function(name: "test", returnType: "Set<Feature>", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: "Set<String>", arguments: [], defaultReturnValue: nil),
            ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + "ReturnsSetOfFeatures",
            testFunctions[1].name + "ReturnsSetOfStrings",
            ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testTwoDuplicateNames_OnlyDifferByTheirReturnTypes_OptionalCustomTypeAndVoid_AppendsReturnTypeNameToFunctionName() {
        let testFunctions = [
            Function(name: "test", returnType: "Feature?", arguments: [], defaultReturnValue: nil),
            Function(name: "test", returnType: nil, arguments: [], defaultReturnValue: nil),
            ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            testFunctions[0].name + "ReturnsOptionalFeature",
            testFunctions[1].name + "ReturnsVoid",
            ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
    
    func testThreeDuplicates_OneDifferentParameters_OneDifferentReturnType_AllThreeStayUnique() {
        let duplicateArguments = [Argument(name: "id", type: "String", externalName: "for"), Argument(name: "archived", type: "Bool", externalName: nil)]
        let otherArguments = [Argument(name: "id", type: "String", externalName: "for")]
        let testFunctions = [
            Function(name: "answers", returnType: nil, arguments: duplicateArguments, defaultReturnValue: nil),
            Function(name: "answers", returnType: "Int", arguments: duplicateArguments, defaultReturnValue: nil),
            Function(name: "answers", returnType: nil, arguments: otherArguments, defaultReturnValue: nil)
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            "answersForArchivedReturnsVoid",
            "answersForArchivedReturnsInt",
            "answersFor"
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }

    func testFourDuplicates_OneDifferentParameters_OneDifferentReturnType_AllFourStayUnique() {
        let differentArguments1 = [Argument(name: "id", type: "String", externalName: "for")]
        let differentArguments2 = [Argument(name: "ids", type: "[String]", externalName: "in")]
        let duplicateArguments = [Argument(name: "id", type: "String", externalName: "for"), Argument(name: "archived", type: "Bool", externalName: nil)]
       
        let testFunctions = [
            Function(name: "answers", returnType: nil, arguments: differentArguments1, defaultReturnValue: nil),
            Function(name: "answers", returnType: nil, arguments: differentArguments2, defaultReturnValue: nil),
            Function(name: "answers", returnType: nil, arguments: duplicateArguments, defaultReturnValue: nil),
            Function(name: "answers", returnType: "Int", arguments: duplicateArguments, defaultReturnValue: nil),
        ]
        
        let resultFunctions = testFunctions.mapForDuplicateNames()
        let resultingNames = baseStubMemberNames(ofFunctions: resultFunctions)
        
        XCTAssertTrue(nonNameAttributesAreIdentical(testFunctions: resultFunctions, resultFunctions: resultFunctions))
        XCTAssertEqual(Set(resultingNames).count, resultingNames.count)
        let expectedFunctionNames = [
            "answersFor",
            "answersIn",
            "answersForArchivedReturnsVoid",
            "answersForArchivedReturnsInt",
        ]
        XCTAssertEqual(resultingNames, expectedFunctionNames)
    }
}

private extension MapForDuplicateFunctionNamesTests {
    func baseStubMemberNames(ofFunctions functions: [Function]) -> [String] {
        return functions.map { $0.baseStubMemberName }
    }
    
    func nonNameAttributesAreIdentical(testFunctions: [Function], resultFunctions: [Function]) -> Bool {
        for (index, function) in testFunctions.enumerated() {
            guard
                function.name == function.name ||
                function.arguments == resultFunctions.element(at: index)?.arguments ||
                function.defaultReturnValue == resultFunctions.element(at: index)?.defaultReturnValue ||
                function.returnType == resultFunctions.element(at: index)?.returnType
                else {
                return false
            }
        }
        
        return true
    }
}
