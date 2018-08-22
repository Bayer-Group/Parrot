
//@@parrot-mock
class MockExampleDataFetcherWithOtherParameter: ExampleDataFetcherWithOtherParameter {

	final class Stub {
		
		var fetchCallCount = 0
		var fetchCalledWith = [(options: Bool, completion: () -> ())]()
	}

	var stub = Stub()

	func fetch(options: Bool, completion: @escaping () -> ()) {
		stub.fetchCallCount += 1
		stub.fetchCalledWith.append((options, completion))
	}

}