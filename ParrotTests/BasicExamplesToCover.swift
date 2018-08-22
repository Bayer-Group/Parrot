
import Foundation

// NOTE: Just making a list of use cases here..
// We can refine, put in separate files, and add them to the tests as we have time.

//////// Basic Variable Protocols //////

protocol VariableProtocol {
    var stringGet:String{get}
    var boolGet: Bool { get }
    var intGet  :  Int  {  get  }
    var doubleGet: Double { get }

    var stringGetSet: String { get set }
    var boolGetSet : Bool { get set }
    var intGetSet : Int { set get }          // 'set' and 'get' can be in any order
    var doubleGetSet: Double { set get }
    
    var optionalStringGet   :String?    { get }
    var optionalDoubleGetSet   :   Double?    { get set }
}

protocol VariableProtocolWithArraysAndOptionals {
    var stringArrayGet : [String] { get }
    var intArrayGetSet : [Int] { get set }
    
    var optionalIntArrayGet:[Int]?{ get }
    var optionalDoubleArrayGetSet:[Double]?{ get set }
    
    var doubleOptionalArrayGet:[Double?] { get }
    var boolOptionalArrayGetSet :[ Bool? ] { get set }
    
    var optionalStringOptionalArrayGet: [String?]? { get }
}

protocol VariableProtocolWithDictionariesAndOptionals {
    var stringAnyDictGet: [String:Any] { get }
    var stringIntDictGetSet: [String:Int] { get set }
    
    var optionalStringIntDictGet: [String: Int]? { get }
    var optionalStringBoolDictGetSet: [String: Bool]? { get set }
    
    var stringOptionalIntDictGet: [String:Int?] { get }
    var intOptionalBoolDictGetSet: [Int:Bool?] { get set }
    
    var optionalStringOptionalIntDictGet: [ String: Int? ]? { get }
    var optionalIntOptionalBoolDictGetSet: [ Int: Bool? ]? { get set }
}

protocol VariableProtocolWithAnyAndAnyObjectAndClassDeclaration: class {
    var anyObjectGet: AnyObject { get }
    var anyGet: Any { get }
    var optionalAnyGet: Any? { get }
    var optionalAnyObjectGet: AnyObject? { get }
}

//////// Weak Var / Delegate Protocol //////

protocol SampleDelegate: class {
    func dataRefreshed()
}

protocol VariableProtocolWithWeak {
    weak var weakDelegateGet: SampleDelegate? { get }
    weak var weakDelegateGetSet: SampleDelegate? { get set }
}



// variables with custom data types
// variables with sets
// static vars


//////// Function Protocols //////

protocol FunctionProtocolBasic {
    func noArgsNoReturn()
    func noArgsNoReturnVoid() -> Void
    func noArgsNoReturnSwiftVoid() -> Swift.Void
    func noArgsNoReturnEmptyClosure() -> ()
    func oneArgNoReturn(name: String)
    func oneArgNoReturn(age: Int)
    func oneArgBoolReturn(name: String) -> Bool
    func oneArgIntReturn(age: Int) -> Int
    func twoArgNoReturn(name: String, age: Int)
    func threeArgNoReturn(name: String, age: Int, location: Double?)
    func threeArgOptionalDoubleReturn(name: String, age: Int, location: Double?) -> Double?
}



protocol FunctionProtocolAdvanced {
    
    // tuple param
    // tuple return value
    // external/internal name
    // _ for name
    // variadic parameter
    // Arrays, Dictionaries, and Sets as params and return values
    // Closures as params and returns
    // static funcs
    
    // array of dicts
    // class protocols
    // public, open, internal, fileprivate, private modifierss
    func twoArgsWithOneClosure(name: String, completion: (Int, String) -> (Bool))
    func threeArgsWithOneClosure(name: String, age: Int, completion: @escaping (Int, String) -> (Bool))

}

