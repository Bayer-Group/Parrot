import Foundation

func main() {
    
    // Read paths to implementation and test directory paths from command line args
    let args = ProcessInfo.processInfo.arguments
    guard let implementationDirectoryPath = args.element(at: 1), let testDirectoryPath = args.element(at: 2) else {
        Log.error("Error parsing required command line arguments")
        displayUsage()
        exit(1)
    }
    let implementationDirectoryUrl = URL(fileURLWithPath: implementationDirectoryPath)
    let testDirectoryUrl = URL(fileURLWithPath: testDirectoryPath)

    // Find swift files in those directories and read their contents into File structs
    guard
        FileManager.default.directoryExists(atUrl: implementationDirectoryUrl),
        FileManager.default.directoryExists(atUrl: testDirectoryUrl),
        let implementationFileUrls = FileOperations.findSwiftFilesRecursively(in: implementationDirectoryUrl),
        let testFileUrls = FileOperations.findSwiftFilesRecursively(in: testDirectoryUrl),
        let implementationFiles = FileOperations.readFiles(at: implementationFileUrls),
        let testFiles = FileOperations.readFiles(at: testFileUrls)
    else {
        displayUsage()
        exit(1)
    }
    
    if let customTypesExamplesFile = implementationFiles.first(where:  { $0.url.absoluteString.contains("CustomTypesExamples") }) {
//        swiftSyntax(file: customTypesExamplesFile)
        sourceKittenAttempt(file: customTypesExamplesFile)
    }
    
    let mockEntities = MockParser.mockEntities(in: testFiles)
    if mockEntities.isEmpty {
        Log.info("No mockable entities were found")
        exit(0)
    }

    // TODO: Possibly handle error logs displayed when this isn't implemented more gracefully
    let defaultsFile = FileOperations.readFiles(at: [testDirectoryUrl.appendingPathComponent("parrot-defaults.swift")])?.first
    let defaultsTable = DefaultsParser.defaultsTable(from: defaultsFile?.lines ?? [])
    
    for mockEntity in mockEntities {
        
        guard let protocolEntity = ProtocolParser.protocolEntity(with: mockEntity.protocolName, in: implementationFiles, defaultsTable: defaultsTable) else {
            Log.error("Error finding 'protocol \(mockEntity.protocolName)' in implementation files for mock: '\(mockEntity.name)'")
            continue
        }
        
        let newMockContents = MockGenerator.fileContents(from: protocolEntity, for: mockEntity)

        if FileOperations.write(contents: newMockContents, url: mockEntity.file.url) {
            Log.info("Updated mock '\(mockEntity.name)' in '\(mockEntity.file.url.path)'")
        }
        
    }
    
    Log.info("Finished!")
}

func displayUsage() {
    print("💚Parrot💚  Usage:")
    print("`parrot <implementationPath> <testPath>`")
    print("   <implementationPath>  is the path to the directory containing your source/implementation files")
    print("   <testPath>  is the path to the directory containing your test files")
    print("   Provide parrot-defaults.swift in base of test directory to support custom type defaults")
}

main()
