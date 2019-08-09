struct DefaultsParser {

    static func defaultsTable(from lines: [String]) -> [String: String] {
        var defaultsTable = [String: String]()
        
        for line in lines {
            guard line.hasPrefix("let") else { continue }
            
            guard let colonIndex = line.firstIndex(of: ":"), let equalsIndex = line.firstIndex(of: "=") else { continue }
            
            let type = line[colonIndex.indexPlusOne..<equalsIndex].toTrimmedString
            
            let definition = line[equalsIndex.indexPlusOne...].toTrimmedString

            if !defaultsTable.keys.contains(type) {
                defaultsTable[type] = definition
            }
        }
        
        return defaultsTable
    }
}
