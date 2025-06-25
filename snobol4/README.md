# SNOBOL4

SNOBOL4 (StriNg Oriented and symBOlic Language) is a high-level programming language developed at Bell Labs in the 1960s by David J. Farber, Ralph E. Griswold, and Ivan P. Polonsky. It is particularly renowned for its powerful string processing and pattern matching capabilities.

## Language Features

- **Pattern Matching**: SNOBOL4's most distinctive feature is its sophisticated pattern matching system, which is more powerful than regular expressions and can handle context-sensitive patterns
- **Dynamic Typing**: Variables can hold any type of data and types are determined at runtime
- **String Processing**: Exceptionally strong string manipulation capabilities with built-in functions for searching, replacing, and analyzing text
- **Goto-based Control Flow**: Uses labels and goto statements for program flow control, reflecting its 1960s origins
- **Associative Arrays**: Tables that can use any data type as indices

## Hello World Program Structure

```snobol4
*       SNOBOL4 Hello World - Demonstrating Language Features
        GREETING = "Hello"
        TARGET = "World"
        PUNCTUATION = "!"

*       Use pattern matching to build message
        MESSAGE = GREETING " " TARGET PUNCTUATION

*       Demonstrate pattern replacement
        MESSAGE "World" = "wonderful World"
        MESSAGE "wonderful " = ""

*       Show conditional pattern matching with success/failure
        MESSAGE "Hello" = "Hello" :S(FOUND) F(NOTFOUND)

FOUND   OUTPUT = MESSAGE
        :(END)

NOTFOUND OUTPUT = "Pattern not found"

END
```

The program demonstrates several key SNOBOL4 features:
- **Comments**: Lines starting with `*` in column 1 are comments
- **String Concatenation**: Adjacent strings are automatically concatenated (`GREETING " " TARGET`)
- **Pattern Replacement**: `MESSAGE "World" = "wonderful World"` finds "World" and replaces it
- **Success/Failure Branching**: `:S(FOUND) F(NOTFOUND)` branches based on pattern match success
- **Labels and Goto**: `FOUND` and `NOTFOUND` are labels for program flow control
- **Unconditional Goto**: `:(END)` jumps to the END label

## Historical Significance

SNOBOL4 was groundbreaking for its time and influenced many later languages:
- Pioneered advanced string processing concepts
- Introduced powerful pattern matching that inspired features in languages like Perl and Python
- Demonstrated the viability of very high-level programming languages
- Influenced the development of regular expressions in Unix tools

## Pattern Matching Power

SNOBOL4's pattern matching goes far beyond regular expressions. It can match nested structures, perform arithmetic during matching, and even modify patterns dynamically during execution. This makes it particularly suitable for parsing complex text formats, language processing, and symbolic computation.

## Modern Implementations

This container uses CSNOBOL4, a modern C implementation that maintains compatibility with the original Bell Labs SNOBOL4 while adding portability to modern operating systems.