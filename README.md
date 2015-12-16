# spectre-build

Command line tool to build and run Spectre tests.

## Usage

Add the spectre-build dependency to your SPM Package.swift:

```swift
import PackageDescription


let package = Package(
  name: "Curassow",
  dependencies: [
    .Package(url: "https://github.com/kylef/spectre-build.git", majorVersion: 0),
  ]
)
```

**NOTE**: *SPM does not yet offer proper test dependencies, but this is coming in [#74](https://github.com/apple/swift-package-manager/pull/74).*

### Test Files

Create some tests, and place them into the "Tests" directory:

##### `Tests/HTTPParserSpec.swift`

```swift
import Spectre


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
-> HTTPParser
  -> can parse a HTTP request body
  -> reads the message body when Content-Length is present
  -> throws an error when the client uses bad HTTP syntax
  -> throws an error when the client uses a bad HTTP version
  -> throws an error when the client disconnects before sending an HTTP request
  -> throws an error when the client disconnects before sending the entire message body

6 passes and 0 failures
```
