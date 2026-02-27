# EmojiCode Fraglet Guide

## Language Version
EmojiCode (compiled language)

## Execution Model
- Compiled via `emojicodec` compiler
- Produces native binary executable

## Fragment Authoring
Write a complete EmojiCode program. Your fragment replaces the entire source file.

## Basic Syntax
- `🏁` - Main function entry point
- `🍇` / `🍉` - Block start / end
- `😀` - Print statement
- `🔤...🔤` - String literal delimiters
- `❗️` - Statement terminator
- `💭` - Comment marker

## Variables and Types
- `🖍🆕` - Declare a mutable variable
- `🔢` - Integer type
- `🔡` - String type
- Declaration: `🖍🆕 x 🔢 5`

## Conditionals
- `↪️` - If
- `🙅` - Else
- `🙅↪️` - Else-if
- `👍` / `👎` - True / False

## Examples
```emojicode
🏁 🍇
  😀 🔤Hello World!🔤❗️
🍉
```

```emojicode
🏁 🍇
  😀 🔤First line🔤❗️
  😀 🔤Second line🔤❗️
🍉
```

```emojicode
🏁 🍇
  🖍🆕 x 🔢 5
  ↪️ 👍 🍇
    😀 🔤True!🔤❗️
  🍉
  🙅 🍇
    😀 🔤False!🔤❗️
  🍉
🍉
```

## Caveats
- Ensure your editor supports Unicode emoji characters
- String literals must be wrapped in `🔤` delimiters
- Statements end with `❗️`
- Variable declarations require `🖍🆕` prefix
