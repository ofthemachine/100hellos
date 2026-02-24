# Visual Basic .NET Fraglet Guide

## Language Version
Visual Basic .NET (.NET 7.0 SDK)

## Execution Model
- Compiled language using the .NET SDK
- Code is compiled and executed via `dotnet run`
- Your fragment is the **entire module** between the markers — write a complete `Module Fraglet` with `Sub Main(args As String())` and any helpers you need.

## Key Characteristics
- Statically typed, case-insensitive
- Object-oriented (classes, modules, interfaces)
- Verbose keywords: `Sub`, `End Sub`, `Dim`, `As`
- Rich standard library (BCL — same as C#)
- Option Strict can affect type inference

## Fragment Authoring
Write a complete VB.NET module. Use **`Module Fraglet`** (the template expects this name). Your fragment replaces the whole module between the markers, so include `Sub Main(args As String())` and `End Sub` / `End Module`. You have `args` (command-line arguments) and `Console` for I/O.

## Command-line arguments and stdin
- **Arguments**: `args` (String()) is in scope in `Sub Main`. Example: `Console.WriteLine("Args: " & String.Join(" ", args))`
- **Stdin**: Use `Console.ReadLine()` (one line) or `Console.In.ReadToEnd()` (entire input).

## Available Namespaces
The template has `Imports System` above the fragment. You can use:
- `System` — Console, String, Int32, etc.
- `System.Collections.Generic` — List, Dictionary
- `System.Linq` — LINQ (add `Imports System.Linq` inside your module if needed)
- `System.IO` — File I/O

## Common Patterns
- Print: `Console.WriteLine("message")`
- Variables: `Dim x As Integer = 10` or `Dim x = 10`
- String concatenation: `"Hello " & name` or `$"Hello {name}"` (interpolation)
- Arrays: `Dim arr() As Integer = {1, 2, 3}`
- Loops: `For i = 0 To 9` ... `Next` or `For Each item In collection` ... `Next`
- Args: `String.Join(" ", args)`

## Examples

```vb
Module Fraglet
    Sub Main(args As String())
        Console.WriteLine("Hello from fragment!")
    End Sub
End Module
```

```vb
Module Fraglet
    Sub Main(args As String())
        Dim a As Integer = 5
        Dim b As Integer = 10
        Console.WriteLine($"Sum: {a + b}")
    End Sub
End Module
```

```vb
Module Fraglet
    Sub Main(args As String())
        Dim numbers As New List(Of Integer) From {1, 2, 3, 4, 5}
        Dim sum As Integer = 0
        For Each num In numbers
            sum += num
        Next
        Console.WriteLine($"List sum: {sum}")
    End Sub
End Module
```

```vb
Module Fraglet
    Sub Main(args As String())
        Dim message As String = "Hello"
        message &= " World!"
        Console.WriteLine(message)
    End Sub
End Module
```

```vb
Module Fraglet
    Sub Main(args As String())
        Console.WriteLine("Args: " & String.Join(" ", args))
    End Sub
End Module
```

```vb
Module Fraglet
    Sub Main(args As String())
        Console.WriteLine(Console.In.ReadToEnd())
    End Sub
End Module
```

```vb
Module Fraglet
    Sub Main(args As String())
        Dim multiply As Func(Of Integer, Integer, Integer) = Function(a, b) a * b
        Console.WriteLine($"5 * 3 = {multiply(5, 3)}")
    End Sub
End Module
```

## Caveats
- Fragment must be valid VB.NET that compiles; the compiler runs each time
- Use `Module Fraglet` so the template and entry point stay consistent
- Use `&` for string concatenation; `+` works for numbers but `&` is preferred for strings
- String interpolation: `$"text {expr}"`
- Case does not matter for keywords and identifiers
