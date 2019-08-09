
//@@parrot-mock
final class MockMyConformingProtocol: MyConformingProtocol {

	final class Stub {
		var myStringCallCount = 0
		var myStringShouldReturn: String = ""
		var myFunctionCallCount = 0
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	var myString: String {
		stub.myStringCallCount += 1
		return stub.myStringShouldReturn
	}

	func myFunction() {
		stub.myFunctionCallCount += 1
	}

}