# Lua Container Usage

This image runs Lua 5.4 on top of the 001-base entrypoint. The default
program loads `hello-world.lua`, injects the fragment at the `MAIN` marker,
and executes the `main()` function.

## Default Behavior

Running the container with no extra mounts prints "Hello World" using the
fragment shipped in `files/code-fragments/MAIN`.

```bash
docker run --rm 100hellos/lua:local
```

## Fragment Injection

Override the default behavior by mounting your own fragment file at
`/code-fragments/MAIN`:

```bash
echo 'print("Injected fragment")' > my-fragment.lua

docker run --rm \
  -v $(pwd)/my-fragment.lua:/code-fragments/MAIN \
  100hellos/lua:local
```

The fragment is spliced inside the `main()` function, and indentation follows
the placeholder's leading spaces.

## File Overlay

To add additional source files, mount a directory at `/code-fragments`. Every
file except `MAIN` gets copied into `/code` before execution, letting you ship
support modules or data files.

```bash
docker run --rm \
  -v $(pwd)/my-fragments:/code-fragments \
  100hellos/lua:local
```

## Documentation Commands

```bash
# Display this guide
docker run --rm 100hellos/lua:local how-to

# Show agent-facing notes
docker run --rm 100hellos/lua:local agent-help
```
