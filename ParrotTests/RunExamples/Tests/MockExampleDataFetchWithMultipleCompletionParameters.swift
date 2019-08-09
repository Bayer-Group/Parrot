
//@@parrot-mock
class MockExampleDataFetcherWithMultipleCompletionParameters: ExampleDataFetcherWithMultipleCOmpletionParameters {

	final class Stub {
		
		var fetchCallCount = 0
		var fetchCalledWith = [(String?, String?) -> ()]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func fetch(completion: @escaping (String?, String?) -> ()) {
		stub.fetchCallCount += 1
		stub.fetchCalledWith.append(completion)
	}

}