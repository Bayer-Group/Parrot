protocol DictionaryExamples {
    func testDictionarySimple(myDictionary: [String: Any])
    func testDictionaryReturnSimple() -> [String: Any]
    func testDictionaryDictionaryArgAndReturn(my dictionary: [String: [String]]) -> [Int: [Int]]
    func testDictionaryOptionals(optionalDictionary: [String: [String: Any]]?) -> [String: String]?
}

protocol ComplexDictionaryExamples {
    func testCompletionAndDictionary(parameters: [String: String], completion: @escaping (String?, String?) -> ()) -> [String: Any]?
    func testOtherArgsDictionary(dictionary: [String: Int]?, my string: String, num: Double) -> (String?, Int?) -> ()
}
