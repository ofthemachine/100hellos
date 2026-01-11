# Lua Fraglet Guide

## Language Version
Lua 5.4

## Execution Model
- Interpreted, runs directly from source
- Fragment executes inside a `main()` function
- Interpreter launches once, runs `main()`, then exits
- Output must be explicit (`print`, `io.write`)

## Key Characteristics
- Dynamic typing
- Case-sensitive
- Tables are the primary data structure
- Prefer `local` variables to avoid leaking globals

## Fragment Authoring
Write valid Lua statements. Your fragment becomes the main function body. Code runs inside the main function, then the interpreter exits. Define helper functions before using them.

## Available Packages
Standard libraries are available:
- `string` - string manipulation
- `table` - table operations
- `math` - mathematical functions
- `io` - input/output operations
- `os` - operating system interface

## Common Patterns
- Print: `print("message")`
- Local variables: `local message = "Hello"`
- Tables: `local list = {1, 2, 3}`
- Functions: `local function greet(name) return string.format("Hi, %s", name) end`
- Iteration: `for i, value in ipairs(list) do ... end`
- Table iteration: `for key, value in pairs(table) do ... end`

## Examples
```lua
-- Simple output
print("Hello, World!")

-- Function definition
local function greet(name)
  return string.format("Hello, %s!", name)
end

print(greet("Alice"))

-- Table processing
local numbers = {1, 2, 3, 4, 5}
local sum = 0
for i, value in ipairs(numbers) do
  sum = sum + value * value
end
print(string.format("Sum of squares: %d", sum))
```

## Caveats
- Globals persist only for the single run
- Use `local` to avoid polluting the global namespace
- External `require` calls only work if the module exists in the runtime environment
