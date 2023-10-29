# A little taste of web assembly

- To complile web assembly text file (wat) into binary you need to use `wat2wasm`
  from the [web assembly toolkit](https://github.com/WebAssembly/wabt).
    - Just run ``wat2wasm fibonacci.wat -o fibonacci.wasm`

- To test the easiest way is to create a javascript file to call and execute your wasm
  file. The *package.json* indicates dependences. We are using `pnpm` to manage node
  module. Install packages with `pnpm install` and if everything is ok you should be able
  to run `pnpm test`.
