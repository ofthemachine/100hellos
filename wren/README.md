# Wren

Wren is a small, fast, class-based concurrent scripting language that combines the simplicity of Lua with the power of class-based object-oriented programming. It was created by Bob Nystrom, who is also known for his work on the Dart programming language and the book "Game Programming Patterns".

## Language Features

- **Class-based Object-Oriented**: Unlike prototype-based languages like JavaScript, Wren uses traditional class-based inheritance
- **Fiber-based Concurrency**: Built-in support for cooperative multitasking using fibers
- **Small and Fast**: The entire VM is only a few thousand lines of C code
- **Statically-typed Methods**: Method calls are resolved at compile time for better performance
- **Clean, Readable Syntax**: Influenced by languages like Ruby and Python
- **Embeddable**: Designed to be embedded in applications, similar to Lua

## Hello World Explanation

The Wren Hello World program is remarkably simple:

```wren
System.print("Hello World!")
```

The `System` class provides basic system functionality, and `print` is a static method that outputs text to standard output. Unlike many languages, Wren doesn't require a `main` function or any boilerplate code.

## History

Wren was created by Bob Nystrom and first released in 2013. It was designed to be a modern alternative to Lua for game development and other embedded scripting needs. The language combines the simplicity and small footprint of Lua with more familiar class-based object-oriented programming concepts.

## Further Exploration

- [Wren Website](https://wren.io/)
- [Wren GitHub Repository](https://github.com/wren-lang/wren)
- [Wren Documentation](https://wren.io/syntax.html)
- [Try Wren Online](https://wren.io/try/)