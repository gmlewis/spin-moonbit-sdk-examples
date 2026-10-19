# gmlewis/spin-moonbit-sdk-examples

Examples for the experimental Spin SDK for the MoonBit programming language.

Each directory contains a README with additional instructions. Dependencies are
fetched automatically by `moon build`; run `moon update` to refresh them, and
`bump-version.sh` to move every example to the latest published
`spin-moonbit-sdk`.

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
  moon build --target wasm --release && \
  wasm-tools component embed .mooncakes/gmlewis/spin-moonbit-sdk/wit ./_build/wasm/release/build/hello-world.wasm -o hello-world.wasm --encoding utf16 -w http-trigger && \
  wasm-tools component new hello-world.wasm -o hello-world.wasm
  """
watch = ["**/*.mbt", "moon.mod", "moon.pkg"]
```

The wit directory is referenced from the .mooncakes directory, and `moon`
writes release artifacts to `_build/wasm/release/build/<name>.wasm`, so
`--release` must be passed explicitly.

## Status

The code has been updated to support compiler:

```bash
$ moon version --all
moon 0.1.20261016 (1af328f 2026-10-16) ~/.moon/bin/moon
moonc v0.10.16+b1a0e846e (2026-10-16) ~/.moon/bin/moonc
moonrun 0.1.20261016 (1af328f 2026-10-16) ~/.moon/bin/moonrun

```
