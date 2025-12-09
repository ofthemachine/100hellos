# NASM x86_64 Fraglet Guide

## Language Version
NASM 2.x (x86_64 assembly)

## Execution Model
- Assembly language that must be assembled and linked
- Code is assembled with `nasm -felf64`, then linked with `ld`
- Executes as a native x86_64 Linux binary
- Uses Linux system calls directly (syscall instruction)

## Key Characteristics
- Low-level system programming
- Direct access to CPU registers (rax, rdi, rsi, rdx, etc.)
- Linux system call interface
- Manual memory management
- Case-sensitive
- Indentation is preserved from the injection point

## Fragment Authoring
Fragments should be valid x86_64 NASM assembly instructions. They are injected into the `_start` section, replacing the code between the BEGIN_FRAGLET and END_FRAGLET markers. The fragment code will be assembled, linked, and executed.

## System Calls
Common Linux x86_64 system calls:
- **Write (1)**: `mov rax, 1; mov rdi, 1; mov rsi, address; mov rdx, length; syscall`
- **Exit (60)**: `mov rax, 60; mov rdi, exit_code; syscall`
- **Read (0)**: `mov rax, 0; mov rdi, 0; mov rsi, buffer; mov rdx, length; syscall`

## Registers
- **rax**: System call number / return value
- **rdi**: First argument (file descriptor, exit code)
- **rsi**: Second argument (buffer address)
- **rdx**: Third argument (buffer length)
- **rcx, r8, r9**: Additional arguments
- **r10, r11**: Temporary (may be clobbered by syscall)

## Available Data
The `message` label in the `.data` section is available:
```asm
message:  db        "Hello World!", 10      ; 13 bytes total
```

## Common Patterns
- System call: `mov rax, <syscall_num>; mov rdi, <arg1>; mov rsi, <arg2>; mov rdx, <arg3>; syscall`
- Write to stdout: `mov rax, 1; mov rdi, 1; mov rsi, message; mov rdx, 13; syscall`
- Exit program: `mov rax, 60; xor rdi, rdi; syscall` (exit code 0)
- Exit with code: `mov rax, 60; mov rdi, <code>; syscall`

## Examples
```asm
; Basic write to stdout and exit
mov       rax, 1                  ; system call for write
mov       rdi, 1                  ; file handle 1 is stdout
mov       rsi, message            ; address of string to output
mov       rdx, 13                 ; number of bytes
syscall                           ; invoke operating system to do the write
mov       rax, 60                 ; system call for exit
xor       rdi, rdi                ; exit code 0
syscall                           ; invoke operating system to exit

; Exit with custom exit code
mov       rax, 60                 ; system call for exit
mov       rdi, 42                 ; exit code 42
syscall

; Minimal exit (no output)
mov       rax, 60
mov       rdi, 0
syscall
```

## Caveats
- Fragments must be valid x86_64 NASM assembly that assembles and links without errors
- Must end with an exit system call (mov rax, 60; syscall) or program will crash
- System call numbers are x86_64 Linux specific
- Register usage must follow x86_64 calling conventions
- The `message` label is available in the .data section (13 bytes: "Hello World!" + newline)
- Assembly and linking happen fresh each time, so errors will fail execution
- Remember that this is raw assembly - no safety checks or error handling

