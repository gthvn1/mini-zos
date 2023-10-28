import fs from 'fs'

const bytes = fs.readFileSync('./fibonacci.wasm');

const instance = await WebAssembly
                    .instantiate(new Uint8Array(bytes))
                    .then(res => res.instance.exports);

for (let i = 0; i < 50; i++) {
  console.log("f(" + i + ") = " + instance.fibo(BigInt(i)))
}
