const { WASI } = require("@wasmer/wasi");
const { default: nodeBindings } = require("@wasmer/wasi/lib/bindings/node");
const fs = require("fs");
const path = require("path");

const wasmFilePath = path.join(__dirname, "..", "..", ".build", "debug", "Hello.wasm");

async function main() {
    const wasi = new WASI({
        args: [wasmFilePath],
        env: {},
        bindings: { ...nodeBindings },
    });

    const wasmBytes = await fs.promises.readFile(wasmFilePath);

    const wasmModule = await WebAssembly.compile(wasmBytes);

    const importObject = { ...wasi.getImports(wasmModule) };

    const instance = await WebAssembly.instantiate(wasmModule, importObject);

    wasi.start(instance);

    console.log("js started");

    instance.exports.wasm_main();
}

if (require.main === module) {
    main();
}
