# WebAssembly Text (WAT) Fraglet Guide

## Language Version
WebAssembly Text Format (WAT) 1.0
Executed via wasmtime (Alpine edge testing repository)

## Execution Model
- Text format for WebAssembly (WASM)
- Compiled and executed by wasmtime runtime
- Uses WASI (WebAssembly System Interface) for I/O
- Stack-based virtual machine

## Key Characteristics
- S-expression syntax (parentheses-based)
- Stack-based operations (push/pop)
- Linear memory model
- Type system: i32, i64, f32, f64
- Case-sensitive
- Comments: `;;` for single-line

## Fragment Authoring
Write valid WAT module-level code. Your fragment should contain:
- Data segments at module level (not inside functions)
- The `$main` function with `(export "_start")`
- WASI imports (`$proc_exit`, `$fd_write`)
- Memory setup (1 page, exported as "memory")
- Stack-based execution model

**Important**: Your fragment must include:
- Data segment(s) at module level for strings
- Function definition: `(func $main (export "_start") ...)`
- iovec structure setup for fd_write
- fd_write call
- proc_exit call

## Available Imports
WASI snapshot preview1 imports are available:
- `wasi_snapshot_preview1.proc_exit` - Exit with status code
- `wasi_snapshot_preview1.fd_write` - Write to file descriptor

## Memory Layout
- Memory is 1 page (64KB) and exported as "memory"
- String data can be placed at any offset
- iovec structure: 8 bytes (4 bytes buf pointer, 4 bytes length)

## Common Patterns

### Writing a String
```wat
;; Store string data in memory
(data (i32.const 0) "Hello, World!\n")

;; Set up iovec at offset 16
(i32.store (i32.const 16) (i32.const 0))  ;; buf pointer
(i32.store (i32.const 20) (i32.const 14)) ;; length (14 bytes)

;; Call fd_write(stdout=1, iovec_ptr=16, iovec_count=1, result_ptr=24)
(call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
drop

;; Exit
(call $proc_exit (i32.const 0))
```

### Multiple Strings
```wat
;; First string at offset 0
(data (i32.const 0) "First line\n")
;; Second string at offset 11
(data (i32.const 11) "Second line\n")

;; Write first string
(i32.store (i32.const 16) (i32.const 0))
(i32.store (i32.const 20) (i32.const 11))
(call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
drop

;; Write second string
(i32.store (i32.const 16) (i32.const 11))
(i32.store (i32.const 20) (i32.const 12))
(call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
drop

(call $proc_exit (i32.const 0))
```

### Arithmetic Operations
```wat
;; Store result string
(data (i32.const 0) "Sum: 15\n")

;; Set up iovec
(i32.store (i32.const 16) (i32.const 0))
(i32.store (i32.const 20) (i32.const 8))
(call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
drop

(call $proc_exit (i32.const 0))
```

## Examples

### Example 1: Simple Output
```wat
;; Store string
(data (i32.const 0) "Hello from fragment!\n")

;; WASI entry point
(func $main (export "_start")
  ;; Set up iovec
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 20))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
```

### Example 2: Multiple Lines
```wat
;; Store strings
(data (i32.const 0) "Line 1\n")
(data (i32.const 7) "Line 2\n")

;; WASI entry point
(func $main (export "_start")
  ;; Write first line
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 7))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Write second line
  (i32.store (i32.const 16) (i32.const 7))
  (i32.store (i32.const 20) (i32.const 7))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
```

### Example 3: Longer Message
```wat
;; Store longer string
(data (i32.const 0) "This is a longer message with more content!\n")

;; WASI entry point
(func $main (export "_start")
  ;; Set up iovec
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 45))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
```

## Caveats and Limitations

- **Memory offsets**: Be careful with memory offsets - strings must not overlap
- **String lengths**: Count bytes carefully, including newline characters (`\n` = 1 byte)
- **iovec structure**: Must be 8 bytes (4-byte pointer + 4-byte length)
- **Stack operations**: WAT is stack-based - operations push/pop from the stack
- **Type system**: All operations are strongly typed (i32, i64, f32, f64)
- **WASI imports**: Only proc_exit and fd_write are available
- **No dynamic allocation**: Memory size is fixed at module load time
- **Data segments**: Must be placed at compile-time offsets

## Tips

- Use `;;` comments liberally to document your code
- Calculate string lengths carefully (including newlines)
- Test memory offsets to avoid overlaps
- The iovec structure is at offset 16, result storage at offset 24
- Always end with `proc_exit` to cleanly terminate
