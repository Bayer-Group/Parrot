protocol OverloadedFunctionExample {
    func answers(for id: String)
    func answers(in ids: [String])
    func answers(for id: String, archived: Bool)
    func answers(for id: String, archived: Bool) -> Int
    var answers: [String] { get }
}
