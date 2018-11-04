
import Foundation

extension Variable {
    
    var mockImplementationLines: [String] {
        let weakModifier = isWeak ? "weak " : ""
        
        if isGetSet {
            return [
                "\(weakModifier)var \(name): \(type) {",
                "get {",
                "stub.\(name)CallCount += 1",
                "return stub.\(name)ShouldReturn",
                "}",
                "set {",
                "stub.\(name)ShouldReturn = newValue",
                "}",
                "}"
            ]
        }
        
        return [
            "\(weakModifier)var \(name): \(type) {",
            "stub.\(name)CallCount += 1",
            "return stub.\(name)ShouldReturn",
            "}"
        ]
    }
    
    var stubEntries: [String] {
        let assignmentText = " = "
        let returnValue: String
        if let defaultReturnValue = self.defaultReturnValue {
            returnValue = defaultReturnValue != "nil" ? "\(assignmentText)\(defaultReturnValue)" : ""
        } else {
            returnValue = "\(assignmentText)<#Default return value#>"
        }
        
        return [
            "var \(name)CallCount = 0",
            "var \(name)ShouldReturn: \(type)\(returnValue)"
        ]
    }
    
}

