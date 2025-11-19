# R Container Usage

This container runs the system `Rscript` interpreter and supports fragment injection so you can evaluate arbitrary R code without rebuilding the image.

## Default Behavior

The entrypoint executes `/code/hello-world.r`, which sources the default fragment and prints "Hello World!".

## Fragment Injection

Mount a fragment file at `/code-fragments/MAIN` to replace the default code:

```bash
cat <<'FRAG' > my-fragment.R
print("Hi from a mounted fragment")
FRAG

docker run --rm -v $(pwd)/my-fragment.R:/code-fragments/MAIN 100hellos/r-project:local
```

### Fragment Rules
- Content is injected exactly where the `MAIN` marker sits in `hello-world.r`
- No function definitions or wrappers are required; add them yourself if needed
- Indentation follows the marker's indentation (none by default)

## File Overlay

Need helper scripts or data files? Mount a directory to `/code-fragments` and include additional files alongside `MAIN`. The base image copies everything (other than `MAIN`) into `/code` before execution.

```bash
docker run --rm -v $(pwd)/my-code:/code-fragments 100hellos/r-project:local
```

## Documentation Commands

Display this guide:
```bash
docker run --rm 100hellos/r-project:local how-to
```

Show the agent-facing primer:
```bash
docker run --rm 100hellos/r-project:local agent-help
```
