# Befunge-93 Fraglet Guide

## Language Version
Befunge-93 (TBC — Tim's Befunge Compiler: transpile to C, then gcc)

## Execution Model
- Your fragment is the **entire program** (whole-file replacement). The playfield is 80×25; the instruction pointer starts at (0,0) moving right.
- Code is compiled via `tbc` to C, then built and run.

## Key Characteristics
- Two-dimensional: instructions on a grid; execution can go left, right, up, down.
- Stack-based (Forth-like).
- Commands include: `0-9` (push), `+ - * / %`, `!` (not), `` ` `` (greater-than), `> < ^ v` (direction), `_ |` (conditional direction), `"` (string mode), `: \ $` (dup, swap, pop), `. ,` (output number / ASCII), `#` (skip), `g p` (get/put cell), `& ~` (input number / character), `@` (end).

## Fragment Authoring
Write a complete Befunge-93 program. The entire file is your program; there is no template wrapper. Keep the playfield in mind (80 columns × 25 rows). Use `@` to end the program.

## Stdin
- **`~`** — Read one character from stdin; push its ASCII value. On EOF, push -1.
- **`&`** — Read an integer from stdin and push it.

- **Single character:** `~,@` — read one character with `~`, output with `,`, end with `@`. Works everywhere.
- **Cat (echo all stdin):** e.g. one line `~:0` then `#@_,<` — read with `~`, stop on EOF (-1), else output with `,` and loop. Interpreter/compiler behavior may vary; the one-char form above is the most portable.

## Command-line arguments
Befunge-93 has no notion of command-line arguments; input is via stdin only (e.g. `~` and `&`).

## Common Patterns
- **Hello World:** Push ASCII values in string mode, then output with `,` in a loop (e.g. `64+"!dlroW olleH">:v` and `^,_@`).
- **Cat (echo stdin):** e.g. `~:0` then `#@_,<` on one line (backtick `` ` `` is the greater-than test).
- **Output number:** `.` pops and prints as integer (with space).
- **Output character:** `,` pops and prints as ASCII.

## Caveats
- Playfield is 80×25; long lines or many lines get truncated.
- Your fragment replaces the whole file — no markers, no template.
- Compilation (tbc + gcc) runs on every execution; build errors appear on stderr.
