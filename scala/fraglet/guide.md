# Scala Fraglet Guide

## Language Version
Scala (installed via Coursier)

## Execution Model
- Compiled, then executed
- Uses `scala run` to compile and execute in one step
- Requires an object with a `main` method
- Code executes when `main()` is called
- Can define functions, classes, traits, and objects outside `main()`

## Key Characteristics
- JVM-based language (runs on Java)
- Statically typed with type inference
- Case-sensitive
- Semicolons optional
- Supports both object-oriented and functional programming
- Immutable by default (val vs var)
- Pattern matching

## Fragment Authoring
Write valid Scala statements or expressions. Code executes inside `main()`, so you can write statements directly. You can also define functions, classes, traits, and objects outside `main()` and call them from within.

## Available Libraries
- Standard Scala library
- Java standard library (via JVM)
- No additional dependencies pre-installed

## Common Patterns
- Print: `println("message")`
- String interpolation: `s"Total: $count"` or `s"Total: ${expression}"`
- Lists: `List(1, 2, 3).sum`
- Functions: `def methodName(): Unit = { }`
- Classes: `class MyClass { }`
- Objects: `object MyObject { }`
- Traits: `trait MyTrait { }`
- Pattern matching: `x match { case 1 => ... }`
- Immutable variables: `val x = 5`
- Mutable variables: `var x = 5`
- Higher-order functions: `list.map(x => x * 2)`
- For comprehensions: `for (i <- 1 to 10) println(i)`

## Examples

```scala
// Simple output
println("Hello, World!")
```

```scala
// Function definition
def greet(name: String): String = {
    s"Hello, $name!"
}

println(greet("Alice"))
```

```scala
// List processing
val numbers = List(1, 2, 3, 4, 5)
val squared = numbers.map(x => x * x)
println(s"Sum of squares: ${squared.sum}")
```

```scala
// Higher-order function
val multiply = (a: Int, b: Int) => a * b
println(s"5 * 3 = ${multiply(5, 3)}")
```

```scala
// Class definition
class Calculator {
    def add(a: Int, b: Int): Int = {
        a + b
    }
}

val calc = new Calculator()
println(s"10 + 20 = ${calc.add(10, 20)}")
```

```scala
// String interpolation
val name = "Scala"
val version = 3
println(s"Welcome to $name $version!")
```

```scala
// Case class
case class Person(name: String, age: Int)

val person = Person("Bob", 30)
println(s"${person.name} is ${person.age} years old")
```

```scala
// Pattern matching
val x = 5
val result = x match {
    case n if n < 0 => "negative"
    case 0 => "zero"
    case _ => "positive"
}
println(s"x is $result")
```

```scala
// For comprehension
val numbers = List(1, 2, 3, 4, 5)
val doubled = for (n <- numbers) yield n * 2
println(s"Doubled: ${doubled.mkString(", ")}")
```

```scala
// Option handling
val name: Option[String] = Some("Scala")
name.foreach(n => println(s"Name: $n"))

val empty: Option[String] = None
println(empty.getOrElse("Default value"))
```

```scala
// Extension methods (Scala 3) or implicit classes (Scala 2)
implicit class StringOps(s: String) {
    def double(): String = s + s
}

val text = "Hello"
println(text.double())
```

## Notes
- Use `val` for immutable variables, `var` for mutable
- Type inference works well, but explicit types can improve clarity
- Pattern matching is powerful for control flow
- Case classes provide convenient data structures
- For comprehensions are syntactic sugar for map/flatMap/filter
- Scala 2 and Scala 3 syntax may differ slightly
