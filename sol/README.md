# Sol

Sol is a compiled programming language with Ruby and Rust-inspired syntax. Memory is managed through compile-time reference counting optimized with in-place reuse.

## Hello World

```sol
def main
   print("Hello World!")
end
```

## Language Overview

### Symbols

```sol
#            # comment
->           # return from function
?            # boolean method suffix (e.g. empty?, some?)
@            # field access within a class body (@name)
.field       # field access on an instance (no parens)
.method()    # method call on an instance (parens)
#{}          # string interpolation ("Hello, #{name}!")
..           # range operator (0..10)
!            # try-unwrap operator (propagates Result errors)
```

### Variables & Type Inference

```sol
name = "Alice"          # inferred as String
age = 30                # inferred as Int
active = true           # inferred as Bool
```

### Functions

```sol
def add(a Int, b Int) -> Int
   -> a + b
end

# Default parameter values
def greet(name String, greeting String = "Hello") -> String
   -> "#{greeting}, #{name}!"
end
```

`->` is the return operator. Functions with no return type return `Unit`.

### Block Syntax

Definitions use `end`-delimited blocks, while control flow uses braces:

```sol
def greet(name String) -> String
   -> "Hello, #{name}!"
end

if x > 0 {
   print("positive")
}
```

### String Interpolation

```sol
name = "Sol"
print("Hello, #{name}!")
print("#{2 + 3} is five")
```

All types implement `to_string()`, which interpolation calls automatically:

```sol
arr = [1, 2, 3]
print("items: #{arr}")   # "items: [1, 2, 3]"
print(42.to_string())    # "42"
```

### Control Flow

```sol
# If-else works as both statement and expression
result = if x > 0 { "positive" } else { "negative" }

# While loop
while i < 10 {
   i = i + 1
}

# Infinite loop with break and next (Ruby-style continue)
loop {
   if done { break }
   if skip { next }
}
```

### Pattern Matching

```sol
match shape {
   Circle(r) => r * r * 3,
   Rect(w, h) => w * h,
   _ => 0
}
```

Match works as an expression and supports data extraction and wildcards. Matching on enums is exhaustive: the compiler requires all variants to be covered, or a `_` wildcard to be present.

### Classes

```sol
class Point
   @x Int
   @y Int

   def new(x Int, y Int)
      @x = x
      @y = y
   end

   def magnitude() -> Int
      -> @x * @x + @y * @y
   end
end

p = Point.new(3, 4)
```

**Attribute defaults:**

```sol
class Config
   @timeout Int = 30
   @retries Int = 3
end

c = Config.new()
```

**Class methods:**

```sol
class Factory
   def.class create() -> Factory
      -> Factory.new()
   end
end
```

**Value types** (stack-allocated, no reference counting). Small classes (<=16 bytes) are automatically inlined; `class.inline` makes it explicit:

```sol
class.inline Vec2
   @x Int
   @y Int
end
```

### Enums

```sol
enum Shape
   Circle(radius Int)
   Rect(w Int, h Int)
   Point
end

shape = Shape.Circle(5)
```

Enums can carry associated data and have methods:

```sol
enum Direction
   North
   South
   East
   West

   def axis_value() -> Int
      -> match self {
         North => 10,
         South => 20,
         East => 30,
         West => 40
      }
   end
end
```

### Option & Result

```sol
present = Option.Some(42)
absent = Option.None

value = present.unwrap_or(0)
if present.some? { ... }

# Result for error handling
def divide(a Int, b Int) -> Result<Int, String>
   if b == 0 { -> Err("division by zero") }
   -> Ok(a / b)
end
```

### Try-Unwrap Operator

The `!` operator unwraps a `Result`, propagating the error if it fails:

```sol
def compute() -> Result<Int, String>
   a = divide(10, 2)!
   b = divide(20, 4)!
   -> Ok(a + b)
end
```

### Closures

```sol
double = {|x| x * 2 }
double.call(21)

# Closures as parameters
def apply(f {|Int| Int}, x Int) -> Int
   -> f.call(x)
end

apply({|n| n + 1 }, 41)
```

**Non-local return:** `->` inside a closure exits the *enclosing function*, not just the closure, enabling early exit from iteration:

```sol
def find_first(arr Array, f {|Int| Int} -> Int) -> Int
   i = 0
   while i < arr.length() {
      f.call(arr[i])
      i = i + 1
   }
   -> 0
end

def main -> Int
   -> find_first([1, 2, 3]) { |x|
      if x == 2 { -> x }
      0
   }
end
```

### Traits

```sol
trait Valued
   def value() -> Int
end

class Coin
   impl Valued

   @cents Int

   def value() -> Int
      -> @cents
   end
end
```

