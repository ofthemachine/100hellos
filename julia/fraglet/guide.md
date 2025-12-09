# Julia Fraglet Guide

## Language Version
Julia 1.10.x

## Execution Model
- JIT-compiled language, runs via Julia interpreter
- Code executes at the top level
- Just-in-time compilation for performance
- Code runs sequentially from top to bottom

## Key Characteristics
- Dynamic typing with optional type annotations
- Case-sensitive
- Multiple dispatch (functions can have multiple methods)
- High-performance numerical computing
- Indentation is preserved from the injection point

## Fragment Authoring
Fragments should be valid Julia statements or expressions. They are injected into the main execution block, replacing the match marker. Code runs at the top level of the script.

## Available Packages
Standard Julia library is available. No additional packages are pre-installed. To install packages:
```julia
using Pkg
Pkg.add("PackageName")
```
Note: Installs live only for the lifetime of the run.

## Common Patterns
- Print: `println("message")` or `print("message\n")`
- Variables: `x = 10` or `const y = 20`
- Functions: `function name(x) return x * 2 end` or `name(x) = x * 2`
- Arrays: `[1, 2, 3]` or `1:10`
- Type annotations: `x::Int = 10`
- Multiple dispatch: `f(x::Int) = x * 2; f(x::String) = x * 2`

## Examples
```julia
# Simple output
println("Hello, World!")

# Function definition
function greet(name)
    return string("Hello, ", name, "!")
end
println(greet("Alice"))

# Array processing
numbers = [1, 2, 3, 4, 5]
squared = numbers .^ 2
println("Sum of squares: $(sum(squared))")

# Type annotations and multiple dispatch
function double(x::Int)
    return x * 2
end
function double(x::String)
    return string(x, x)
end
println(double(5))
println(double("Hi"))
```

## Caveats
- Fragments must be valid Julia that executes without errors
- Variables are scoped to the script level
- Use `println()` for output (not `print()` unless you add newline)
- Remember that Julia is JIT-compiled - first run may be slower
- Make fragments idempotent—repeated runs should succeed without manual cleanup

