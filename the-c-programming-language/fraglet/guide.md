# C Fraglet Guide

## Language Version
C (GCC compiler, musl libc)

## Execution Model
- Compiled language using GCC
- Code is compiled to a binary, then executed
- Standard C execution model with `main()` function

## Key Characteristics
- Statically typed
- Case-sensitive
- Requires explicit compilation step
- Uses musl libc (Alpine's C library)

## Fragment Authoring
Write valid C code. Your fragment becomes the complete C program. You must include the `main()` function. Your fragment will be compiled and executed.

## Available Headers
Standard headers are available:
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
#include <stdio.h>
int main() {
    printf("Hello from fragment!\n");
    return 0;
}

// Variables and calculations
#include <stdio.h>
int main() {
    int a = 5;
    int b = 10;
    printf("Sum: %d\n", a + b);
    return 0;
}

// Loops and arrays
#include <stdio.h>
int main() {
    int numbers[] = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int i = 0; i < 5; i++) {
        sum += numbers[i];
    }
    printf("Array sum: %d\n", sum);
    return 0;
}

// String manipulation
#include <stdio.h>
#include <string.h>
int main() {
    char message[] = "Hello, World!";
    int len = strlen(message);
    printf("Length: %d\n", len);
    return 0;
}

// Dynamic memory
#include <stdio.h>
#include <stdlib.h>
int main() {
    int *arr = malloc(5 * sizeof(int));
    for (int i = 0; i < 5; i++) {
        arr[i] = i * 2;
    }
    free(arr);
    return 0;
}

// Math functions
#include <stdio.h>
#include <math.h>
int main() {
    double result = sqrt(16.0);
    printf("Square root: %.2f\n", result);
    return 0;
}
```

## Caveats
- Fragments must be valid C code that compiles
- Remember to include `\n` in printf for newlines
- You must include the `main()` function in your fragment
- Include necessary headers (stdio.h, stdlib.h, etc.) for the functions you use
- Dynamic memory must be freed to avoid leaks
- musl libc may have some differences from glibc in edge cases
- The code is compiled fresh each time, so compilation errors will fail execution

