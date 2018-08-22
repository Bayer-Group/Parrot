extension String.Index {
    var indexPlusOne: String.Index {
        return String.Index(encodedOffset: self.encodedOffset + 1)
    }
    
    func isNotContainedIn(ranges: [Range<String.Index>]) -> Bool {
        for range in ranges {
            if range.contains(self) {
                return false
            }
        }
        
        return true
    }
}
