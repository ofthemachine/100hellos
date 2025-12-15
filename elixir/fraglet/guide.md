# Elixir Fraglet Guide

## Language Version
Elixir 1.x (runs on Erlang/OTP)

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level
- Scripts use `.exs` extension (executable scripts)

## Key Characteristics
- Functional programming language
- Immutable data structures
- Pattern matching
- Pipe operator (`|>`)
- Case-sensitive
- Indentation is preserved based on the injection point

## Fragment Authoring
Write normal Elixir code; your fraglet becomes the script body. The file already imports `IO.puts`, so add modules, functions, or expressions as you normally would.

## Available Packages
Standard Elixir library is available. No additional packages are pre-installed.

## Common Patterns
- Print: `IO.puts("message")` or `IO.puts "message"`
- String interpolation: `"Total: #{count}"`
- Lists: `[1, 2, 3]`
- Maps: `%{key: "value"}`
- Pattern matching: `{a, b} = {1, 2}`
- Pipe operator: `list |> Enum.map(fn x -> x * 2 end)`
- Functions: `defmodule MyModule do ... end`

## Examples
```elixir
# Simple output
IO.puts("Hello, World!")

# Function definition
greet = fn name -> "Hello, #{name}!" end
IO.puts(greet.("Alice"))

# List processing
numbers = [1, 2, 3, 4, 5]
squared = Enum.map(numbers, fn x -> x * x end)
sum = Enum.sum(squared)
IO.puts("Sum of squares: #{sum}")

# Using pipe operator
[1, 2, 3, 4, 5]
|> Enum.map(fn x -> x * x end)
|> Enum.sum()
|> IO.puts()

# Module example (now possible with range-based injection)
defmodule Math do
  def sum(numbers) do
    Enum.sum(numbers)
  end
end

IO.puts("Sum: #{Math.sum([1, 2, 3, 4, 5])}")
```

## Caveats
- Elixir uses immutable data structures
- Functions are first-class citizens
- Pattern matching is a core feature
- The pipe operator (`|>`) is commonly used for data transformation

