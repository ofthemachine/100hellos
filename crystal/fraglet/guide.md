# Crystal Fraglet Guide

## Language Version
Crystal 1.x

## Execution Model
- Compiled language with ahead-of-time compilation
- Can also run directly: `crystal run file.cr` (compiles and executes)
- Statically typed with type inference
- No explicit main function required - top-level code executes

## Key Characteristics
- Ruby-like syntax with static typing
- Type inference (explicit types optional)
- Case-sensitive
- Object-oriented with classes and methods
- Supports modules, structs, enums, and unions

## Fragment Authoring
Write valid Crystal code. Your fragment can define:
- Classes with methods
- Structs
- Modules
- Top-level code
- Variable declarations and assignments
- Method calls

Your fragment should be complete, valid Crystal code that can be compiled and executed.

## Available Packages
Standard Crystal library (stdlib) is available. No additional shards are pre-installed.

## Common Patterns
- Print: `puts "message"` or `puts("message")`
- String interpolation: `"Hello #{name}!"`
- Type annotations: `name : String = "Alice"` (optional with inference)
- Methods: `def method_name(param : Type) : ReturnType`
- Classes: `class MyClass; end`
- Arrays: `[1, 2, 3]` or `Array(Int32).new`
- Blocks: `do |x| ... end` or `{ |x| ... }`
- Conditionals: `if condition; end`
- Loops: `while condition; end` or `each { |x| ... }`

## Examples
```crystal
# Simple output
puts "Hello, World!"

# Class with method
class Greeting
  def greet(name : String)
    puts "Hello, #{name}!"
  end
end

g = Greeting.new
g.greet("Alice")

# Variables and arithmetic
a = 5
b = 10
sum = a + b
puts "Sum: #{sum}"

# Array processing
numbers = [1, 2, 3, 4, 5]
squared = numbers.map { |x| x ** 2 }
puts "Sum of squares: #{squared.sum}"

# Method definition with type annotations
def calculate(x : Int32, y : Int32) : Int32
  x * y + 10
end

result = calculate(5, 3)
puts "Result: #{result}"

# Struct example
struct Point
  property x : Int32
  property y : Int32

  def initialize(@x, @y)
  end

  def distance : Float64
    Math.sqrt(@x ** 2 + @y ** 2)
  end
end

p = Point.new(3, 4)
puts "Distance: #{p.distance}"
```

## Caveats
- Crystal requires explicit type annotations in some cases (method parameters, return types)
- Type inference works well but may need hints for complex cases
- Crystal is compiled, so compilation errors will prevent execution
- String interpolation uses `#{}` syntax
- Method calls can omit parentheses: `puts "hello"` or `puts("hello")`
