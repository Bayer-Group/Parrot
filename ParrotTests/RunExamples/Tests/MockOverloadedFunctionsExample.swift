#warning("TODO: Behavior for this one is crazy, not keeping things ordered and answerFor sometimes generates twice instead of renaming properly")
//@@parrot-mock
class MockOverloadedFunctionsExample: OverloadedFunctionExample {

	final class Stub {
		var answersCallCount = 0
		var answersShouldReturn: [String] = []
		var answersForArchivedReturnsVoidCallCount = 0
		var answersForArchivedReturnsVoidCalledWith = [(id: String, archived: Bool)]()
		var answersForArchivedReturnsIntCallCount = 0
		var answersForArchivedReturnsIntCalledWith = [(id: String, archived: Bool)]()
		var answersForArchivedReturnsIntShouldReturn: Int = 0
		var answersForCallCount = 0
		var answersForCalledWith = [String]()
		var answersInCallCount = 0
		var answersInCalledWith = [[String]]()
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	var answers: [String] {
		stub.answersCallCount += 1
		return stub.answersShouldReturn
	}

	func answers(for id: String, archived: Bool) {
		stub.answersForArchivedReturnsVoidCallCount += 1
		stub.answersForArchivedReturnsVoidCalledWith.append((id, archived))
	}

	func answers(for id: String, archived: Bool) -> Int {
		stub.answersForArchivedReturnsIntCallCount += 1
		stub.answersForArchivedReturnsIntCalledWith.append((id, archived))
		return stub.answersForArchivedReturnsIntShouldReturn
	}

	func answers(for id: String) {
		stub.answersForCallCount += 1
		stub.answersForCalledWith.append(id)
	}

	func answers(in ids: [String]) {
		stub.answersInCallCount += 1
		stub.answersInCalledWith.append(ids)
	}

}