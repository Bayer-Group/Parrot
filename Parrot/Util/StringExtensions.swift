import Foundation

// TODO: update substringScopeIndexes to handle multi-character delimiter

extension String {
    var trimmed: String { return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    func stringCapitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func substringScopeIndexes(enclosingCharacter: EnclosingCharacter) -> (startIndex: String.Index, endIndex: String.Index)? {
        var startIndices = [String.Index]()
        var endIndices = [String.Index]()
        for (index, character) in self.enumerated() {
            if enclosingCharacter.start == String(character) {
                startIndices.append(String.Index(encodedOffset: index))
            }
            else if enclosingCharacter.end == String(character) {
                endIndices.append(String.Index(encodedOffset: index))
                if startIndices.count == endIndices.count { break }
            }
        }
        guard
            let startIndex = startIndices.first,
            let endIndex = endIndices.last,
            startIndex <= endIndex,
            startIndices.count == endIndices.count
        else { return nil }
        
        return (startIndex, endIndex)
    }
    
    func substringScopeString(enclosingCharacter: EnclosingCharacter) -> String? {
        guard let (startIndex, endIndex) = substringScopeIndexes(enclosingCharacter: enclosingCharacter) else { return nil }
        
        return String(self[String.Index(encodedOffset: startIndex.encodedOffset + 1)..<endIndex])
    }
    
    func componentsSeparatedBy(separator: String, ignoringOccurencesInside enclosingCharacter: EnclosingCharacter) -> [String] {
        guard self.contains(separator) else { return [self] }
        
        let rangesOfEnclosingCharacter = rangesOf(enclosingCharacter: enclosingCharacter)
        
        return components(separatedBy: separator, ignoringOccurencesInRanges: rangesOfEnclosingCharacter)
    }
    
    func rangesOf(enclosingCharacter: EnclosingCharacter) -> [Range<String.Index>] {
        var rangesOfEnclosingCharacter = [Range<String.Index>]()
        var mutableSelf = self[startIndex...]

        while let (openingCharacterIndex, closingCharacterIndex) = mutableSelf.substringScopeIndexes(enclosingCharacter: enclosingCharacter) {
            
            rangesOfEnclosingCharacter.append(openingCharacterIndex.indexPlusOne..<closingCharacterIndex)
            mutableSelf = self[closingCharacterIndex.indexPlusOne...]
        }
        
        return rangesOfEnclosingCharacter
    }

    func components(separatedBy separator: String, ignoringOccurencesInRanges ranges: [Range<String.Index>]) -> [String] {
        guard ranges.count > 0 else { return self.components(separatedBy: separator) }
        
        let indexesOfSeparator = indexes(ofSeparator: separator, ignoringOccurencesInRanges: ranges)
        
        guard indexesOfSeparator.count > 0 else { return [self] }
        
        var components = [String]()
        for (index, separatorIndex) in indexesOfSeparator.enumerated() {
            if index == 0 {
                let firstComponent = String(self[self.startIndex..<separatorIndex])
                components.append(firstComponent)
            }
            
            if index > 0, index <= (indexesOfSeparator.count - 1) {
                let middleComponent = String(self[indexesOfSeparator[index - 1].indexPlusOne..<separatorIndex])
                components.append(middleComponent)
            }
            
            if index == (indexesOfSeparator.count - 1) {
                let lastComponent = String(self[separatorIndex.indexPlusOne...])
                components.append(lastComponent)
            }
        }
        
        return components
    }
    
    func indexes(ofSeparator separator: String, ignoringOccurencesInRanges ranges: [Range<String.Index>]) -> [String.Index] {
        var separatorIndexes = [String.Index]()
        var currentSubString: Substring = Substring(self)
        
        while let enclosingCharacterIndex = currentSubString.firstIndex(of: ",") {
            
            if enclosingCharacterIndex.isNotContainedIn(ranges: ranges) {
                separatorIndexes.append(enclosingCharacterIndex)
            }
            
            currentSubString = self[enclosingCharacterIndex.indexPlusOne...]
        }
        
        return separatorIndexes
    }
}

extension Substring { // TODO: Duplicate the tests from the string version, add a case for it respecting the indexes of the original string
    func substringScopeIndexes(enclosingCharacter: EnclosingCharacter) -> (startIndex: Substring.Index, endIndex: Substring.Index)? {
        var startIndices = [Substring.Index]()
        var endIndices = [Substring.Index]()
        
        for (index, character) in self.enumerated() {
            if enclosingCharacter.start == String(character) {
                startIndices.append(self.index(startIndex, offsetBy: index))
            }
            else if enclosingCharacter.end == String(character) {
                endIndices.append(self.index(startIndex, offsetBy: index))
                if startIndices.count == endIndices.count { break }
            }
        }
        guard
            let startIndex = startIndices.first,
            let endIndex = endIndices.last,
            startIndex <= endIndex,
            startIndices.count == endIndices.count
            else { return nil }
        
        return (startIndex, endIndex)
    }
}

extension Substring {
    var toTrimmedString: String {
        return String(self).trimmed
    }
}
