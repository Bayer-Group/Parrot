import Foundation

struct MockGenerator {
    
    static func fileContents(from protocolEntity: ProtocolEntity, for mockEntity: MockEntity) -> String {
        
        let headers = mockEntity.headers.joined(separator: "\n")
        
        let functionResolvedOfDuplicateNames = protocolEntity.functions.mapForDuplicateNames()
        
        let variableStubs = protocolEntity.variables.map { return $0.stubEntries } .flatMap {$0}
        let functionStubs = functionResolvedOfDuplicateNames.map { return $0.stubEntries } .flatMap {$0}
        let formattedVariableStubs = variableStubs.joined(separator: "\n\t\t")
        let formattedFunctionStubs = functionStubs.joined(separator: "\n\t\t")
        
        let getSetVariables = protocolEntity.variables.filter { $0.isGetSet } .sorted { lhs, rhs in return !lhs.isWeak }
        let getVariables = protocolEntity.variables.filter { !$0.isGetSet } .sorted { lhs, rhs in return !lhs.isWeak }
        
        let formattedGetSetVariables = getSetVariables.map { getSetVariable in
            return formattedGetSetVariable(mockImplementationLines: getSetVariable.mockImplementationLines)
        }.joined(separator: "\n\n")
        
        let formattedGetVariables = getVariables.map { (variable) -> String in
            return variable.mockImplementationLines.enumerated().reduce("") { result, lineEnumeration in
                let (index, line) = lineEnumeration
                let isFirstOrLastLine = index == 0 || index == variable.mockImplementationLines.count - 1
                let indentation = isFirstOrLastLine ? "\t" : "\t\t"
                
                return "\(result)\(indentation)\(line)\n"
            }
        }.joined(separator: "\n")
        
        let formattedFunctions = functionResolvedOfDuplicateNames.map { (function) -> String in
            var definition = ""
            for (index, line) in function.mockImplementationLines.enumerated() {
                if index == 0 || index == function.mockImplementationLines.count - 1 {
                    definition += "\t" + line + "\n"
                } else {
                    definition += "\t\t" + line + "\n"
                }
            }
            return definition
        }.joined(separator: "\n")
        
        let newMock =
        """
        \(headers)
        //\(Constants.mockableToken)
        \(mockEntity.type) \(mockEntity.name): \(mockEntity.protocolName) {
        
        \tfinal class Stub {
        \t\t\(formattedVariableStubs)
        \t\t\(formattedFunctionStubs)
        \t}
        
        \tvar stub = Stub()
        
        \tfunc parrotResetMock() {
        \t\tstub = Stub()
        \t}
        
        \(formattedGetSetVariables.isEmpty ? "" : formattedGetSetVariables + "\n\n" )\(formattedGetVariables.isEmpty ? "" : formattedGetVariables + "\n")\(formattedFunctions)
        }
        """
        
        return newMock
    }
    
    static func formattedGetSetVariable(mockImplementationLines: [String]) -> String {
        return mockImplementationLines.enumerated()
            .map { index, line in
                let isFirstOrLastLine = index == 0 || index == mockImplementationLines.count - 1
                let isGetOrSetDefinition = line.hasPrefix("get") || line.hasPrefix("set") || line.hasPrefix("}")
                
                let indentation: String
                if isFirstOrLastLine {
                    indentation = "\t"
                } else if isGetOrSetDefinition {
                    indentation = "\t\t"
                } else {
                    indentation = "\t\t\t"
                }
                
                return "\(indentation)\(line)"
            }
            .joined(separator: "\n")
    }
}
