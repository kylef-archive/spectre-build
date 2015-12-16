import Commander
import PathKit

func build() throws {
  let libraries = Path.glob(".build/debug/*.a")
  let testSources = Path.glob("Tests/*.swift").map { $0.description }

  let arguments = [
    "-o", ".build/debug/spectre-runner",
    "-I.build/debug",
  ] + libraries.map { "-Xlinker \($0)" } + testSources

  try invoke("swiftc", arguments)
}

func runTests() throws {
  try invoke(".build/debug/spectre-runner", [])
}

command {
  try build()
  try runTests()
}.run()
