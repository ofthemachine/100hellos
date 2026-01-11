# Elm Fraglet Guide

## Language Version
Elm (installed via npm)

## Execution Model
- Compiled language that compiles to JavaScript/HTML
- Code is compiled to HTML using `elm make`
- Requires an Elm project structure (elm.json)
- Project is initialized with `elm init` before compilation
- Output is HTML, text is extracted using grep

## Key Characteristics
- Functional programming language
- Statically typed with type inference
- Immutable by default
- No runtime errors (if it compiles, it works)
- Case-sensitive
- Indentation-sensitive (4 spaces standard)
- Module-based architecture

## Fragment Authoring
Write complete Elm expressions that produce `Html.Html msg` values. Your fragment must include the `Html.text` wrapper and proper indentation (4 spaces).

Fragments should be formatted as:
```elm
    Html.text "your expression here"
```

Where "your expression here" can be:
- String literals: `"Hello, World!"`
- String concatenation: `"Hello, " ++ "World!"`
- Function calls: `String.toUpper "hello"`
- Let expressions: `let x = "Hello" in x ++ " World!"`
- Any valid Elm expression that evaluates to a String

## Available Packages
Standard Elm core libraries are available:
- `Html` - HTML rendering
- `String` - String manipulation
- `List` - List operations
- `Maybe` - Optional values
- `Result` - Error handling
- `Basics` - Basic operations (arithmetic, comparison, etc.)

## Common Patterns
- String output: `"message"`
- String concatenation: `"Hello, " ++ name`
- String interpolation: Use `++` for concatenation (no template literals)
- Functions: `\x -> x + 1` (anonymous) or `let add x y = x + y in add 5 3`
- Lists: `[1, 2, 3]` or `List.range 1 10`
- List operations: `List.map`, `List.filter`, `List.foldl`
- Conditionals: `if condition then "yes" else "no"`

## Examples
```elm
-- Simple output
    Html.text "Hello from fragment!"

-- String concatenation
    Html.text ("Hello, " ++ "World!")

-- Using variables with let
    Html.text <|
        let
            name = "Alice"
            greeting = "Hello, " ++ name ++ "!"
        in
            greeting

-- String manipulation
    Html.text (String.toUpper "hello world")

-- Calculations with string conversion
    Html.text <|
        let
            a = 5
            b = 10
            sum = a + b
        in
            "Sum: " ++ String.fromInt sum

-- List operations
    Html.text <|
        let
            numbers = [1, 2, 3, 4, 5]
            sum = List.sum numbers
        in
            "Sum: " ++ String.fromInt sum

-- List mapping
    Html.text <|
        let
            numbers = [1, 2, 3, 4, 5]
            doubled = List.map (\x -> x * 2) numbers
            sum = List.sum doubled
        in
            "Sum of doubled: " ++ String.fromInt sum

-- Conditional output
    Html.text <|
        let
            score = 85
            message = if score >= 90 then "Excellent!" else if score >= 70 then "Good!" else "Keep trying!"
        in
            message

-- String functions
    Html.text <|
        let
            text = "  hello world  "
            trimmed = String.trim text
            upper = String.toUpper trimmed
        in
            upper
```

## Caveats
- Fragments must be valid Elm expressions that evaluate to a String
- The expression will be wrapped in `Html.text`, so the result must be a String
- Elm is immutable - you cannot reassign variables
- Use `let...in` expressions for multiple operations
- String concatenation uses `++` operator, not `+`
- Numbers must be converted to strings using `String.fromInt` or `String.fromFloat`
- Elm has no null/undefined - use `Maybe` type for optional values
- All code must be within the module structure (handled by the template)
- Your fragment must be a complete expression that evaluates to a String
