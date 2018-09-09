## Installation:
### Adding to a Project 
#### Command Line(assuming in base of project directory):
`git submodule add git@github.com:MonsantoCo/Parrot.git`

`cd Parrot`

`git submodule update --init`

- Open the Parrot xcode project and select a signing certificate (the next step will fail if a valid signing certificate is not selected)

`xcodebuild`


#### Open project
- Go to Project File
- Select the target for your unit tests
- Select 'Build Phases'
- Select '+' -> 'New Run Script'
- Drag the run script to be before the 'Compile Sources' step, but after the 'Target Dependencies' step
- Example Script (Bash):

```
PARROT=$PROJECT_DIR/Parrot/build/Release/Parrot
SOURCE=$PROJECT_DIR/[YourAppDirectoryName]
TESTS=$PROJECT_DIR/[YourAppTestDirectoryName]

if [ -f "$PARROT" ]; then
    echo "💚 Running Parrot - SQUAAWWWKKKK 💚"
    $PARROT $SOURCE $TESTS || exit 0
else
    echo "⚠️ xcodebuild gitsubmodule Parrot to enable mock generation"
fi
```

## Usage:
- Add the annotation `//@@parrot-mock`above any class definition conforming to a protocol somewhere in the project (protocols defined inside frameworks will not be found yet)
- Example:
```
@testable import [AppName] // All lines above the annotation will be preserved

//@@parrot-mock
class MockClass: ClassProtocol {

}
```
- When your test target builds, a mock will be generated before compile time

### Non-Basic and Custom Types:
- If you use types like `UUID` or `Date` you'll see that Parrot doesn't know how to generate instantiations for these types or any of your custom classes and structs. It will just leave placeholders in generated mocks. `parrot-defaults.swift` is the solution for telling Parrot how to instantiate types it wouldn't otherwise know how to create.
- Add a file called `parrot-defaults.swift` to the base of your test directory. 
- Each line can teach parrot how to instantiate a type by defining a variable with an explicitly named type and then proceeding to instantiate that type. (e.g. `let parrotUUID: UUID = UUID()`, "let anyCustomType: CustomType = CustomType()")
- Parrot will always check this list first before generating a mock so if you want to override some of the defaults for basics types, you can do that as well. `let newIntDefaultValue: Int = 1` will make all `Int` types instantiate to 1 instead of 0 in your mocks.
- Friendly Reminder: Don't forget to have appropriate import statements both in `parrot-defaults.swift` and your mocks. 
