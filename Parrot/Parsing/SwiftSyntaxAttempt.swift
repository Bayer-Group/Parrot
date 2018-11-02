import SwiftSyntax

func swiftSyntax(file: File) {
    guard let sourceFileSyntax = try? SyntaxTreeParser.parse(file.url) else {
        Log.error("failed to parse \(file.url)")
        return
    }
    
    print(sourceFileSyntax.statements)
}
