# Visual Basic .NET Fraglet Guide

## Language Version
Visual Basic .NET (.NET 7.0 SDK)

## Execution Model
- Compiled language using the .NET SDK
- Code is compiled and executed via `dotnet run`
- Your fragment is the body of `Sub Main(args As String())` — you write statements only; `args` and the surrounding `Module`/`Sub Main` are provided by the template

## Key Characteristics
- Statically typed, case-insensitive
- Object-oriented (classes, modules, interfaces)
- Verbose keywords: `Sub`, `End Sub`, `Dim`, `As`
- Rich standard library (BCL — same as C#)
- Option Strict can affect type inference

## Fragment Authoring
Write valid VB.NET statements that would appear inside `Sub Main(args As String())`. You do not write the `Module` or `Sub Main` declaration; the template supplies them. You have access to `args` (command-line arguments) and can use `Console` for input/output.

## Command-line arguments and stdin
- **Arguments**: `args` (String()) is in scope. Example: `Console.WriteLine("Args: " & String.Join(" ", args))`
- **Stdin**: Use `Console.ReadLine()` (one line) or `Console.In.ReadToEnd()` (entire input).

## Available Namespaces
The template has `Imports System`. You can use:
- `System` — Console, String, Int32, etc.
- `System.Collections.Generic` — List, Dictionary
- `System.Linq` — LINQ (if you add `Imports System.Linq` in your fragment)
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
' Simple output
Console.WriteLine("Hello from fragment!")
```

```vb
' Variables and calculations
Dim a As Integer = 5
Dim b As Integer = 10
Console.WriteLine($"Sum: {a + b}")
```

```vb
' Using List
Dim numbers As New List(Of Integer) From {1, 2, 3, 4, 5}
Dim sum As Integer = 0
For Each num In numbers
    sum += num
Next
Console.WriteLine($"List sum: {sum}")
```

```vb
' String operations
Dim message As String = "Hello"
message &= " World!"
Console.WriteLine(message)
```

```vb
' Arguments
Console.WriteLine("Args: " & String.Join(" ", args))
```

```vb
' Stdin (entire input)
Console.WriteLine(Console.In.ReadToEnd())
```

```vb
' Multiply and display
Dim multiply As Func(Of Integer, Integer, Integer) = Function(a, b) a * b
Console.WriteLine($"5 * 3 = {multiply(5, 3)}")
```

## Caveats
- Fragment must be valid VB.NET that compiles; the compiler runs each time
- Use `&` for string concatenation; `+` works for numbers but `&` is preferred for strings
- String interpolation: `$"text {expr}"`
- Case does not matter for keywords and identifiers
