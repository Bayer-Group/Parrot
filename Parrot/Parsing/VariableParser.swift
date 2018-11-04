import Foundation

extension Variable {
    
    static func from(declaration: String, defaultsTable: [String: String]) -> Variable? {
        let specialCharacters = CharacterSet(charactersIn: ":{},")
        
        func equalsColon(character: Character) -> Bool { return character == ":" }
        let variableInfo = declaration.split(maxSplits: 1, omittingEmptySubsequences: true, whereSeparator: equalsColon)
        
        guard let modifierAndName = variableInfo.first?.components(separatedBy: specialCharacters.union(.whitespacesAndNewlines)),
            let typeAndGetSetInfo = variableInfo.last?.split(maxSplits: 1, omittingEmptySubsequences: true, whereSeparator: { $0 == "{" }),
            let type = typeAndGetSetInfo.first?.toTrimmedString,
            let getSetInfo = typeAndGetSetInfo.last?.toTrimmedString
        else { return nil }
        
        let filteredModifierAndName = modifierAndName.filter { $0 != "" }

        guard let name = filteredModifierAndName.last else { return nil }
        
        guard (filteredModifierAndName.first?.hasPrefix("func ") == false), filteredModifierAndName.contains("var"), getSetInfo.contains("get") else { return nil }
        
        let isWeak = filteredModifierAndName.contains("weak")
        let isGetSet = getSetInfo.contains("set")
        
        // TODO: Where is the best place structure wise to put this
        let defaultReturnValue = defaultsTable[type] ?? KnownType.from(declaration: type)?.defaultReturnValue
        
        return Variable(name: name, type: type, defaultReturnValue: defaultReturnValue, isGetSet: isGetSet, isWeak: isWeak)
    }

}
