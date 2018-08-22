import Foundation

struct MockParser {

    static func mockEntities(in files: [File]) -> [MockEntity] {

        return files.compactMap { (file) in

            guard let (index, _) = file.lines.enumerated().first(where: { index, line -> Bool in
                return line.contains(Constants.mockableToken)
            }) else {
                return nil
            }
            let headers = file.lines.elements(from: 0, to: index - 1) ?? []
            
            guard let mockDefinition = file.lines.element(at: index + 1),
                let parsedMockInfo = mockInfo(from: mockDefinition) else { return nil }
            
            return MockEntity(file: file, headers: headers, type: parsedMockInfo.type,
                              name: parsedMockInfo.name, protocolName: parsedMockInfo.protocolName)
        }
    }
    
    private static func mockInfo(from definition: String) -> (type: String, name: String, protocolName: String)? {
        
        let colon = CharacterSet(charactersIn: ":")
        let specialCharacters = CharacterSet(charactersIn: ":{},")
        
        let typeInfoAndProtocol = definition.components(separatedBy: colon).filter { $0 != "" }
        
        guard let mockDeclarationInfo = typeInfoAndProtocol.first?.components(separatedBy: specialCharacters.union(.whitespacesAndNewlines)),
            let adoptedProtocolInfo = typeInfoAndProtocol.last?.components(separatedBy: specialCharacters.union(.whitespacesAndNewlines))
            else { return nil }
        
        let filteredAdoptedProtocolInfo = adoptedProtocolInfo.filter { $0 != "" }
        let filteredMockDeclarationInfo = mockDeclarationInfo.filter { $0 != "" }
        
        guard let protocolName = filteredAdoptedProtocolInfo.first,
            let mockName = filteredMockDeclarationInfo.last,
            let mockType = filteredMockDeclarationInfo.elements(from: 0, to: filteredMockDeclarationInfo.count - 2)
            else { return nil }
        
        return (type: mockType.joined(separator: " "), name: mockName, protocolName: protocolName)
    }

}


