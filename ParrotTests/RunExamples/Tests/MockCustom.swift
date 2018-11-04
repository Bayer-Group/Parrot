
//@@parrot-mock
class MockCustom: CustomProtocol {

	final class Stub {
		var customThingCallCount = 0
		var customThingShouldReturn: Custom = Custom(propertyString: "", propertyInt: 0)
		var customProtocolThingGetSetCallCount = 0
		var customProtocolThingGetSetShouldReturn: CustomProtocol = Custom(propertyString: "protocol", propertyInt: 1)
		var customThingGetSetCallCount = 0
		var customThingGetSetShouldReturn: Custom = Custom(propertyString: "", propertyInt: 0)
		var customProtocolThingCallCount = 0
		var customProtocolThingShouldReturn: CustomProtocol = Custom(propertyString: "protocol", propertyInt: 1)
		var returnCustomCallCount = 0
		var returnCustomShouldReturn: AnotherCustom = AnotherCustom(custom: Custom(propertyString: "", propertyInt: 0))
		var returnCustomFormattedCallCount = 0
		var returnCustomFormattedShouldReturn: AnotherCustom = AnotherCustom(custom: Custom(propertyString: "", propertyInt: 0))
	}

	var stub = Stub()

	var customThingGetSet: Custom {
		get {
			stub.customThingGetSetCallCount += 1
			return stub.customThingGetSetShouldReturn
		}
		set {
			stub.customThingGetSetShouldReturn = newValue
		}
	}

	var customProtocolThingGetSet: CustomProtocol {
		get {
			stub.customProtocolThingGetSetCallCount += 1
			return stub.customProtocolThingGetSetShouldReturn
		}
		set {
			stub.customProtocolThingGetSetShouldReturn = newValue
		}
	}

	var customProtocolThing: CustomProtocol {
		stub.customProtocolThingCallCount += 1
		return stub.customProtocolThingShouldReturn
	}

	var customThing: Custom {
		stub.customThingCallCount += 1
		return stub.customThingShouldReturn
	}

	func returnCustom() -> AnotherCustom {
		stub.returnCustomCallCount += 1
		return stub.returnCustomShouldReturn
	}

	func returnCustomFormatted() -> AnotherCustom {
		stub.returnCustomFormattedCallCount += 1
		return stub.returnCustomFormattedShouldReturn
	}

}