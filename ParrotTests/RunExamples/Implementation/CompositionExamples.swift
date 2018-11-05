protocol MyConformingProtocol: ProtocolToConformTo {
    func myFunction()
}

protocol ProtocolToConformTo {
    var myString: String { get }
}

protocol NestedConformingProtocol: MyConformingProtocol {
    func mySecondFunction()
}

protocol MySecondConformingProtocol: class, ProtocolWithDuplicateRequirements {
    func duplicateFunction(test: [String]) -> Int?
    var nonDuplicateGet: Int { get }
    var duplicateDelegate: SomeProtocol? { get set }
    func nonDuplicateFunction() -> Set<String>
}

internal protocol ProtocolWithDuplicateRequirements {
    var duplicateDelegate: SomeProtocol? { get set }
    func duplicateFunction(test: [String]) -> Int?
    var nonDuplicateGetSet: Int { get set }
    func nonDuplicateFunction() -> Set<Int>
}
