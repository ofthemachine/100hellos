# Scala Fraglet Guide

## Language Version
Scala 3 (Dotty), JVM-based

## Execution Model
- The container runs your fraglet as a Scala script: `scala Main.scala [args...]`
- Your fraglet is the **entire runnable object**: it replaces the whole `object Main { ... }` between the injection markers
- Use **`object Main`** with **`def main(args: Array[String]): Unit`** — conventional, and you get `args` for free
- Stdin is available via **`scala.io.Source.stdin`**; arguments are in **`args`**

## Fragment Authoring
Write a **complete** `object Main` with a `main` method. The fraglet is not “snippet inside main” — it is the full object. That gives you:
- **Arguments**: `args: Array[String]` in `main(args: Array[String])` — same as any JVM main
- **Stdin**: `scala.io.Source.stdin.getLines()` or `scala.io.Source.stdin.mkString`
- Full freedom to define classes, traits, functions, and top-level logic inside the object

You can name the object something else (e.g. `object App`) if you prefer; **`Main`** is recommended so examples and tooling stay consistent.

## Stdin and Args (for AI / scripts)
- **Read stdin**: `scala.io.Source.stdin.getLines().foreach(println)` or process lines as needed
- **Use args**: `args.foreach(println)` or `args.mkString(" ")` — they are passed through from the fraglet invocation

## Key Characteristics
- JVM-based, statically typed, type inference
- Case-sensitive; semicolons optional
- Immutable by default (`val` vs `var`)
- Pattern matching, case classes, for comprehensions

## Common Patterns
- Print: `println("message")`
- String interpolation: `s"Total: $count"` or `s"Total: ${expression}"`
- Args: `args.mkString(" ")` or `args.toList`
- Stdin: `scala.io.Source.stdin.getLines().toList`
- Lists: `List(1, 2, 3).sum`
- Pattern matching: `x match { case 1 => ... }`

## Examples

Each example below is a **full object** you can use as the fraglet as-is.

```scala
object Main {
  def main(args: Array[String]): Unit = {
    println("Hello, World!")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    def greet(name: String): String = s"Hello, $name!"
    println(greet("Alice"))
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    val numbers = List(1, 2, 3, 4, 5)
    val squared = numbers.map(x => x * x)
    println(s"Sum of squares: ${squared.sum}")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    val multiply = (a: Int, b: Int) => a * b
    println(s"5 * 3 = ${multiply(5, 3)}")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    class Calculator {
      def add(a: Int, b: Int): Int = a + b
    }
    val calc = new Calculator()
    println(s"10 + 20 = ${calc.add(10, 20)}")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    // Command-line arguments
    println("Args: " + args.mkString(" "))
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    // Stdin (e.g. echo "hello" | fragletc --vein=scala script.scala)
    scala.io.Source.stdin.getLines().foreach(line => println(line.toUpperCase))
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    val name = "Scala"
    val version = 3
    println(s"Welcome to $name $version!")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    case class Person(name: String, age: Int)
    val person = Person("Bob", 30)
    println(s"${person.name} is ${person.age} years old")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    val x = 5
    val result = x match {
      case n if n < 0 => "negative"
      case 0 => "zero"
      case _ => "positive"
    }
    println(s"x is $result")
  }
}
```

```scala
object Main {
  def main(args: Array[String]): Unit = {
    val numbers = List(1, 2, 3, 4, 5)
    val doubled = for (n <- numbers) yield n * 2
    println(s"Doubled: ${doubled.mkString(", ")}")
  }
}
```

## Notes
- Use `object Main` and `def main(args: Array[String]): Unit` for a standard entry point
- `args` and stdin are available; no extra setup needed
- Use `val` for immutables, `var` only when needed
- Scala 3 syntax; some Scala 2 constructs (e.g. implicit class) still work
