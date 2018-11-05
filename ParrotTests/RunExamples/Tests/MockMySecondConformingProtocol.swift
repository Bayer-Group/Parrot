
//@@parrot-mock
final class MockMySecondConformingProtocol: MySecondConformingProtocol {

	final class Stub {
		var duplicateDelegateCallCount = 0
		var duplicateDelegateShouldReturn: SomeProtocol?
		var nonDuplicateGetCallCount = 0
		var nonDuplicateGetShouldReturn: Int = 0
		var nonDuplicateGetSetCallCount = 0
		var nonDuplicateGetSetShouldReturn: Int = 0
		var duplicateFunctionCallCount = 0
		var duplicateFunctionCalledWith = [[String]]()
		var duplicateFunctionShouldReturn: Int? = nil
		var nonDuplicateFunctionReturnsSetOfStringsCallCount = 0
		var nonDuplicateFunctionReturnsSetOfStringsShouldReturn: Set<String> = []
		var nonDuplicateFunctionReturnsSetOfIntsCallCount = 0
		var nonDuplicateFunctionReturnsSetOfIntsShouldReturn: Set<Int> = []
	}

	var stub = Stub()

	var nonDuplicateGetSet: Int {
		get {
			stub.nonDuplicateGetSetCallCount += 1
			return stub.nonDuplicateGetSetShouldReturn
		}
		set {
			stub.nonDuplicateGetSetShouldReturn = newValue
		}
	}

	var duplicateDelegate: SomeProtocol? {
		get {
			stub.duplicateDelegateCallCount += 1
			return stub.duplicateDelegateShouldReturn
		}
		set {
			stub.duplicateDelegateShouldReturn = newValue
		}
	}

	var nonDuplicateGet: Int {
		stub.nonDuplicateGetCallCount += 1
		return stub.nonDuplicateGetShouldReturn
	}

	func duplicateFunction(test: [String]) -> Int? {
		stub.duplicateFunctionCallCount += 1
		stub.duplicateFunctionCalledWith.append(test)
		return stub.duplicateFunctionShouldReturn
	}

	func nonDuplicateFunction() -> Set<String> {
		stub.nonDuplicateFunctionReturnsSetOfStringsCallCount += 1
		return stub.nonDuplicateFunctionReturnsSetOfStringsShouldReturn
	}

	func nonDuplicateFunction() -> Set<Int> {
		stub.nonDuplicateFunctionReturnsSetOfIntsCallCount += 1
		return stub.nonDuplicateFunctionReturnsSetOfIntsShouldReturn
	}

}