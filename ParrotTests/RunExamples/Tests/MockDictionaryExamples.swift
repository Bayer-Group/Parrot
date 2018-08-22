
//@@parrot-mock
class MockSimpleDictionaryExamples: DictionaryExamples {

	final class Stub {
		
		var testDictionarySimpleCallCount = 0
		var testDictionarySimpleCalledWith = [[String: Any]]()
		var testDictionaryReturnSimpleCallCount = 0
		var testDictionaryReturnSimpleShouldReturn: [String: Any] = [:]
		var testDictionaryDictionaryArgAndReturnCallCount = 0
		var testDictionaryDictionaryArgAndReturnCalledWith = [[String: [String]]]()
		var testDictionaryDictionaryArgAndReturnShouldReturn: [Int: [Int]] = [:]
		var testDictionaryOptionalsCallCount = 0
		var testDictionaryOptionalsCalledWith = [[String: [String: Any]]?]()
		var testDictionaryOptionalsShouldReturn: [String: String]? = nil
	}

	var stub = Stub()

	func testDictionarySimple(myDictionary: [String: Any]) {
		stub.testDictionarySimpleCallCount += 1
		stub.testDictionarySimpleCalledWith.append(myDictionary)
	}

	func testDictionaryReturnSimple() -> [String: Any] {
		stub.testDictionaryReturnSimpleCallCount += 1
		return stub.testDictionaryReturnSimpleShouldReturn
	}

	func testDictionaryDictionaryArgAndReturn(my dictionary: [String: [String]]) -> [Int: [Int]] {
		stub.testDictionaryDictionaryArgAndReturnCallCount += 1
		stub.testDictionaryDictionaryArgAndReturnCalledWith.append(dictionary)
		return stub.testDictionaryDictionaryArgAndReturnShouldReturn
	}

	func testDictionaryOptionals(optionalDictionary: [String: [String: Any]]?) -> [String: String]? {
		stub.testDictionaryOptionalsCallCount += 1
		stub.testDictionaryOptionalsCalledWith.append(optionalDictionary)
		return stub.testDictionaryOptionalsShouldReturn
	}

}