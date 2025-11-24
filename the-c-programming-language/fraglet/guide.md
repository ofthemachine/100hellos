# C Fraglet Guide

## Language Version
C (GCC compiler, musl libc)

## Execution Model
- Compiled language using GCC
- Code is compiled to a binary, then executed
- Build script compiles `hello-world.c` to `hello` binary, then runs it
- Standard C execution model with `main()` function

## Key Characteristics
- Statically typed
- Case-sensitive
- Requires explicit compilation step
- Uses musl libc (Alpine's C library)

## Fragment Authoring
Fragments should be valid C statements or expressions. They are injected into the `main()` function, replacing the match marker. The fragment code will be compiled and executed.

## Available Headers
The template includes these standard headers:
- `stdio.h` - Input/output (printf, scanf, FILE operations)
- `stdlib.h` - Memory allocation (malloc, free), utilities (atoi, exit)
- `string.h` - String operations (strlen, strcpy, strcmp)
- `stdint.h` - Fixed-width integer types (int32_t, uint64_t)
- `stdbool.h` - Boolean type (bool, true, false)
- `math.h` - Mathematical functions (sin, cos, sqrt, pow)
- `time.h` - Time functions (time, localtime, strftime)
- `ctype.h` - Character classification (isalpha, isdigit, toupper)
- `errno.h` - Error codes (errno, perror)

## Common Patterns
- Print: `printf("message\n");`
- Variables: `int x = 10;`
- Functions: `int add(int a, int b) { return a + b; }`
- Arrays: `int arr[10];`
- Pointers: `int *ptr = &x;`
- Loops: `for (int i = 0; i < 10; i++) { ... }`

## Examples
```c
// Simple output
printf("Hello from fragment!\n");

// Variables and calculations
int a = 5;
int b = 10;
printf("Sum: %d\n", a + b);

// Loops
for (int i = 1; i <= 5; i++) {
    printf("Count: %d\n", i);
}

// Arrays
int numbers[] = {1, 2, 3, 4, 5};
int sum = 0;
for (int i = 0; i < 5; i++) {
    sum += numbers[i];
}
printf("Array sum: %d\n", sum);
```

## Caveats
- Fragments must be valid C code that compiles
- Remember to include `\n` in printf for newlines
- Variables are scoped to the main function
- The code is compiled fresh each time, so compilation errors will fail execution
- musl libc may have some differences from glibc in edge cases

