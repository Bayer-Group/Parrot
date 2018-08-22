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
