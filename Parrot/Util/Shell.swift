
import Foundation

struct Shell {
    
    static func run(launchPath: String, arguments: [String] = [], environment: [String:String] = [:]) -> (status: Int, stdOut: String, stdErr: String) {
        
        // Set up process
        let process = Process()
        process.launchPath = launchPath
        process.arguments = arguments
        process.environment = environment
        
        if !FileManager.default.isExecutableFile(atPath: launchPath) {
            return (-1, "", "Launch path '\(launchPath)' does not exist or is not executable")
        }
        
        // Configure pipes and file handles
        let outPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outPipe
        process.standardError = errorPipe
        let outHandle = outPipe.fileHandleForReading
        let errorHandle = errorPipe.fileHandleForReading
        
        // Configure handlers to capture stdout and stderr
        var stdOut = ""
        var stdErr = ""
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: .utf8) {
                stdOut += line
            } else {
                Log.debug("Error decoding data: \(pipe.availableData)")
            }
        }
        
        errorHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: .utf8) {
                stdErr += line
            } else {
                Log.debug("Error decoding data: \(pipe.availableData)")
            }
        }
        
        // Launch process and wait
        process.launch()
        process.waitUntilExit()
        
        return (Int(process.terminationStatus), stdOut, stdErr)
    }
    
}

