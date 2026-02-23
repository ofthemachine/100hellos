# Fantom Fraglet Guide

## Language Version
Fantom 1.0.82, JVM-based

## Execution Model
- The container runs your fraglet as a Fantom script: `fan hello-world.fan [args...]`
- Your fraglet is the **entire runnable class**: it replaces the whole class definition between the injection markers
- Use **`class Fraglet`** with **`Void main()`** — the runtime discovers and invokes the main method
- Stdin is available via **`Env.cur().in`**; arguments via **`Env.cur().args`**

## Fragment Authoring
Write a **complete** class with a `main()` method. The fraglet is the full class. That gives you:
- **Arguments**: `Env.cur().args` returns `Str[]` (command-line args)
- **Stdin**: `Env.cur().in` — read lines with `in.readAllStr()` or line-by-line
- **Output**: `echo("message")` or `Env.cur().out().printLine("message")`
- Full freedom to define methods, fields, and nested types in the class

The class must be named **`Fraglet`** (matches the template).

## Stdin and Args (for AI / scripts)
- **Read stdin**: `Env.cur().in.readAllStr()` or read line-by-line and process
- **Use args**: `Env.cur().args.join(" ")` — they are passed through from the fraglet invocation

## Key Characteristics
- JVM-based, statically typed
- Case-sensitive; semicolons optional
- Classes and mixins; nullable types with `?`
- Built-in prelude: `echo`, `Int`, `Str`, `List`, etc.

## Common Patterns
- Print: `echo("message")` or `Env.cur().out().printLine("message")`
- String interpolation: `"Total: $count"` or `"Total: ${expression}"`
- Args: `Env.cur().args.join(" ")`
- Stdin: `Env.cur().in.readAllStr()` or iterate lines
- Lists: `list.each |Int n| { sum += n * n }`, iteration and accumulation

## Examples

Each example below is a **full class** you can use as the fraglet as-is.

```fan
class Fraglet {
  Void main() {
    echo("Hello, World!")
  }
}
```

```fan
class Fraglet {
  Void main() {
    name := "Alice"
    echo("Hello, $name!")
  }
}
```

```fan
class Fraglet {
  Void main() {
    numbers := [1, 2, 3, 4, 5]
    sum := 0
    numbers.each |Int n| { sum += n * n }
    echo("Sum of squares: $sum")
  }
}
```

```fan
class Fraglet {
  Void main() {
    a := 5
    b := 3
    echo("5 * 3 = ${a * b}")
  }
}
```

```fan
class Fraglet {
  Void main() {
    args := Env.cur().args
    echo("Args: " + args.join(" "))
  }
}
```

```fan
class Fraglet {
  Void main() {
    in := Env.cur().in
    in.eachLine |line| { echo(line.upper) }
  }
}
```

## Notes
- Use `class Fraglet` and `Void main()` for the entry point
- `Env.cur().args` and `Env.cur().in` are available; no extra setup
- `echo()` is from the prelude; for more control use `Env.cur().out()`
- Fantom runs on the JVM; Java interop is available via `using [java] ...`
