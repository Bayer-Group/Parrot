
//@@parrot-mock
class MockSimpleDictionaryExamples: DictionaryExamples {

	final class Stub {
		var varGetDictionaryCallCount = 0
		var varGetDictionaryShouldReturn: [String: String] = [:]
		var varGetSetDictionaryCallCount = 0
		var varGetSetDictionaryShouldReturn: [String: String] = [:]
		var testDictionaryDictionaryArgAndReturnCallCount = 0
		var testDictionaryDictionaryArgAndReturnCalledWith = [[String: [String]]]()
		var testDictionaryDictionaryArgAndReturnShouldReturn: [Int: [Int]] = [:]
		var testDictionaryOptionalsCallCount = 0
		var testDictionaryOptionalsCalledWith = [[String: [String: Any]]?]()
		var testDictionaryOptionalsShouldReturn: [String: String]? = nil
		var testDictionaryReturnSimpleCallCount = 0
		var testDictionaryReturnSimpleShouldReturn: [String: Any] = [:]
		var testDictionarySimpleCallCount = 0
		var testDictionarySimpleCalledWith = [[String: Any]]()
	}

	var stub = Stub()

	var varGetSetDictionary: [String: String] {
		get {
			stub.varGetSetDictionaryCallCount += 1
			return stub.varGetSetDictionaryShouldReturn
		}
		set {
			stub.varGetSetDictionaryShouldReturn = newValue
		}
	}

	var varGetDictionary: [String: String] {
		stub.varGetDictionaryCallCount += 1
		return stub.varGetDictionaryShouldReturn
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

	func testDictionaryReturnSimple() -> [String: Any] {
		stub.testDictionaryReturnSimpleCallCount += 1
		return stub.testDictionaryReturnSimpleShouldReturn
	}

	func testDictionarySimple(myDictionary: [String: Any]) {
		stub.testDictionarySimpleCallCount += 1
		stub.testDictionarySimpleCalledWith.append(myDictionary)
	}

}