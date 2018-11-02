import SourceKittenFramework

func sourceKittenAttempt(file: File) {
    guard let skFile = SourceKittenFramework.File(path: file.url.path) else {
        Log.debug("Couldn't read at: \(file.url.absoluteString)")
        return
    }
    
    do {
        //let syntaxMap = try SyntaxMap(file: skFile)

        let structure = try Structure(file: skFile)
        let declaration = skFile.parseDeclaration(structure.dictionary)
        Log.debug(declaration ?? "")
    } catch {
        Log.error(error.localizedDescription)
    }
}
