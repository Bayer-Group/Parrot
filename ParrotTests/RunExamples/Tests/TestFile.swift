
// Some comment!
import Foundation
import XCTest

//@@parrot-mock
final class MockModel: SomeProtocol {

	final class Stub {
		var myArrayGetCallCount = 0
		var myArrayGetShouldReturn: [String] = []
		var myGetSetCallCount = 0
		var myGetSetShouldReturn: String = ""
		var mySetOfDoublesGetCallCount = 0
		var mySetOfDoublesGetShouldReturn: Set<Double> = []
		var myVariableCallCount = 0
		var myVariableShouldReturn: String = ""
		var myWeakGetCallCount = 0
		var myWeakGetShouldReturn: AmazingClass?
		var myWeakGetSetCallCount = 0
		var myWeakGetSetShouldReturn: AmazingClass?
		var myBasicFuncCallCount = 0
		var myBasicFuncThreeCallCount = 0
		var myBasicFuncThreeCalledWith = [(name: String, age: Int, address: String)]()
		var myBasicFuncThreeShouldReturn: String? = nil
		var myBasicFuncTwoCallCount = 0
		var myBasicFuncTwoCalledWith = [String]()
		var myBasicFuncTwoShouldReturn: Int = 0
		var myFuncWithCallCount = 0
		var myFuncWithCalledWith = [String]()
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

	var myGetSet: String {
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

	var myVariable: String {
		stub.myVariableCallCount += 1
		return stub.myVariableShouldReturn
	}

	var mySetOfDoublesGet: Set<Double> {
		stub.mySetOfDoublesGetCallCount += 1
		return stub.mySetOfDoublesGetShouldReturn
	}

	var myArrayGet: [String] {
		stub.myArrayGetCallCount += 1
		return stub.myArrayGetShouldReturn
	}

	func myBasicFunc() {
		stub.myBasicFuncCallCount += 1
	}

	func myBasicFuncThree(name: String, age: Int, address: String) -> String? {
		stub.myBasicFuncThreeCallCount += 1
		stub.myBasicFuncThreeCalledWith.append((name, age, address))
		return stub.myBasicFuncThreeShouldReturn
	}

	func myBasicFuncTwo(name: String) -> Int {
		stub.myBasicFuncTwoCallCount += 1
		stub.myBasicFuncTwoCalledWith.append(name)
		return stub.myBasicFuncTwoShouldReturn
	}

	func myFuncWith(external name: String) {
		stub.myFuncWithCallCount += 1
		stub.myFuncWithCalledWith.append(name)
	}

}