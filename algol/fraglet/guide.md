# ALGOL 60 (jff-algol) Fraglet Guide

## Code format

- **Full block.** Your fragment is a complete `begin` … `end;` block. You can write any number of declarations and statements.

## Minimal fragment (copy and adapt)

```algol
begin
  outstring (1, "Hello from fragment!\n");
end;
```

## Language / runtime

- ALGOL 60 via [jff-algol](https://github.com/JvanKatwijk/algol-60-compiler) (Algol 60 → C translator, then compile and run).
- Channel 0 = standard input; channel 1 = standard output.

## Output and input (prelude procedures)

- **outstring (1, "text");** — print string to stdout.
- **outinteger (1, n);** — print integer.
- **outreal (1, x);** — print real.
- **newline (1);** — newline.
- **space (1);** — space.
- **ininteger (0, n);** — read one integer from stdin (channel 0) into variable `n`; must be declared integer.
- **inreal (0, x);** — read one real from stdin into variable `x`.

Variables used with `ininteger`/`inreal` must be declared (e.g. `integer n;` or `real x;`) and passed by value in the prelude sense (the procedure assigns into them).

## Common patterns

- Print: `begin` / `outstring (1, "message\n");` / `end;`
- Declare and print: `begin` / `integer n; n := 42; outinteger (1, n); newline (1);` / `end;`
- Read and echo: `begin` / `integer n; ininteger(0, n); outinteger(1, n); newline(1);` / `end;`
- Arithmetic: use `+`, `-`, `*`, `/`; assign with `:=`.

## Caveats

- Stdin works when piping input. The generated C program has no `argc`/`argv` exposure; command-line arguments are not available from ALGOL.
- Statements end with `;`. Variable names and keywords are case-insensitive in ALGOL 60; jff-algol follows that.
