# Prolog Container Usage

This container supports fragment injection for running Prolog code fragments.

## Default Behavior

By default, the container runs a "Hello World!" program using the shipped fragment.

## Fragment Injection

You can inject custom Prolog code by mounting a fragment file:

```bash
# Create a fragment file
echo 'write("Custom message!").' > my-fragment.txt

# Run with mounted fragment
docker run --rm -v $(pwd)/my-fragment.txt:/code-fragments/MAIN 100hellos/prolog:local
```

## Fragment Format

- The fragment should contain valid Prolog code
- It will be injected at the `MAIN` marker in the template
- The fragment replaces the `MAIN` marker in `code/hello-world.pl`
- Prolog statements should end with a period (`.`)

## File Overlay

You can also overlay additional files into the `/code` directory:

```bash
docker run --rm -v $(pwd)/my-files:/code-fragments 100hellos/prolog:local
```

All files in the mounted directory will be copied to `/code` before execution.

## How-to Command

View this documentation from within the container:

```bash
docker run --rm 100hellos/prolog:local how-to
```

