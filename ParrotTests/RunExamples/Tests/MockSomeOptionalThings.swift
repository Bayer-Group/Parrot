
//@@parrot-mock
final class MockSomeOptionalThings: SomeOptionalThings {

	final class Stub {
		var myArrayGetCallCount = 0
		var myArrayGetShouldReturn: [String]?
		var myArrayGetOptionalElementCallCount = 0
		var myArrayGetOptionalElementShouldReturn: [String?] = []
		var myDictionaryGetCallCount = 0
		var myDictionaryGetShouldReturn: [String: String]?
		var myDictionaryGetOptionalValueCallCount = 0
		var myDictionaryGetOptionalValueShouldReturn: [String: String?] = [:]
		var myDictionaryGetOptionalValueAndSelfCallCount = 0
		var myDictionaryGetOptionalValueAndSelfShouldReturn: [String: String?]?
		var myGetSetCallCount = 0
		var myGetSetShouldReturn: String?
		var mySetOfDoublesGetCallCount = 0
		var mySetOfDoublesGetShouldReturn: Set<Double>?
		var mySetOfDoublesGetOptionalElementCallCount = 0
		var mySetOfDoublesGetOptionalElementShouldReturn: Set<Double?> = []
		var myVariableCallCount = 0
		var myVariableShouldReturn: String?
		var myWeakGetCallCount = 0
		var myWeakGetShouldReturn: AmazingClass?
		var myWeakGetSetCallCount = 0
		var myWeakGetSetShouldReturn: AmazingClass?
		
	}

	var stub = Stub()

	func parrotResetMock() {
		stub = Stub()
	}

	var myWeakGetSet: AmazingClass? {
		get {
			stub.myWeakGetSetCallCount += 1
			return stub.myWeakGetSetShouldReturn
		}
		set {
			stub.myWeakGetSetShouldReturn = newValue
		}
	}

	var myGetSet: String? {
		get {
			stub.myGetSetCallCount += 1
			return stub.myGetSetShouldReturn
		}
		set {
			stub.myGetSetShouldReturn = newValue
		}
	}

	var myWeakGet: AmazingClass? {
		stub.myWeakGetCallCount += 1
		return stub.myWeakGetShouldReturn
	}

	var myVariable: String? {
		stub.myVariableCallCount += 1
		return stub.myVariableShouldReturn
	}

	var mySetOfDoublesGetOptionalElement: Set<Double?> {
		stub.mySetOfDoublesGetOptionalElementCallCount += 1
		return stub.mySetOfDoublesGetOptionalElementShouldReturn
	}

	var mySetOfDoublesGet: Set<Double>? {
		stub.mySetOfDoublesGetCallCount += 1
		return stub.mySetOfDoublesGetShouldReturn
	}

	var myDictionaryGetOptionalValueAndSelf: [String: String?]? {
		stub.myDictionaryGetOptionalValueAndSelfCallCount += 1
		return stub.myDictionaryGetOptionalValueAndSelfShouldReturn
	}

	var myDictionaryGetOptionalValue: [String: String?] {
		stub.myDictionaryGetOptionalValueCallCount += 1
		return stub.myDictionaryGetOptionalValueShouldReturn
	}

	var myDictionaryGet: [String: String]? {
		stub.myDictionaryGetCallCount += 1
		return stub.myDictionaryGetShouldReturn
	}

	var myArrayGetOptionalElement: [String?] {
		stub.myArrayGetOptionalElementCallCount += 1
		return stub.myArrayGetOptionalElementShouldReturn
	}

	var myArrayGet: [String]? {
		stub.myArrayGetCallCount += 1
		return stub.myArrayGetShouldReturn
	}


}