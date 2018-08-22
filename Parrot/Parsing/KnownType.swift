
import Foundation


// TODO: Possibly integrate nil coalescing reading defaults table into this enum somehow
enum KnownType: String {
    case intType = "Int"
    case doubleType = "Double"
    case stringType = "String"
    case boolType = "Bool"
    
    case optionalType = "nil"
    case arrayType = "Array"
    case dictionaryType = "Dictionary"
    case setType = "Set"
    
    var defaultReturnValue: String {
        switch self {
        case .intType: return "0"
        case .doubleType: return "0.0"
        case .stringType: return "\"\""
        case .boolType: return "false"
            
        case .optionalType: return "nil"
        case .arrayType: return "[]"
        case .dictionaryType: return "[:]"
        case .setType: return "[]"
        }
    }
    
    static func from(declaration: String) -> KnownType? {
        if let lastChar = declaration.last, lastChar == "?" {
            return .optionalType
        }
        if let firstChar = declaration.first,
            let lastChar = declaration.last,
            declaration.contains(":"),
            firstChar == "[",
            lastChar == "]" {
            return .dictionaryType
        }
        if let firstChar = declaration.first,
            let lastChar = declaration.last,
            firstChar == "[",
            lastChar == "]" {
            return .arrayType
        }

        if let setStringRange = declaration.range(of: "Set") {
            let afterSetString = String(declaration[setStringRange.upperBound...]).trimmed
            if let firstChar = afterSetString.first,
                let lastChar = afterSetString.last,
                firstChar == "<",
                lastChar == ">" {
                    return .setType
            }
        }
        
        return KnownType(rawValue: declaration)
    }
}
