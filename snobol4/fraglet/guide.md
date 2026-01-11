# SNOBOL4 Fraglet Guide

## Language Version
CSNOBOL4 2.3.3

## Execution Model
- Interpreted language, runs via `snobol4` command
- Code executes sequentially from top to bottom
- Pattern matching and string manipulation are core features
- Execution happens through a wrapper script that invokes the snobol4 interpreter

## Key Characteristics
- Pattern-matching oriented
- String manipulation is fundamental
- Labels are used for control flow (goto-like behavior)
- Case-sensitive
- Whitespace is significant in some contexts

## Fragment Authoring
Write valid SNOBOL4 statements. Your fragment becomes the script body. Code runs sequentially.

## Key SNOBOL4 Concepts
- **Assignment**: `VARIABLE = "value"`
- **Pattern matching**: `STRING PATTERN = REPLACEMENT`
- **Labels**: `LABEL OUTPUT = "message"`
- **Success/Failure**: `:S(LABEL)` (on success), `:F(LABEL)` (on failure)
- **Unconditional goto**: `:(LABEL)`
- **Output**: `OUTPUT = "message"`
- **Concatenation**: `RESULT = STR1 " " STR2`

## Common Patterns
- Output: `OUTPUT = "message"`
- Assignment: `VAR = "value"`
- Pattern matching: `STRING "pattern" = "replacement"`
- Conditional: `CONDITION :S(SUCCESS) F(FAILURE)`
- String concatenation: `RESULT = STR1 " " STR2`
- Pattern replacement: `STRING "old" = "new"`

## Examples
```sno
*       Simple output
        OUTPUT = "Hello, World!"

*       Variable assignment and concatenation
        GREETING = "Hello"
        TARGET = "World"
        MESSAGE = GREETING " " TARGET "!"
        OUTPUT = MESSAGE

*       Pattern matching and replacement
        TEXT = "Hello World"
        TEXT "World" = "Universe"
        OUTPUT = TEXT

*       Conditional pattern matching
        TEXT = "Hello World"
        TEXT "Hello" = "Hi" :S(SUCCESS) F(FAILURE)
SUCCESS  OUTPUT = TEXT
        :(END)
FAILURE  OUTPUT = "Pattern not found"
END
```

## Caveats
- Fragments must be valid SNOBOL4 that executes without errors
- Labels must be unique within the program
- Pattern matching uses SNOBOL4's pattern syntax (not regex)
- Remember that SNOBOL4 is a pattern-matching language - many operations are based on pattern matching
- Variables are global by default
- Make fragments idempotent—repeated runs should succeed without manual cleanup

