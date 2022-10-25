// import Foundation
// import JavaScriptKit

// print("Hello, world!")
// let document = JSObject.global.document
// let _: JSClosure = .init { _ in
//     return document
// }

print("top level")

@_cdecl("wasm_main")
func wasm_main() {
    print("main called")
}
