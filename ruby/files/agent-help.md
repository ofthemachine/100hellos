# Ruby Language Guide

## Version
- Alpine `ruby` / `ruby-dev` package (Ruby 3.3.x at build time)

## Execution Context
- **Interpreter**: `/usr/bin/ruby`
- **Shebang**: `#!/usr/bin/env ruby`
- **Execution Model**: Interpreted; executes the template script top-to-bottom
- **Entry Behavior**: A bootstrap script calls `MAIN`, so any injected fragment runs immediately at top level

## Fragment Injection Primer
- Provide plain Ruby statements or method definitions; the runtime splices your fragment into the bootstrap script and executes it immediately at top level.
- Example fragment:
  ```ruby
  puts "Hello from a fragment"
  count = [1, 2, 3].sum
  puts "Total: #{count}"
  ```
- Top-level expressions execute in order. Define helpers before you use them.
- Indentation mirrors the placeholder line (no indentation by default). Keep fragment indentation consistent if you include blocks.
- Use standard `puts` / `print` for output; the runtime captures stdout/stderr automatically.

## Language Notes
- Everything is an object; common literal types (String, Array, Hash) expose rich methods.
- Strings support interpolation with `#{expr}` inside double quotes.
- Blocks work with `do ... end` or `{ ... }`; pick `do`/`end` for multi-line logic.
- No implicit `main` function—top-level Ruby code runs as soon as it is parsed, which matches how fragments are injected.
