
import Foundation

struct Constants {
    static let mockableToken = "@@parrot-mock"
}

struct File {
    let url: URL
    let lines: [String]
}

struct MockEntity {
    let file: File
    let headers: [String]
    let type: String
    let name: String
    let protocolName: String
}

struct ProtocolEntity {
    let file: File
    let name: String
    let variables: [Variable]
    let functions: [Function]
}

struct Variable: Hashable {
    let name: String
    let type: String
    let defaultReturnValue: String?
    let isGetSet: Bool
    let isWeak: Bool
}

struct Function: Hashable {
    let name: String
    let baseStubMemberName: String
    let returnType: String?
    let arguments: [Argument]
    let defaultReturnValue: String?
    
    init(name: String, baseStubMemberName: String? = nil, returnType: String?, arguments: [Argument], defaultReturnValue: String?) {
        self.name = name
        self.baseStubMemberName = baseStubMemberName ?? name
        self.returnType = returnType
        self.arguments = arguments
        self.defaultReturnValue = defaultReturnValue
    }
}

struct Argument: Hashable {
    let name: String
    let type: String
    let externalName: String?
}
