# APL (GNU APL) Fraglet Guide

## Code format

- **Single expression or multiple lines.** Your fragment replaces the default expression. A quoted string is printed when evaluated. You can use multiple statements (one per line).

## Minimal fragment (copy and adapt)

```apl
'Hello from fragment!'
```

## Language / runtime

- GNU APL 1.8, run with `apl --OFF -s -f script.apl`. Script mode reads the file and exits.

## Output and input

- **Quoted string** — e.g. `'text'` prints that text.
- **⎕ARG** — vector of command-line arguments (options after `--` when invoking the interpreter).
- **⎕INP B** — (GNU APL) reads lines from stdin until a line matching pattern B; returns the lines read. For one line, use a sentinel line (e.g. `⊃⎕INP '%%'` and pipe `42\n%%`).

## Common patterns

- Print: `'message'`
- Print with newline: `'message',⎕TC[2]` or multiple expressions.
- Args: `(⎕ARG ⍳ ⊂'--') ↓ ⎕ARG` gives application args; index into or display as needed.
- Stdin (one line via sentinel): e.g. `line ← ⊃⎕INP '%%'` then use `line`.

## Caveats

- Command-line arguments must be passed after `--` to the interpreter so they appear in ⎕ARG (the execution script does this).
- ⎕INP reads until a pattern; for simple “one line” input, use a sentinel line in the piped input.
