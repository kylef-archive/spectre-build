import Commander
import PathKit

private func target_specific_arguments() throws -> [String] {
#if os(OSX)
  return [
    "-sdk",
    "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk",
    "-target", "x86_64-apple-macosx10.10",
    "-Xlinker", "-all_load",
  ]
#elseif os(Linux)
  return ["-Xlinker", "--no-whole-archive", "-lswiftGlibc"]
#else
  return []
#endif
}

func build() throws {
  let libraries = Path.glob(".build/debug/*.a")
  let testSources = (Path.glob("Tests/*.swift") + Path.glob("Tests/*/*.swift")).map { $0.description }

  let arguments = try target_specific_arguments() + [
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
