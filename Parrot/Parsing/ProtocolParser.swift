import Foundation

struct ProtocolParser {
    
    static func protocolEntity(with protocolName: String, in files: [File], defaultsTable: [String: String]) -> ProtocolEntity? {
        
        let protocolEntities: [ProtocolEntity] = files.compactMap { (file) in
            
            let foundProtocol =  file.lines.enumerated().first { index, line in
                let protocolDefinitionWithName = "protocol \(protocolName)"
                return line.hasPrefix(protocolDefinitionWithName) || line.hasPrefix("public \(protocolDefinitionWithName)") || line.hasPrefix("internal \(protocolDefinitionWithName)")
            }
            
            guard let lineNumber = foundProtocol?.offset else { return nil }
            
            let filteredFileLines = Array(file.lines.dropFirst(lineNumber)).filter { $0 != "" }
            let fileContents = filteredFileLines.joined(separator: "\n")
            
            guard let protocolString =  fileContents.substringScopeString(enclosingCharacter: .curlyBrackets) else { return nil }
            
            let protocolContents = protocolString.components(separatedBy: "\n")
            
            // TODO: Support commented out lines in a protocol -- right now the logic does not recognize comments appropriately
            
            let variables: [Variable] = protocolContents.compactMap { line in
                let components = line.components(separatedBy: .whitespacesAndNewlines).filter { $0 != "" }
                if !components.contains("var") { return nil }
                return Variable.from(declaration: line, defaultsTable: defaultsTable)
            }
            
            let functions: [Function] = protocolContents.compactMap { line in
                let components = line.components(separatedBy: .whitespacesAndNewlines).filter { $0 != "" }
                if !components.contains("func") { return nil }
                return Function.from(declaration: line, defaultsTable: defaultsTable)
            }
            
            let conformances = protocolConformances(fromProtocolFirstLine: filteredFileLines.first)
            let protocolsToConformTo = conformances.compactMap { protocolEntity(with: $0, in: files, defaultsTable: defaultsTable) }
            
            let variablesFromConformances = protocolsToConformTo.flatMap { $0.variables }
            let functionsFromConformances = protocolsToConformTo.flatMap { $0.functions }
            let uniqueVariables = Array(Set<Variable>(variables + variablesFromConformances)).sorted { $0.name < $1.name }
            let uniqueFunctions = Array(Set<Function>(functions + functionsFromConformances)).sorted { $0.name < $1.name }
            
            return ProtocolEntity(file: file, name: protocolName, variables: uniqueVariables, functions: uniqueFunctions)
        }
        
        return protocolEntities.first
    }
    
    static func protocolConformances(fromProtocolFirstLine firstProtocolLine: String?) -> [String] {
        guard
            let splitByNameAndConformances = firstProtocolLine?.split(maxSplits: 1, omittingEmptySubsequences: true, whereSeparator: { $0 == ":" }),
            splitByNameAndConformances.count > 1 else { return [] }
        
        guard let conformances = splitByNameAndConformances.last?
            .toTrimmedString
            .dropLast()
            .components(separatedBy: ",")
            .map({ $0.trimmed })
        else { return [] }
        
        let conformancesWithoutClass = conformances.first == "class" ? conformances.dropFirst().map { $0 } : conformances

        return conformancesWithoutClass
    }
}
