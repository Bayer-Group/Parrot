import Foundation

class AmazingClass {
    // I do so many things
}
protocol TheWrongProtocol {

}

// TODO: Check that the weak vars still work
protocol SomeProtocol: class {
    var myVariable: String { get }
    var myGetSet: String { get set }
    
    var myArrayGet: [String] { get }
    var mySetOfDoublesGet: Set<Double> { get }
    
    var myWeakGet: AmazingClass? { get }
    var myWeakGetSet: AmazingClass? { get set }
    
    func myBasicFunc()
    func myBasicFuncTwo(name: String) -> Int
    func myBasicFuncThree(name: String, age: Int, address: String) -> String?
    func myFuncWith(external name: String)
}

struct AmazingStruct {
    // I'm boring
}

protocol SomeOptionalThings {
    var myVariable: String? { get }
    var myGetSet: String? { get set }
    
    var myArrayGet: [String]? { get }
    var myArrayGetOptionalElement: [String?] { get }
    var myDictionaryGet: [String: String]? { get }
    var myDictionaryGetOptionalValue: [String: String?] { get }
    var myDictionaryGetOptionalValueAndSelf: [String: String?]? { get }
    var mySetOfDoublesGet: Set<Double>? { get }
    var mySetOfDoublesGetOptionalElement: Set<Double?> { get }
    
    var myWeakGet: AmazingClass? { get }
    var myWeakGetSet: AmazingClass? { get set }
    
}
