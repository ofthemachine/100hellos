# Python Container Usage

This container supports fragment injection for running Python code fragments.

## Default Behavior

By default, the container runs a "Hello World!" program using the shipped fragment.

## Fragment Injection

You can inject custom Python code by mounting a fragment file:

```bash
# Create a fragment file
echo 'print("Custom message!")' > my-fragment.txt

# Run with mounted fragment
docker run --rm -v $(pwd)/my-fragment.txt:/code-fragments/MAIN 100hellos/python:local
```

## Fragment Format

- The fragment should contain valid Python code
- It will be injected at the `MAIN` marker in the template
- Indentation is automatically preserved based on the marker's position
- The fragment replaces the `MAIN` marker in `code/hello-world.py`

## File Overlay

You can also overlay additional files into the `/code` directory:

```bash
docker run --rm -v $(pwd)/my-files:/code-fragments 100hellos/python:local
```

All files in the mounted directory will be copied to `/code` before execution.

## How-to Command

View this documentation from within the container:

```bash
docker run --rm 100hellos/python:local how-to
```

