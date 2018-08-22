import Foundation

class AmazingClass {
    // I do so many things
}
protocol TheWrongProtocol {

}

protocol SomeProtocol: class {
    var myVariable: String { get }
    var myGetSet: String { get set }
    
    var myArrayGet: [String] { get }
    var mySetOfDoublesGet: Set<Double> { get }
    
    weak var myWeakGet: AmazingClass? { get }
    weak var myWeakGetSet: AmazingClass? { get set }
    
    func myBasicFunc()
    func myBasicFuncTwo(name: String) -> Int
    func myBasicFuncThree(name: String, age: Int, address: String) -> String?
    func myFuncWith(external name: String)
}

struct AmazingStruct {
    // I'm boring
}
