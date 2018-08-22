
//@@parrot-mock
class MockComplexDictionaryExmaples: ComplexDictionaryExamples {

	final class Stub {
		
		var testCompletionAndDictionaryCallCount = 0
		var testCompletionAndDictionaryCalledWith = [(parameters: [String: String], completion: (String?, String?) -> ())]()
		var testCompletionAndDictionaryShouldReturn: [String: Any]? = nil
		var testOtherArgsDictionaryCallCount = 0
		var testOtherArgsDictionaryCalledWith = [(dictionary: [String: Int]?, string: String, num: Double)]()
		var testOtherArgsDictionaryShouldReturn: (String?, Int?) -> () = { _, _ in } // This shouldn't be necessary
	}

	var stub = Stub()

	func testCompletionAndDictionary(parameters: [String: String], completion: @escaping (String?, String?) -> ()) -> [String: Any]? {
		stub.testCompletionAndDictionaryCallCount += 1
		stub.testCompletionAndDictionaryCalledWith.append((parameters, completion))
		return stub.testCompletionAndDictionaryShouldReturn
	}

	func testOtherArgsDictionary(dictionary: [String: Int]?, my string: String, num: Double) -> (String?, Int?) -> () {
		stub.testOtherArgsDictionaryCallCount += 1
		stub.testOtherArgsDictionaryCalledWith.append((dictionary, string, num))
		return stub.testOtherArgsDictionaryShouldReturn
	}

}