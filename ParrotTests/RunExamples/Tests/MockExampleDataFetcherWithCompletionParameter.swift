
//@@parrot-mock
class MockExampleDataFetcherWithCompletionParameters: ExampleDataFetcherWithCompletionParameter {

	final class Stub {
		
		var fetchCallCount = 0
		var fetchCalledWith = [([String]) -> ()]()
	}

	var stub = Stub()

	func fetch(completion: @escaping ([String]) -> ()) {
		stub.fetchCallCount += 1
		stub.fetchCalledWith.append(completion)
	}

}