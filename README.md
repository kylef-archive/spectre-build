# spectre-build

Command line tool to build and run tests written using the [Spectre](https://github.com/kylef/Spectre) Swift BDD testing framework.

## Usage

Add the spectre-build dependency to your SPM test dependencies in Package.swift:

```swift
import PackageDescription

let package = Package(
  name: "Person",
  testDependencies: [
    .Package(url: "https://github.com/kylef/spectre-build.git", majorVersion: 0),
  ]
)
```

### Test Files

Create some tests, and place them into the "Tests" directory:

##### `Tests/HTTPParserSpec.swift`

```swift
import Spectre
import Person

func describePerson() {
  describe("a person") {
    let person = Person(name: "Kyle")

    $0.it("has a name") {
      try expect(person.name) == "Kyle"
    }

    $0.it("returns the name as description") {
      try expect(person.description) == "Kyle"
    }
  }
}
```

##### `Tests/main.swift`

```swift
describePerson()
```

### Build & Run

Then simply build and run your tests:

```shell
$ swift build
$ .build/debug/spectre-build
-> a person
  -> has a name
  -> returns the name as description

2 passes and 0 failures
```
