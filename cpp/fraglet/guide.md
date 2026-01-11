# C++ Fraglet Guide

## Language Version
C++ (G++ compiler, musl libc)

## Execution Model
- Compiled language using G++
- Code is compiled to a binary, then executed
- Build script compiles `hello-world.cpp` to `hello` binary, then runs it
- Standard C++ execution model with `main()` function

## Key Characteristics
- Statically typed
- Case-sensitive
- Object-oriented (classes, inheritance, polymorphism)
- Supports templates (generic programming)
- Rich standard library (STL)
- Requires explicit compilation step
- Uses musl libc (Alpine's C library)

## Fragment Authoring
Write valid C++ code. Your fragment can define classes, functions, and the `main()` function. Standard library includes are already in place. Your fragment will be compiled and executed.

## Available Headers
The template includes these standard headers:
- `<iostream>` - Input/output streams (cout, cin, cerr)
- `<vector>` - Dynamic arrays
- `<string>` - String class
- `<algorithm>` - Algorithms (sort, find, transform)
- `<map>`, `<unordered_map>` - Associative containers
- `<set>`, `<unordered_set>` - Set containers
- `<memory>` - Smart pointers (unique_ptr, shared_ptr)
- `<fstream>` - File I/O
- `<cmath>` - Mathematical functions
- `<chrono>` - Time utilities
- `<thread>` - Threading support

## Common Patterns
- Print: `std::cout << "message" << std::endl;`
- Variables: `int x = 10;` or `auto x = 10;`
- Classes: `class MyClass { ... };`
- Functions: `int add(int a, int b) { return a + b; }`
- Templates: `template<typename T> T max(T a, T b) { ... }`
- Vectors: `std::vector<int> vec = {1, 2, 3};`
- Strings: `std::string s = "Hello";`
- Smart pointers: `auto ptr = std::make_unique<int>(42);`
- Loops: `for (int i = 0; i < 10; i++) { ... }` or `for (auto& item : vec) { ... }`

## Examples
```cpp
// Simple output
int main() {
    std::cout << "Hello from fragment!" << std::endl;
    return 0;
}

// Variables and calculations
int main() {
    int a = 5;
    int b = 10;
    std::cout << "Sum: " << (a + b) << std::endl;
    return 0;
}

// Using STL vector
int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int num : numbers) {
        sum += num;
    }
    std::cout << "Vector sum: " << sum << std::endl;
    return 0;
}

// String operations
int main() {
    std::string message = "Hello";
    message += " World!";
    std::cout << message << std::endl;
    return 0;
}

// Simple class
class Calculator {
public:
    int add(int a, int b) {
        return a + b;
    }
};

int main() {
    Calculator calc;
    std::cout << "5 + 3 = " << calc.add(5, 3) << std::endl;
    return 0;
}

// Template function
template<typename T>
T maximum(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    std::cout << "Max(5, 10) = " << maximum(5, 10) << std::endl;
    std::cout << "Max(3.14, 2.71) = " << maximum(3.14, 2.71) << std::endl;
    return 0;
}
```

## Caveats
- Fragments must be valid C++ code that compiles
- Remember to include `std::endl` or `"\n"` for newlines
- Variables, classes, and functions are scoped to the file
- The code is compiled fresh each time, so compilation errors will fail execution
- musl libc may have some differences from glibc in edge cases
- Use `std::` prefix for standard library components, or add `using namespace std;` at the top of your fragment
