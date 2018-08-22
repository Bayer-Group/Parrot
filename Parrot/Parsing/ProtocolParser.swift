import Foundation

struct ProtocolParser {
    
    // TODO: handle nested type defs in the protocol

    static func protocolEntity(with protocolName: String, in files: [File], defaultsTable: [String: String]) -> ProtocolEntity? {
        
        let protocolEntities: [ProtocolEntity] = files.compactMap { (file) in
            
            let foundProtocol =  file.lines.enumerated().first { index, line in
                let protocolDefinitionWithName = "protocol \(protocolName)"
                return line.hasPrefix(protocolDefinitionWithName) || line.hasPrefix("public \(protocolDefinitionWithName)")
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
            
            return ProtocolEntity(file: file, name: protocolName, variables: variables, functions: functions)
        }
        
        return protocolEntities.first
    }
    
}
