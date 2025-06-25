# Factor

Factor is a concatenative, stack-based programming language inspired by Forth and Lisp. It was designed by Slava Pestov and features powerful metaprogramming capabilities, a rich standard library, and an elegant object system.

## About Factor

Factor is a dynamic, stack-based language with powerful metaprogramming features. It combines the simplicity of stack-based programming with modern language features like:

- **Dynamic typing** with optional static type inference
- **Powerful metaprogramming** through quotations and combinators
- **Rich standard library** including GUI frameworks, web development tools, and more
- **Interactive development** with a sophisticated listener (REPL)
- **Object-oriented programming** with generic functions and method dispatch

## The Stack-Based Paradigm

In Factor, computation is performed by manipulating a data stack. Functions (called "words" in Factor) consume values from the stack and push results back onto it:

```factor
! Push numbers onto the stack
2 3 +    ! Results in 5 on the stack

! String manipulation
"Hello" " " "World!" 3append    ! Results in "Hello World!"
```

## Hello World Explained

Our Factor program is remarkably simple:

```factor
USE: io

"Hello World!" print
```

- `USE: io` - Imports the input/output vocabulary
- `"Hello World!"` - Pushes the string literal onto the stack
- `print` - Pops the string from the stack and prints it to stdout

## Key Features

### Quotations
Factor's most distinctive feature is quotations - blocks of code that can be treated as data:

```factor
[ 2 * ] map    ! Apply doubling function to each element
[ dup * ] keep ! Square a number while keeping the original
```

### Combinators
Higher-order functions that operate on quotations:

```factor
5 [ 1 + ] [ 2 * ] bi    ! Apply both functions: results in 6 and 10
```

### Vocabularies
Factor organizes code into vocabularies (similar to modules):

```factor
USING: math sequences io ;
```

## Language History

Factor was created by Slava Pestov in 2003, originally targeting the JVM. It has since evolved into a self-hosted language with its own virtual machine. The language is inspired by:

- **Forth** - Stack-based computation model
- **Lisp** - Metaprogramming and code-as-data philosophy
- **Smalltalk** - Object system and interactive development

## Further Exploration

- Try the interactive listener: `factor`
- Explore the rich vocabulary system
- Learn about Factor's unique approach to object-oriented programming
- Investigate the powerful metaprogramming capabilities
- Check out the GUI framework for desktop applications

Factor represents a unique approach to programming that challenges conventional thinking about language design while remaining highly practical and expressive.