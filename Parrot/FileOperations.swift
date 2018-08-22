
import Foundation

struct FileOperations {
    
    static func findSwiftFilesRecursively(in directory: URL) -> [URL]? {
        
        let launchPath = "/usr/bin/find"
        let arguments = ["-E", directory.path, "-type", "f", "-regex", ".*.swift"]
        
        let shellResult = Shell.run(launchPath: launchPath, arguments: arguments, environment: [:])
        
        if shellResult.status != 0 || shellResult.stdErr != "" {
            Log.error("Problem running 'find' command to search for Swift files: '\(launchPath) \(arguments.joined(separator: " "))'")
            Log.debug("Stderr from 'find' command: \(shellResult.stdErr)")
            Log.debug("Stdout from 'find' command: \(shellResult.stdOut)")
            return nil
        }
        
        let filteredOutput = shellResult.stdOut.components(separatedBy: .newlines) .map{$0.trimmed} .filter{$0.count > 0}
        return filteredOutput.map { URL(fileURLWithPath: $0) }
    }
    
    static func readFiles(at urls: [URL]) -> [File]? {
        
        var files = [File]()
        
        for url in urls {
            
            guard FileManager.default.fileIsReadableAndWritable(atUrl: url) else {
                Log.error("File does not exist or is not readable and writable at path: '\(url.path)'")
                return nil
            }
            
            guard let contents = try? String(contentsOf: url, encoding: .utf8) else {
                Log.error("Could not read contents of file at: '\(url.path)'")
                return nil
            }

            let lines = contents.components(separatedBy: .newlines) .map{$0.trimmed}
            let file = File(url: url, lines: lines)
            files.append(file)
        }
        
        return files
    }
    
    static func write(contents: String, url: URL) -> Bool {
        do {
            try contents.write(toFile: url.path, atomically: true, encoding: .utf8)
            return true
        } catch (let error) {
            Log.error("Error writing to file: \(url.path): \(error.localizedDescription)")
            return false
        }
    }

}
