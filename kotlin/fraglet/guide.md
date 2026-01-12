# Kotlin Fraglet Guide

## Language Version
Kotlin

## Execution Model
- Compiled language
- Requires explicit `main()` function
- Top-level code executes when `main()` is called
- Can define functions, classes, and top-level properties outside `main()`

## Key Characteristics
- Statically typed with type inference
- Case-sensitive
- Semicolons optional
- Null-safety built into the type system
- Supports functional programming (lambdas, higher-order functions)

## Fragment Authoring
Write valid Kotlin statements or expressions. Code executes inside `main()`, so you can write statements directly. You can also define functions, classes, and properties outside `main()` and call them from within.

## Available Libraries
- Standard Kotlin library
- Java standard library (via JVM)
- No additional dependencies pre-installed

## Common Patterns
- Print: `println("message")`
- String interpolation: `"Total: $count"` or `"Total: ${expression}"`
- Lists: `listOf(1, 2, 3).sum()`
- Lambdas: `{ x -> x * 2 }`
- Functions: `fun methodName() { }`
- Classes: `class MyClass { }`
- Ranges: `(1..10).forEach { println(it) }`
- Null-safety: `val name: String? = null; name?.let { println(it) }`
- Extension functions: `fun String.reversed() = this.reversed()`

## Examples

```kotlin
// Simple output
println("Hello, World!")
```

```kotlin
// Function definition
fun greet(name: String): String {
    return "Hello, $name!"
}

println(greet("Alice"))
```

```kotlin
// List processing
val numbers = listOf(1, 2, 3, 4, 5)
val squared = numbers.map { it * it }
println("Sum of squares: ${squared.sum()}")
```

```kotlin
// Lambda usage
val multiply = { a: Int, b: Int -> a * b }
println("5 * 3 = ${multiply(5, 3)}")
```

```kotlin
// Class definition
class Calculator {
    fun add(a: Int, b: Int): Int {
        return a + b
    }
}

val calc = Calculator()
println("10 + 20 = ${calc.add(10, 20)}")
```

```kotlin
// String interpolation
val name = "Kotlin"
val version = 1.9
println("Welcome to $name $version!")
```

```kotlin
// Data class
data class Person(val name: String, val age: Int)

val person = Person("Bob", 30)
println("${person.name} is ${person.age} years old")
```

```kotlin
// Null-safety
val name: String? = "Kotlin"
name?.let { println("Name: $it") }

val nullable: String? = null
println(nullable ?: "Default value")
```

```kotlin
// Extension function
fun String.double(): String = this + this

val text = "Hello"
println(text.double())
```

```kotlin
// When expression
val x = 5
val result = when {
    x < 0 -> "negative"
    x == 0 -> "zero"
    else -> "positive"
}
println("x is $result")
```

## Caveats
- Startup time may be slower than pure interpreted languages
- Some Java types and methods are available
- Type inference works well, but explicit types can improve readability
- Null-safety requires explicit handling of nullable types
- Extension functions are resolved statically, not dynamically
