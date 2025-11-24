# C Fraglet Guide (Main Function Replacement)

## Language Version
C (GCC compiler, musl libc)

## Execution Model
- Compiled language using GCC
- Code is compiled to a binary, then executed
- Build script compiles `hello-world.c` to `hello` binary, then runs it
- Fragments replace the entire main function body (between BEGIN_FRAGLET and END_FRAGLET)

## Key Characteristics
- Statically typed
- Case-sensitive
- Requires explicit compilation step
- Uses musl libc (Alpine's C library)
- Fragment replaces the entire main function body, so you write complete function logic

## Fragment Authoring
Fragments should be complete C code for the main function body. The entire block between `// BEGIN_FRAGLET` and `// END_FRAGLET` is replaced with your fragment code. You don't need to include `return 0;` - it's added automatically.

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
- Arrays: `int arr[10];`
- Pointers: `int *ptr = &x;`
- Loops: `for (int i = 0; i < 10; i++) { ... }`
- Conditionals: `if (condition) { ... } else { ... }`
- Memory: `int *arr = malloc(10 * sizeof(int)); free(arr);`
- Strings: `char str[] = "hello"; int len = strlen(str);`

## Examples
```c
// Simple output
printf("Hello from fragment!\n");

// Variables and calculations
int a = 5;
int b = 10;
printf("Sum: %d\n", a + b);

// Loops and arrays
int numbers[] = {1, 2, 3, 4, 5};
int sum = 0;
for (int i = 0; i < 5; i++) {
    sum += numbers[i];
}
printf("Array sum: %d\n", sum);

// String manipulation
char message[] = "Hello, World!";
int len = strlen(message);
printf("Length: %d\n", len);

// Dynamic memory
int *arr = malloc(5 * sizeof(int));
for (int i = 0; i < 5; i++) {
    arr[i] = i * 2;
}
free(arr);

// Math functions
double result = sqrt(16.0);
printf("Square root: %.2f\n", result);
```

## Caveats
- Fragments must be valid C code that compiles
- Remember to include `\n` in printf for newlines
- The entire main function body is replaced, so write complete logic
- No need to include `return 0;` - it's added automatically
- Dynamic memory must be freed to avoid leaks
- musl libc may have some differences from glibc in edge cases
- Compilation errors will fail execution

