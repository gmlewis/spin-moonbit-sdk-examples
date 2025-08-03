# gmlewis/spin-moonbit-sdk-examples

Examples for the experimental Spin SDK for the MoonBit programming language.

Each directory contains a README with additional instructions. It is required to install dependencies via `moon install`.

## Templates

If you wish to install MoonBit templates for the [Spin CLI tool] (v3), you can run:

```bash
spin templates install --git https://github.com/gmlewis/spin-moonbit-sdk
```

The templates are located in the `templates` folder.

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
moon 0.1.20250724 (2797252 2025-07-24) ~/.moon/bin/moon
moonc v0.6.22 ~/.moon/bin/moonc
moonrun 0.1.20250724 (2797252 2025-07-24) ~/.moon/bin/moonrun
```
