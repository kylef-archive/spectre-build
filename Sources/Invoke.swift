#if os(Linux)
import Glibc
#else
import Darwin
#endif


struct InvocationError : ErrorType {
  init(command:String, arguments:[String], code:Int32) {

  }
}

/// Invoke a subprocess
func invoke(command:String, _ arguments:[String]) throws {
  // TODO - Properly invoke subprocess with exec, arguments are not escaped
  let args = arguments.joinWithSeparator(" ")

  fflush(stdout)
  let code = system("\(command) \(args)")

  if code != 0 {
    throw InvocationError(command: command, arguments: arguments, code: code)
  }
}
