# C# Fraglet Guide

## Language Version
C# (.NET 7.0 SDK)

## Execution Model
- Compiled language using the .NET SDK
- Code is compiled and executed via `dotnet run`
- Standard C# execution model with `Program.cs` containing top-level statements or a `Main` method
- Uses .NET 7.0 runtime

## Key Characteristics
- Statically typed
- Case-sensitive
- Object-oriented (classes, interfaces, inheritance, polymorphism)
- Supports generics (type parameters)
- Rich standard library (BCL - Base Class Library)
- Modern features: top-level statements, pattern matching, nullable reference types
- Requires explicit compilation step (handled by `dotnet run`)

## Fragment Authoring
Write valid C# code. You can use top-level statements (C# 9.0+) for simple code, or define classes and a `Main` method for more complex code. **Important**: If you define classes or methods, you must use a `Main` method - top-level statements cannot appear after class declarations. Your fragment will be compiled and executed.

## Available Namespaces
The template includes common using directives. You can use:
- `System` - Core types and utilities
- `System.Collections.Generic` - Collections (List, Dictionary, etc.)
- `System.Linq` - LINQ queries
- `System.IO` - File I/O
- `System.Text` - Text encoding
- `System.Threading.Tasks` - Async/await support

## Common Patterns
- Print: `Console.WriteLine("message");`
- Variables: `int x = 10;` or `var x = 10;`
- Classes: `public class MyClass { ... }`
- Methods: `public static int Add(int a, int b) { return a + b; }`
- Generics: `List<int> numbers = new List<int>();`
- Strings: `string s = "Hello";`
- Arrays: `int[] arr = {1, 2, 3};`
- Loops: `for (int i = 0; i < 10; i++) { ... }` or `foreach (var item in collection) { ... }`
- Top-level statements: Direct code execution without Main method (C# 9.0+)

## Examples
```csharp
// Simple output (top-level statements)
Console.WriteLine("Hello from fragment!");

// Variables and calculations
int a = 5;
int b = 10;
Console.WriteLine($"Sum: {a + b}");

// Using List collection
var numbers = new List<int> { 1, 2, 3, 4, 5 };
int sum = 0;
foreach (int num in numbers) {
    sum += num;
}
Console.WriteLine($"List sum: {sum}");

// String operations
string message = "Hello";
message += " World!";
Console.WriteLine(message);

// Simple class (using Main method when defining classes)
public class Calculator {
    public int Add(int a, int b) {
        return a + b;
    }
}

public class Program {
    public static void Main() {
        var calc = new Calculator();
        Console.WriteLine($"5 + 3 = {calc.Add(5, 3)}");
    }
}

// Generic method (using Main method)
public class Program {
    public static T Maximum<T>(T a, T b) where T : IComparable<T> {
        return a.CompareTo(b) > 0 ? a : b;
    }

    public static void Main() {
        Console.WriteLine($"Max(5, 10) = {Maximum(5, 10)}");
        Console.WriteLine($"Max(3.14, 2.71) = {Maximum(3.14, 2.71)}");
    }
}

// LINQ example
var numbers = new[] { 1, 2, 3, 4, 5 };
var evens = numbers.Where(n => n % 2 == 0);
Console.WriteLine($"Even numbers: {string.Join(", ", evens)}");
```

## Caveats
- Fragments must be valid C# code that compiles
- Top-level statements are available (C# 9.0+), so you don't need a `Main` method for simple code
- **Important**: Top-level statements must precede class declarations. If you define classes, you must use a `Main` method instead of top-level statements
- Variables, classes, and methods are scoped to the file
- The code is compiled fresh each time, so compilation errors will fail execution
- Use `$"..."` for string interpolation or `string.Format()` for formatted strings
- Nullable reference types are enabled, so be aware of null-safety warnings
