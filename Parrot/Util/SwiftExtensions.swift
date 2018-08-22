
import Foundation

extension String {
    var trimmed: String { return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    func substringScopeIndexes(delimiter: SubstringDelimiter) -> (startIndex: String.Index, endIndex: String.Index)? {
        var startIndices = [String.Index]()
        var endIndices = [String.Index]()
        for (index, character) in self.enumerated() {
            if delimiter.start == String(character) {
                startIndices.append(String.Index(encodedOffset: index))
            }
            else if delimiter.end == String(character) {
                endIndices.append(String.Index(encodedOffset: index))
                if startIndices.count == endIndices.count { break }
            }
        }
        guard
            let startIndex = startIndices.first,
            let endIndex = endIndices.last,
            startIndex <= endIndex,
            startIndices.count == endIndices.count
        else { return nil }
        
        return (startIndex, endIndex)
    }
    
    func substringScopeString(delimiter: SubstringDelimiter) -> String? {
        guard let (startIndex, endIndex) = substringScopeIndexes(delimiter: delimiter) else { return nil }
        
        return String(self[String.Index(encodedOffset: startIndex.encodedOffset + 1)..<endIndex])
    }
}

extension Substring {
    func substringScopeIndexes(delimiter: SubstringDelimiter) -> (startIndex: Substring.Index, endIndex: Substring.Index)? {
        var startIndices = [Substring.Index]()
        var endIndices = [Substring.Index]()
        
        for (index, character) in self.enumerated() {
            if delimiter.start == String(character) {
                startIndices.append(self.index(startIndex, offsetBy: index))
            }
            else if delimiter.end == String(character) {
                endIndices.append(self.index(startIndex, offsetBy: index))
                if startIndices.count == endIndices.count { break }
            }
        }
        guard
            let startIndex = startIndices.first,
            let endIndex = endIndices.last,
            startIndex <= endIndex,
            startIndices.count == endIndices.count
            else { return nil }
        
        return (startIndex, endIndex)
    }
}

extension Array {
    
    func element(at index: Int) -> Element? {
        if index < 0 { return nil }
        if index >= self.count { return nil }
        return self[index]
    }
    
    func elements(from startIndex: Int, to endIndex: Int) -> [Element]? {
        if startIndex < 0 { return nil }
        if endIndex >= self.count { return nil }
        if startIndex > endIndex { return nil }
        return Array(self[startIndex...endIndex])
    }
    
}

extension Substring {
    var toTrimmedString: String {
        return String(self).trimmed
    }
}

// TODO: update substringScopeIndexes to handle multi-character delimiter
typealias Delimiter = (start: String, end: String)
enum SubstringDelimiter: RawRepresentable {
    case curlyBrackets, squareBrackets, parenthesis, backTick, singleQuote, doubleQuote
//    case blockComment
    
    var rawValue: Delimiter {
        switch(self){
        case .curlyBrackets: return (start: "{", end: "}")
        case .squareBrackets: return (start: "[", end: "]")
        case .parenthesis: return (start: "(", end: ")")
        case .backTick: return (start: "`", end: "`")
        case .singleQuote: return (start: "'", end: "'")
        case .doubleQuote: return (start: "\"", end: "\"")
//        case .blockComment: return (start: "/*", end: "*/")
        }
    }
    
    init?(rawValue: Delimiter) {
        switch rawValue {
        case (start: "{", end: "}"): self = .curlyBrackets
        case (start: "[", end: "]"): self = .squareBrackets
        case (start: "(", end: ")"): self = .parenthesis
        case (start: "`", end: "`"): self = .backTick
        case (start: "'", end: "'"): self = .singleQuote
        case (start: "\"", end: "\""): self = .doubleQuote
//        case (start: "/*", end: "*/"): self = .blockComment
        default: return nil
        }
    }
    
    var start: String { return self.rawValue.start }
    var end: String { return self.rawValue.end }
}