Traits can also include **default method implementations** and **attribute requirements**.

### Bundles

Bundles compose multiple traits into a single unit:

```sol
trait Named
   def name() -> String
end

trait Valued
   def value() -> Int
end

bundle Entity
   includes Named
   includes Valued
end

class Item
   impl Entity
   # must implement both name() and value()
end
```

### Operator Overloading

```sol
class Point
   @x Int
   @y Int

   def.op ==(other Self) -> Bool
      -> @x == other.x && @y == other.y
   end
end
```

### Self Type

`Self` refers to the implementing type in traits and classes:

```sol
trait Clonable
   def clone() -> Self
end
```

### Generics

Sol has two keywords for type parameterization:

**`compile`** defines explicit type parameters, specified at the call site:

```sol
class Box
   compile Value type

   @value Value

   def get() -> Value
      -> @value
   end
end

b = Box[Int].new(42)
```

Compile-time parameters can also be integers:

```sol
class Buffer
   compile size Int

   @data Int
end
```

**`infer`** defines associated types, inferred from usage rather than specified explicitly. Works on classes, enums, traits, and bundles:

```sol
enum Box
   infer Content

   Value(content Content)
   Empty

   def has_value? -> Int
      -> match self {
         Value(_) => 1,
         Empty => 0
      }
   end
end

container = Box.Value(42)   # Content inferred as Int
```

```sol
trait Container
   infer Element

   def get() -> Element
end

class Shelf
   infer Element
   impl Container

   @value Element

   def get() -> Element
      -> @value
   end
end
```

### Type Aliases

```sol
alias Number = Int
alias Coord = Point
```

### Modules & Imports

```sol
module Net
   class Request
      @id Int
   end

   def build(id Int) -> Request
      -> Request.new(id)
   end
end

req = Net::build(43)
```

**Imports** with aliasing, groups, and globs:

```sol
module App
   use Net::Request
   use Net::Response as Resp
   use Net::{Request, Response, ping}
   use Math::*
end
```

Modules can be nested and reopened. `::` prefix accesses the global scope.

Directory structure maps to modules automatically. Folder names are converted to PascalCase. If a folder converts to `Api` but your code declares `module API`, the code wins:

```
src/
   main.sl              # root scope
   net_utils/
      client.sl         # module NetUtils
      http/
         request.sl     # module NetUtils::Http
```

### Arrays

```sol
numbers = [1, 2, 3, 4, 5]
first = numbers[0]
slice = numbers[1..3]
numbers.push(6)
numbers.pop()
numbers.length()

# Iterators
doubled = numbers.map({|x| x * 2})
total = numbers.reduce(0, {|sum, x| sum + x})
label = numbers.join(", ")
```

Array type shorthand: `[Int]` is sugar for `Array[Int]`.

### Hash Maps

```sol
scores = Hash.new()
scores["alice"] = 95
scores["bob"] = 87

scores.get("alice")           # Option.Some(95)
scores.get_or("carol", 0)    # 0
scores.contains?("bob")      # true
scores.length()               # 2
scores.keys()                 # ["alice", "bob"]
scores.values()               # [95, 87]
scores.each({|k, v| print("#{k}: #{v}")})
```

### Strings

```sol
text = "Hello"
text.length()
char = text[0]
sub = text[1..3]
combined = "Hello, " + "World!"

# String operations
"hello, world".split(", ")        # ["hello", "world"]
"hello".replace("l", "r")         # "herro"
"  hello  ".trim()                # "hello"
"hello".to_uppercase()            # "HELLO"
"HELLO".to_lowercase()            # "hello"
"hello".starts_with?("he")        # true
"hello".contains("ell")           # true
"hello".index_of("ll")            # Option.Some(2)
```

### Ranges

Ranges are zero-copy unless mutated.

```sol
r = 0..10
r.length()
r.contains?(5)
r.empty?
```

### Boolean Method Naming

Methods ending in `?` return Bool:

```sol
option.some?
option.none?
result.ok?
range.empty?
string.unique?
```

### Recursion

```sol
def factorial(n Int) -> Int
   if n <= 1 { -> 1 }
   -> n * factorial(n - 1)
end
```

### Extern Functions (FFI)

```sol
def.extern print(str String)
```

### Memory Model

Sol uses compile-time reference counting with copy-on-write semantics and in-place reuse. Allocations are freed deterministically. Value types (`class.inline` and <= 16 bytes) are stack-allocated and skip reference counting entirely.

Low-level types `UnsafePointer[T]` and `Memory[T]` are available for manual control when needed.
