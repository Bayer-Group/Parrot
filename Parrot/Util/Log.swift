
import Foundation

struct Log {
    
    static func error(_ message: String = "", file: String = #file, function: String = #function, line: Int = #line) {
        var text = description(function: function, file: file, line: line)
        text += " : \(message)"
        print("❤️Parrot❤️ : \(text)")
    }
    
    static func info(_ message: String = "") {
        print("💚Parrot💚 : \(message)")
    }
    
    static func debug(_ message: String = "", file: String = #file, function: String = #function, line: Int = #line) {
        var text = description(function: function, file: file, line: line)
        text += " : \(message)"
        print("💙Parrot💙 : \(text)")
    }
    
    // Private helpers
    private static func description(function: String, file: String, line: Int) -> String {
        var text = ""
        if let pathElement = file.components(separatedBy: "/").last {
            text += "\(pathElement)"
        }
        text += " [\(line)]"
        text += " \(name(fromFunctionString: function))"
        return text
    }
    
    private static func name(fromFunctionString string: String) -> String {
        if let index = string.index(of: "(") {
            return "\(String(string[..<index]))()"
        }
        return string
    }
    
}

