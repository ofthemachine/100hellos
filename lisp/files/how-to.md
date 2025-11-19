# Lisp Container Usage

This container runs SBCL and supports fragment injection for evaluating Common Lisp code.

## Default Behavior

By default, the container loads `hello-world.el`, calls `main`, and prints "Hello World!" using the bundled fragment.

## Fragment Injection

You can inject custom Lisp code by mounting a fragment file:

```bash
# Create a fragment file
echo '(format t "Hi from injected code!~%")' > my-fragment.lisp

# Run with mounted fragment
docker run --rm -v $(pwd)/my-fragment.lisp:/code-fragments/MAIN 100hellos/lisp:local
```

## Fragment Format

- The fragment should contain valid Common Lisp expressions
- It is injected inside the body of the `main` function
- Indentation is preserved from the `MAIN` placeholder
- You can define helper functions or run arbitrary code from there

## File Overlay

To overlay additional files into `/code`, mount a directory at `/code-fragments`:

```bash
docker run --rm -v $(pwd)/my-files:/code-fragments 100hellos/lisp:local
```

Any files in `my-files` (except `MAIN`) will be copied into `/code` before execution, letting you add libraries or scripts.

## Documentation Commands

Display this guide:

```bash
docker run --rm 100hellos/lisp:local how-to
```

Show the agent-focused language primer:

```bash
docker run --rm 100hellos/lisp:local agent-help
```
