import Foundation

extension Variable {
    
    static func from(declaration: String, defaultsTable: [String: String]) -> Variable? {
    
        let colon = CharacterSet(charactersIn: ":")
        let specialCharacters = CharacterSet(charactersIn: ":{},")
        
        let variableInfo = declaration.components(separatedBy: colon).filter { $0 != "" }
        
        guard let modifierAndName = variableInfo.first?.components(separatedBy: specialCharacters.union(.whitespacesAndNewlines)),
            let typeAndGetSetInfo = variableInfo.last?.components(separatedBy: specialCharacters.union(.whitespacesAndNewlines))
        else { return nil }
        
        let filteredModifierAndName = modifierAndName.filter { $0 != "" }
        let filteredTypeAndGetSetInfo = typeAndGetSetInfo.filter { $0 != "" }
        
        guard let name = filteredModifierAndName.last, let type = filteredTypeAndGetSetInfo.first else { return nil }
        
        if filteredModifierAndName.contains("func") ||
            !filteredModifierAndName.contains("var") ||
            !filteredTypeAndGetSetInfo.contains("get")
            { return nil  }
        
        let isWeak = filteredModifierAndName.contains("weak")
        let isGetSet = filteredTypeAndGetSetInfo.contains("set")
        
        // TODO: Where is the best place structure wise to put this
        let defaultReturnValue = defaultsTable[type] ?? KnownType.from(declaration: type)?.defaultReturnValue
        
        return Variable(name: name, type: type, defaultReturnValue: defaultReturnValue, isGetSet: isGetSet, isWeak: isWeak)
    }

}
