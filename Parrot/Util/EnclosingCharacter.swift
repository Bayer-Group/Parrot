typealias Delimiter = (start: String, end: String)

enum EnclosingCharacter: RawRepresentable {
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
