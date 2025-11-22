# Ruby Fraglet Guide

## Language Version
Ruby 3.3.x

## Execution Model
- Interpreted, runs directly from source
- Top-level code executes immediately
- No explicit main function required

## Key Characteristics
- Everything is an object
- Dynamic typing
- Case-sensitive
- Indentation mirrors the placeholder line (no indentation by default)

## Fragment Authoring
Fragments should be valid Ruby statements or expressions. Code executes at the top level, so expressions run immediately in order.

## Available Packages
Standard Ruby library is available. No additional gems are pre-installed.

## Common Patterns
- Print: `puts("message")` or `puts "message"`
- String interpolation: `"Total: #{count}"`
- Arrays: `[1, 2, 3].sum`
- Blocks: `do ... end` or `{ ... }`
- Methods: `def method_name; end`
- Ranges: `(1..10).each { |i| puts i }`

## Examples
```ruby
# Simple output
puts "Hello, World!"

# Method definition
def greet(name)
  "Hello, #{name}!"
end

puts greet("Alice")

# Array processing
numbers = [1, 2, 3, 4, 5]
squared = numbers.map { |x| x**2 }
puts "Sum of squares: #{squared.sum}"
```
