
import Foundation

extension FileManager {
    
    func fileExists(url: URL) -> Bool {
        if fileExists(atPath: url.path) {
            return true
        }
        return false
    }
    
    func fileIsReadableAndWritable(atUrl url: URL) -> Bool {
        guard self.fileExists(atPath: url.path),
            self.isReadableFile(atPath: url.path),
            self.isWritableFile(atPath: url.path) else {
                Log.error("File does not exist or is not readable and writable at path: '\(url.path)'")
                return false
        }
        return true
    }
    
    func directoryExists(atUrl url: URL) -> Bool {
        var isDir : ObjCBool = false
        if fileExists(atPath: url.path, isDirectory:&isDir) {
            if isDir.boolValue {
                return true
            }
        }
        return false
    }
    
}
