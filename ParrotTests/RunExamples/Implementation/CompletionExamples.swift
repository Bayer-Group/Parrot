protocol ExampleDataFetcher: class {
    func fetch(completion: @escaping () -> ())
}

protocol ExampleDataFetcherWithOtherParameter: class {
    func fetch(options: Bool, completion: @escaping () -> ())
}

protocol ExampleDataFetcherWithCompletionParameter: class {
    func fetch(completion: @escaping ([String]) -> ())
}

protocol ExampleDataFetcherWithMultipleCOmpletionParameters: class {
    func fetch(completion: @escaping (String?, String?) -> ())
}
