# spin-moonbit-sdk-examples
Examples for the experimental Spin SDK for the MoonBit programming language.

Each directory contains a README with additional instructions. It is required to install dependencies via `moon install`.

## Hints

When using the `spin-moonbit-sdk` library, it is required to turn the WASM module into a WASM component. To do this, one needs to access the WIT files of the `spin-moonbit-sdk`. They can be accessed from the local `.mooncakes` directory.

Hence the build command in the `spin.toml` files looks like this:

```toml
[component.hello.build]
command = """\
  moon build --target wasm && \
  wasm-tools component embed .mooncakes/gmlewis/spin-moonbit-sdk/wit ./target/wasm/release/build/hello-world.wasm -o hello-world.wasm --encoding utf16 -w http-trigger && \
  wasm-tools component new hello-world.wasm -o hello-world.wasm
  """
watch = ["**/*.mbt"]
```

The wit directory is referenced from the .mooncake directory.

## Status

The code has been updated to support compiler:

```bash
$ moon version --all
moon 0.1.20250618 (722aa08 2025-06-18) ~/.moon/bin/moon
moonc v0.6.18+8382ed77e ~/.moon/bin/moonc
moonrun 0.1.20250618 (722aa08 2025-06-18) ~/.moon/bin/moonrun
```
