# EmojiCode Fraglet Guide

## Language Version
EmojiCode (compiled language)

## Execution Model
- Compiled via `emojicodec` compiler
- Produces native binary executable
- Standard compiled execution model

## Key Characteristics
- Emoji-based syntax (uses Unicode emoji characters)
- Statically typed
- Object-oriented
- Compiled to native code
- Case-sensitive
- Comments use `#` (hash symbol)

## Fragment Authoring
Fragments should be valid EmojiCode code. They are injected into the hello-world.🍇 file, replacing the region between `# BEGIN_FRAGLET` and `# END_FRAGLET` markers. The fragment code will be compiled and executed.

## Basic Syntax
- `🏁` - Main function entry point
- `🍇` - Block start (opening brace equivalent)
- `🍉` - Block end (closing brace equivalent)
- `😀` - Print statement
- `🔤...🔤` - String literal delimiters
- `❗️` - Statement terminator/exclamation operator
- `#` - Comment marker

## Variables and Types
- `🖍🆕` - Declare a mutable variable (note: `🖍` prefix is required)
- `🔢` - Integer type
- `🔡` - String type
- Variable declaration syntax: `🖍🆕 variableName 🔢 value` (no assignment operator needed)
- Example: `🖍🆕 x 🔢 5` (declare integer x with value 5)

## Conditionals
- `↪️` - If statement
- `🙅` - Else statement
- `🙅↪️` - Else-if statement
- `👍` - True/boolean true value
- `👎` - False/boolean false value
- Comparison operators: `▶️` (greater than), `◀️` (less than), `🙌` (not equal), `👍` (equal)

### If Statement Syntax
```emojicode
↪️ condition 🍇
  # Code to execute if condition is true
🍉
```

### If-Else Statement Syntax
```emojicode
↪️ condition 🍇
  # Code to execute if condition is true
🍉
🙅 🍇
  # Code to execute if condition is false
🍉
```

### If-Else-If Statement Syntax
```emojicode
↪️ condition1 🍇
  # Code for condition1
🍉
🙅↪️ condition2 🍇
  # Code for condition2
🍉
🙅 🍇
  # Default case
🍉
```

## Common Patterns
```emojicode
# Print a string
😀 🔤Hello World!🔤❗️

# Note: Fraglets are injected inside the main function
# You don't need to include 🏁 🍇 ... 🍉 in your fraglet

# Variable declaration
🖍🆕 name 🔡 🔤Alice🔤
😀 name❗️

# Simple conditional
↪️ 👍 🍇
  😀 🔤This will print🔤❗️
🍉
```

## Examples
```emojicode
# Simple output
😀 🔤Hello World!🔤❗️

# Multiple statements
😀 🔤First line🔤❗️
😀 🔤Second line🔤❗️

# Variable declaration and usage
🖍🆕 x 🔢 5
😀 🔤Value: 🔤❗️
😀 x❗️

# Simple conditional with boolean
↪️ 👍 🍇
  😀 🔤True!🔤❗️
🍉
🙅 🍇
  😀 🔤False!🔤❗️
🍉

# If-else statement
↪️ 👍 🍇
  😀 🔤Condition is true🔤❗️
🍉
🙅 🍇
  😀 🔤Condition is false🔤❗️
🍉
```

**Note on Variable Comparisons**: Variable comparisons in conditionals may require additional syntax or context. For complex conditionals, refer to the official Emojicode documentation. Simple boolean conditionals and variable declarations work as shown above.

## Caveats
- EmojiCode uses emoji characters extensively - ensure your editor supports Unicode
- The compiler (`emojicodec`) requires the standard library path (`-S` flag)
- Fraglets are injected inside the main function - don't include `🏁 🍇` or `🍉` in your fraglet
- String literals must be wrapped in `🔤` delimiters
- Statements end with `❗️`
- Comments use `#` and are ignored by the compiler
- Variable declarations require `🖍🆕` prefix (not just `🆕`)
- Variable syntax: `🖍🆕 name 🔢 value` (no assignment operator `➡️` needed)
- Comparison operators use emoji symbols (🙌, 👍, ▶️, ◀️)
- For complex variable comparisons in conditionals, refer to official Emojicode documentation

