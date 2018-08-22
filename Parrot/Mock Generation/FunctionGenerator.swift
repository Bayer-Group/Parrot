
import Foundation

extension Function {
    
    var mockImplementationLines: [String] {
        
        var lines = [String]()
        
        var declaration = "func \(name)("
        if arguments.count > 0 {
            declaration += arguments.map {
                let externalName = $0.externalName != nil ? "\($0.externalName!) " : ""
                return "\(externalName)\($0.name): \($0.type)"
            }.joined(separator: ", ")
        }
        declaration += ")"
        if let type = returnType { declaration += " -> \(type)" }

        lines.append("\(declaration) {")
        lines.append("stub.\(baseStubMemberName)CallCount += 1")
        
        if arguments.count > 0 {
            var calledWithMockImplementation = "stub.\(baseStubMemberName)CalledWith.append("
            if arguments.count > 1 {
                let argumentsToAppend = arguments.map { $0.name }
                calledWithMockImplementation.append("(\(argumentsToAppend.joined(separator: ", ")))")
            } else if let oneArgument = arguments.element(at: 0) {
                calledWithMockImplementation.append(oneArgument.name)
            }
            calledWithMockImplementation.append(")")
            lines.append(calledWithMockImplementation)
        }
        
        if let _ = returnType { lines.append("return stub.\(baseStubMemberName)ShouldReturn") }
        lines.append("}")
        
        return lines
    }
    
    var stubEntries: [String] {
        var entries = [String]()
        entries.append("var \(baseStubMemberName)CallCount = 0")

        if arguments.count > 1 {
            var calledWithStub = "var \(baseStubMemberName)CalledWith = [("
            let calledWithTypes = arguments.map { "\($0.name): \(removeEscapingAnnotation(from: $0.type))" }
            calledWithStub.append("\(calledWithTypes.joined(separator: ", ")))]()")
            entries.append(calledWithStub)
        } else if let oneArgument = arguments.element(at: 0) {
            entries.append("var \(baseStubMemberName)CalledWith = [\(removeEscapingAnnotation(from: oneArgument.type))]()")
        }
        
        if let type = returnType {
            let returnValue = defaultReturnValue ?? "<#Default return value#>"
            entries.append("var \(baseStubMemberName)ShouldReturn: \(type) = \(returnValue)")
        }
        return entries
    }
    
    private func removeEscapingAnnotation(from type: String) -> String {
        return type.replacingOccurrences(of: "@escaping", with: "").trimmed
    }
}

