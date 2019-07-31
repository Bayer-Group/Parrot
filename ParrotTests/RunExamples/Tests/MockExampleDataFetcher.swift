
//@@parrot-mock
class MockExampleDataFetcher: ExampleDataFetcher {

	final class Stub {
		
		var fetchCallCount = 0
		var fetchCalledWith = [() -> ()]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	func fetch(completion: @escaping () -> ()) {
		stub.fetchCallCount += 1
		stub.fetchCalledWith.append(completion)
	}

}