# Brainfuck Fraglet Guide

## Language Version
Brainfuck (custom C interpreter)

## Execution Model
- Interpreted via `bf` interpreter (compiled from C)
- Brainfuck code is executed directly
- Standard Brainfuck execution model with tape and pointer

## Key Characteristics
- Minimal instruction set (8 commands)
- Tape-based memory model
- Pointer moves left/right on tape
- Values are 8-bit cells (0-255, wraps around)
- Case-sensitive
- All other characters are ignored (comments)

## Fragment Authoring
Write valid Brainfuck code. Your fragment becomes the script body. The fragment code will be executed by the Brainfuck interpreter.

## Instructions
- `>` - Move pointer right
- `<` - Move pointer left
- `+` - Increment current cell
- `-` - Decrement current cell
- `.` - Output current cell as ASCII character
- `,` - Input character to current cell (reads one byte from stdin)
- `[` - Start loop (if current cell is 0, jump past matching `]`)
- `]` - End loop (if current cell is not 0, jump back to matching `[`)

## Stdin and arguments
- **Stdin**: Use `,` to read one byte at a time. Echo one character: `,.` (read, then output). Echo until EOF: `,[.,]` (loop: read, output while non-zero; EOF typically gives 0).
- **Arguments**: Not supported. Standard Brainfuck has no concept of command-line arguments; the language only has the tape, stdin, and stdout.

## Common Patterns
- Output: `++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.` (prints 'A' = 65)
- Stdin echo (one char): `,.`
- Stdin echo (until EOF): `,[.,]`
- Loop: `[>+<-]` (move value from current cell to next)
- Clear cell: `[-]` (decrement until zero)
- Copy: `[>+>+<<-]>>[<<+>>-]` (copy current cell to next two cells)

## Examples
```brainfuck
# Simple output
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
+++++++++++++++++++++++++++++++++.
```

## Caveats
- Brainfuck is an esoteric language - very verbose for simple operations
- Cell values wrap around (255 + 1 = 0, 0 - 1 = 255)
- Loops must be properly balanced (`[` and `]` must match)
- All non-instruction characters are ignored (useful for comments)
- The tape is effectively infinite in both directions
- Initial cell values are 0

