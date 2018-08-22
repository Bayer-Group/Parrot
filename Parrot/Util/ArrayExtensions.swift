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

extension Array where Element == Function {
    
    func mapForDuplicateNames() -> [Function] {
        
        var mutableSelf = self

        for (index, function) in enumerated() {
            guard let (matchingIndex, matchingFunction) = mutableSelf.enumerated().first(where: { $0.element.baseStubMemberName == function.baseStubMemberName && $0.offset != index }) else { continue }

            var functionNewName = function.name
            var matchingFunctionNewName = matchingFunction.name
            var currentIndex = 0
            
            repeat {
                let nextArgument = function.arguments.element(at: currentIndex)
                let nextMatchingFunctionArgument = matchingFunction.arguments.element(at: currentIndex)

                guard nextArgument != nil || nextMatchingFunctionArgument != nil else { break }
                
                func resolvedNameToAppendFrom(argument: Argument?) -> String {
                    return (argument?.externalName ?? argument?.name ?? "").stringCapitalizingFirstLetter()
                }
                
                functionNewName += resolvedNameToAppendFrom(argument: nextArgument)
                matchingFunctionNewName += resolvedNameToAppendFrom(argument: nextMatchingFunctionArgument)

                currentIndex += 1
            } while functionNewName == matchingFunctionNewName

            if functionNewName == matchingFunctionNewName {
                func resolveNameToAppendFrom(functionReturnType: String?) -> String {
                    guard let functionReturnType = functionReturnType else { return "ReturnsVoid" }
                    
                    // TODO: maybe keep KnownType with the function struct creation
                    let functionReturnKnownType = KnownType.from(declaration: functionReturnType)
                    
                    switch functionReturnKnownType {
                    case .some(let knownType):
                        switch knownType {
                        case .arrayType: return "ReturnsArrayOf\(functionReturnType.dropFirst().dropLast())s"
                        case .dictionaryType:
                            let indexOfColon = functionReturnType.index(of: ":")!
                            return "ReturnsDictionaryOf\(functionReturnType[..<indexOfColon].dropFirst().toTrimmedString)To\(functionReturnType[indexOfColon...].dropFirst().dropLast().toTrimmedString)"

                        case .optionalType: return "ReturnsOptional\(functionReturnType.dropLast())"
                        case .setType: return "ReturnsSetOf\(functionReturnType.dropFirst(4).dropLast())s"
                        default: return "Returns\(knownType.rawValue)"
                        }
                    case .none:
                        return "Returns\(functionReturnType)"
                    }
                }
                
                functionNewName += resolveNameToAppendFrom(functionReturnType: function.returnType)
                matchingFunctionNewName += resolveNameToAppendFrom(functionReturnType: matchingFunction.returnType)
            }
            
            func copy(function: Function, changingBaseStubMemberNameTo name: String) -> Function {
                return Function(name: function.name, baseStubMemberName: name, returnType: function.returnType, arguments: function.arguments, defaultReturnValue: function.defaultReturnValue)
            }
            
            let renamedFunction = copy(function: function, changingBaseStubMemberNameTo: functionNewName)
            let matchingRenamedFunction = copy(function: matchingFunction, changingBaseStubMemberNameTo: matchingFunctionNewName)
            
            if mutableSelf[index].baseStubMemberName.count < renamedFunction.baseStubMemberName.count {
                mutableSelf[index] = renamedFunction
            }
            
            if mutableSelf[matchingIndex].baseStubMemberName.count < matchingRenamedFunction.baseStubMemberName.count {
                mutableSelf[matchingIndex] = matchingRenamedFunction
            }
        }
        
        return mutableSelf
    }
}

