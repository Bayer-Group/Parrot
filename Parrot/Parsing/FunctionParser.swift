import Foundation

extension Argument {
    
    static func from(declaration: String) -> Argument? {
        let nameTypeDefSplit = declaration.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        
        guard let names = nameTypeDefSplit.element(at: 0)?.toTrimmedString, let type = nameTypeDefSplit.element(at: 1)?.toTrimmedString else { return nil }
        
        let nameComponents = names.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        
        let hasExternalName = nameComponents.count == 2
        
        if hasExternalName, let externalName = nameComponents.element(at: 0)?.toTrimmedString, let internalName = nameComponents.element(at: 1)?.toTrimmedString {
            return Argument(name: internalName, type: type, externalName: externalName)
        } else if let name = nameComponents.element(at: 0)?.toTrimmedString {
            return Argument(name: String(name), type: type, externalName: nil)
        } else {
            return nil
        }
    }
    
    static func argumentsFrom(argumentsString: String) -> [Argument] {
        return argumentsString
            .componentsSeparatedBy(separator: ",", ignoringOccurencesInside: .parenthesis)
            .compactMap { Argument.from(declaration: $0) }
    }
}

extension Function {
    
    static func from(declaration: String, defaultsTable: [String: String]) -> Function? {
        
        guard let components = splitComponents(from: declaration) else { return nil }
        
        let returnType = parseReturnType(from: components.returnTypeString, defaultsTable: defaultsTable)
        
        let arguments = Argument.argumentsFrom(argumentsString: components.argumentsString)
        
        return Function(name: components.name, returnType: returnType?.type, arguments: arguments, defaultReturnValue: returnType?.defaultReturnValue)
    }
    
    private static func splitComponents(from declaration: String) -> (funcType: String, name: String, argumentsString: String, returnTypeString: String)? {

        var returnType: String = ""
        
        // parse return type
        guard let (startArgumentsIndex, endArgumentsIndex) = declaration.substringScopeIndexes(enclosingCharacter: .parenthesis) else { Log.error("Could not parse argument scope"); return nil }
        
        let endParensPlusOne = String.Index(encodedOffset: endArgumentsIndex.encodedOffset + 1)
        let returnTypeSubstring = declaration[endParensPlusOne..<declaration.endIndex]
        
        if let returnArrowRange = returnTypeSubstring.range(of: "->") {
            returnType = String(declaration[returnArrowRange.upperBound...]).trimmed
        }
        
        // parse func type and func name
        let funcTypeAndName = String(declaration[..<startArgumentsIndex])
            .components(separatedBy: .whitespacesAndNewlines).filter {$0 != ""}
        
        guard let funcName = funcTypeAndName.last else { return nil }
        let funcType = Array(funcTypeAndName.dropLast()).joined(separator: " ")
        
        // the substring including ( ) for the arguments, then remove enclosing parents and trim
        let arguments = String(declaration[startArgumentsIndex...endArgumentsIndex].dropFirst().dropLast()).trimmed

        return (funcType: funcType, name: funcName, argumentsString: arguments, returnTypeString: returnType)
    }
    
    private static func parseReturnType(from declaration: String, defaultsTable: [String: String]) -> (type: String, defaultReturnValue: String?)? {
        if declaration == "" || declaration == "Void" || declaration == "Swift.Void" || declaration == "()" {
            return nil
        }

        // TODO: Where is the best place structure wise to put this
        let defaultReturnValue = defaultsTable[declaration] ?? KnownType.from(declaration: declaration)?.defaultReturnValue
        
        return (type: declaration, defaultReturnValue: defaultReturnValue)
    }
}



//    static func generateFunctionMock(token: String, index: Int, tokens: [String]) -> String {
//        var fileAddition = ""
//
//        var arguments = ""
//        var offset = 1
//        var nestedParensLevel = -1
//        var parsingArguments = false
//        while tokens[index + offset - 1] != ")" || nestedParensLevel != 0 {
//            if tokens[index + offset - 1] == ")" && nestedParensLevel != 0 {
//                nestedParensLevel -= 1
//            }
//
//            if tokens[index + offset] == "(" { parsingArguments = true }
//            var hasExternalVariableName: Bool {
//                guard index + offset < tokens.count - 1 else { return false }
//                let previousToken = tokens[index + offset - 1]
//                let nextToken = tokens[index + offset + 1]
//                return parsingArguments && (previousToken == ")" || previousToken == ",") && nextToken.last == ":"
//            }
//            let isEndOfArgument = tokens[index + offset].last == ":" || tokens[index + offset].last == ","
//            let requiresSpace = hasExternalVariableName || isEndOfArgument
//
//            let formattedToken = requiresSpace ? "\(tokens[index + offset]) " : tokens[index + offset]
//            arguments.append(formattedToken)
//
//            if tokens[index + offset] == "(" {
//                nestedParensLevel += 1
//            }
//            offset += 1
//        }
//
//        var returnValue: String? {
//            if tokens.count > (index + offset + 2), tokens[index + offset + 1] == "->" {
//                return "\(tokens[index + offset + 1]) \(tokens[index + offset + 2]) "
//            } else {
//                return nil
//            }
//        }
//
//        let funcCallCountVarName = "\(tokens[index + 1])CallCount"
//        let functionDefinition =
//        """
//        var \(funcCallCountVarName) = 0
//
//        \(token) \(arguments) \(returnValue ?? ""){
//        \(funcCallCountVarName) += 1
//        """
//
//        guard let _ = returnValue else {
//            return functionDefinition + "\n    }\n\n"
//        }
//
//        let funcShouldReturnVarName = "\(tokens[index + 1])ShouldReturn"
//
//        return (
//            """
//            var \(funcShouldReturnVarName): \(tokens[index + offset + 2]) = <#Default return value#>
//            \(functionDefinition)
//            return \(funcShouldReturnVarName)
//            }
//
//            """)
//    }
