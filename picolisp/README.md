# PicoLisp

PicoLisp is a minimalist yet powerful Lisp dialect that combines simplicity with remarkable functionality. Created by Alexander Burger, it embodies the philosophy that "less is more" - providing a complete programming environment in an extremely compact implementation.

## What Makes PicoLisp Special

PicoLisp is unique among Lisp dialects for several reasons:

### Minimalist Design
- The entire system fits in less than 300KB
- Only seven data types: Numbers, Symbols, Lists, and four internal types
- No built-in compiler - it's a pure interpreter optimized for interactive development
- Cells are only 16 bytes (8 bytes on 32-bit systems)

### Integrated Database
Unlike most languages, PicoLisp includes a built-in object-oriented database with:
- ACID transactions
- B-Tree indexes
- Entity-relationship modeling
- Seamless persistence without external dependencies

### Web Framework
PicoLisp comes with a complete web application framework featuring:
- HTTP server
- HTML generation functions
- Session management
- Form handling and validation

### Prolog Engine
A complete Prolog implementation is built into the language, allowing logic programming alongside functional programming paradigms.

## Language Philosophy

PicoLisp follows several key principles:

- **Simplicity**: Every feature must justify its existence
- **Orthogonality**: Features should not overlap or interfere
- **Consistency**: Similar things should work similarly
- **Efficiency**: Both in terms of memory and execution speed

The language intentionally lacks many "convenience" features found in other Lisps, such as:
- Macros (replaced by `read` macros and `let` expressions)
- Multiple namespaces (everything is in one global space)
- Complex numeric types (only 64-bit integers and unlimited precision big integers)

## Understanding the Hello World Code

```lisp
#!/usr/bin/env pil

(prinl "Hello World!")
(bye)
```

Let's break this down:

- `#!/usr/bin/env pil` - The shebang line tells the system to use the PicoLisp interpreter
- `(prinl "Hello World!")` - The `prinl` function prints its arguments followed by a newline
- `(bye)` - Exits the PicoLisp interpreter gracefully

In PicoLisp, `prinl` is preferred over `print` for simple text output because it automatically adds a newline, making output more readable in interactive sessions.

## Language History

PicoLisp was created by Alexander Burger, who started development in the 1980s as a reaction to the increasing complexity of other Lisp systems. The first public version was released in 1999.

Key milestones:
- **1980s**: Initial development begins
- **1999**: First public release
- **2002**: Database integration completed
- **2007**: 64-bit version released
- **2010**: Web framework stabilized
- **2017**: Moved to a more open development model

The name "PicoLisp" reflects its tiny size (pico = 10^-12) compared to other Lisp implementations, while still being a complete development environment.

## Interactive Development

PicoLisp excels at interactive development. You can explore the language interactively:

```lisp
# Start the REPL
pil

# Try some basic expressions
: (+ 1 2 3)
-> 6

# Work with lists
: (list 'a 'b 'c)
-> (a b c)

# Define and use functions
: (de hello (name) (prinl "Hello " name "!"))
-> hello

: (hello "World")
Hello World!
-> "World"
```

## Further Exploration

To dive deeper into PicoLisp:

1. **Interactive Tutorial**: Start with `pil` and explore the built-in help system
2. **Documentation**: Visit the official PicoLisp website for comprehensive documentation
3. **Examples**: The distribution includes many example programs
4. **Community**: Join the PicoLisp mailing list for discussions and support

PicoLisp proves that a language doesn't need to be large to be powerful. Its integrated approach to programming, databases, and web development makes it a unique tool for building complete applications with minimal overhead.