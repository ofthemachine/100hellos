# Ruby Container Usage

This container runs Ruby code from the `/code` directory and injects fragments at the `MAIN` marker inside `code/hello-world.rb`.

## Default Behavior

Running the container without overrides executes the bundled fragment, which prints `Hello World!`.

## Fragment Injection

Provide your own Ruby code by mounting a fragment file at runtime:

```bash
# Create a fragment
cat <<'FRAGMENT' > my-ruby-fragment.rb
puts "Custom message!"
FRAGMENT

# Run with the custom fragment
docker run --rm -v $(pwd)/my-ruby-fragment.rb:/code-fragments/MAIN 100hellos/ruby:local
```

## Fragment Format

- Write valid Ruby statements or expressions.
- The fragment replaces the `MAIN` marker inside `code/hello-world.rb`.
- Indentation follows the whitespace on the `MAIN` line automatically.

## File Overlay

Mount a directory of fragments to overlay multiple files into `/code` before execution:

```bash
docker run --rm -v $(pwd)/my-ruby-src:/code-fragments 100hellos/ruby:local
```

## Documentation Commands

Display this guide or the agent help from inside the container:

```bash
docker run --rm 100hellos/ruby:local how-to
docker run --rm 100hellos/ruby:local agent-help
```
