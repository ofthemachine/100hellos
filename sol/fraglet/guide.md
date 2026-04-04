# Sol Fraglet Guide

## Language Version
Sol (compiled via MLIR/LLVM)

## Execution Model
- Compiled language using the `sol` compiler
- Code is compiled to a native binary via MLIR/LLVM, then executed
- Programs use a `def main` entry point

## Key Characteristics
- Ruby-inspired syntax with `end`-delimited blocks
- Statically typed with type inference
- Compile-time reference counting with in-place reuse
- Pattern matching with exhaustive enum checking
- Closures with non-local return
- Traits and bundles for polymorphism
- Generics via `compile` (explicit) and `infer` (associated types)
- Case-sensitive
- 3-space indentation by convention

## Fragment Authoring
Write a complete Sol program. Your fragment replaces the entire source file and is compiled to a native binary, then executed. Every fragment must include a `def main ... end` entry point.

## Common Patterns
- Print: `print("message")`
- Variables: `x = 10` or `x: Int = 10`
- String interpolation: `"Hello, #{name}!"`
- Functions: `def add(a Int, b Int) -> Int ... end`
- Return: `-> value`
- If/else: `if x > 0 { "yes" } else { "no" }`
- While: `while i < 10 { i = i + 1 }`
- Arrays: `[1, 2, 3]`
- Hash maps: `h = Hash.new(); h["key"] = "value"`
- Strings: `"hello".split(",")`, `"hello".replace("l", "r")`, `"  hi  ".trim()`
- Iterators: `[1,2,3].map({|x| x * 2})`, `[1,2,3].reduce(0, {|sum, x| sum + x})`
- Classes: `class Point ... end`
- Enums: `enum Shape ... end`
- Pattern matching: `match value { ... }`
- Closures: `{|x| x * 2 }`
- Boolean methods end in `?`

## Examples
```sol
# Simple output
def main
   print("Hello from fragment!")
end

# Variables and string interpolation
def main
   name = "Sol"
   version = 1
   print("#{name} version #{version}")
end

# Functions and return
def add(a Int, b Int) -> Int
   -> a + b
end

def main
   result = add(5, 10)
   print("5 + 10 = #{result}")
end

# If-else expression
def main
   x = 42
   label = if x > 0 { "positive" } else { "negative" }
   print("#{x} is #{label}")
end

# While loop
def main
   i = 0
   total = 0
   while i < 5 {
      total = total + i
      i = i + 1
   }
   print("Sum: #{total}")
end

# Arrays
def main
   numbers = [10, 20, 30]
   print("First: #{numbers[0]}")
   print("Length: #{numbers.length()}")
end

# Classes
class Point
   @x Int
   @y Int

   def new(x Int, y Int)
      @x = x
      @y = y
   end

   def to_string() -> String
      -> "(#{@x}, #{@y})"
   end
end

def main
   p = Point.new(3, 4)
   print("Point: #{p}")
end

# Enums and pattern matching
enum Color
   Red
   Green
   Blue
end

def main
   c = Color.Red
   name = match c {
      Red => "red",
      Green => "green",
      Blue => "blue"
   }
   print("Color: #{name}")
end

# Closures
def main
   double = {|x| x * 2 }
   print("#{double.call(21)}")
end

# Hash maps
def main
   scores = Hash.new()
   scores["alice"] = 95
   scores["bob"] = 87
   print("Alice: #{scores.get_or("alice", 0)}")
   print("Keys: #{scores.keys()}")
end

# Array iterators
def main
   numbers = [1, 2, 3, 4, 5]
   doubled = numbers.map({|x| x * 2})
   total = numbers.reduce(0, {|sum, x| sum + x})
   print("Doubled: #{doubled}")
   print("Sum: #{total}")
   print("Joined: #{numbers.join(", ")}")
end

# String operations
def main
   text = "hello, world"
   parts = text.split(", ")
   print("Parts: #{parts}")
   print("Upper: #{text.to_uppercase()}")
   print("Replace: #{text.replace("world", "Sol")}")
end

# Recursion
def factorial(n Int) -> Int
   if n <= 1 { -> 1 }
   -> n * factorial(n - 1)
end

def main
   print("10! = #{factorial(10)}")
end

# TCP echo server
def main
   bind_result = TcpServer.bind(9000)

   match bind_result {
      Ok(server) => {
         print("Listening on port 9000")
         accept_result = server.accept()

         match accept_result {
            Err(e) => print("Accept error"),
            Ok(conn) => {
               buf = UnsafePointer[UInt8].alloc(1024)
               read_result = conn.read_into(buf, 1024)

               match read_result {
                  Ok(n) => {
                     conn.write_bytes(buf, n)
                     print("Echoed #{n} bytes")
                  }
                  Err(e) => print("Read error"),
               }

               buf.free()
               _ = conn.close()
            }
         }

         _ = server.close()
      }
      Err(e) => print("Bind error"),
   }
end
```

## Caveats
- Fragments replace the entire source file, so include all definitions and a `def main ... end` entry point
- `def main` does not need a return type
- Use `print()` for output
- String interpolation uses `#{}` syntax
- `->` is the return operator
- Definitions use `end`, control flow uses `{}`
- The code is compiled to a native binary and executed each time
