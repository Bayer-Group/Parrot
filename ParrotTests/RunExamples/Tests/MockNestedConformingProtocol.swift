
//@@parrot-mock
final class MockNestedConformingProtocol: NestedConformingProtocol {

	final class Stub {
		var myStringCallCount = 0
		var myStringShouldReturn: String = ""
		var myFunctionCallCount = 0
		var mySecondFunctionCallCount = 0
	}

	var stub = Stub()

	var myString: String {
		stub.myStringCallCount += 1
		return stub.myStringShouldReturn
	}

	func myFunction() {
		stub.myFunctionCallCount += 1
	}

	func mySecondFunction() {
		stub.mySecondFunctionCallCount += 1
	}

}