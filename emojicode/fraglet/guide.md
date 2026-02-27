# Emojicode Fraglet Guide

## Language Version
Emojicode (as installed in this container; run `emojicodec --version` inside the container if you need the exact version).

## Execution Model
- **Compiled language** using the `emojicodec` compiler.
- Your fraglet **replaces the entire contents** between `💭 BEGIN_FRAGLET` and `💭 END_FRAGLET` in `hello-world.🍇`.
- The resulting file is compiled and run as a normal Emojicode program.

## Key Characteristics
- **Emoji-based syntax** for all core constructs (entry point, blocks, variables, printing, comments).
- **Compiled to native code**; errors are reported by `emojicodec` with file/position info.
- **Block-structured** with explicit start (`🍇`) and end (`🍉`) delimiters.
- **Statement-terminated** with `❗️`.

## Fragment Authoring
- **You write a complete Emojicode program.** Your fraglet is not injected into `main` or any other function body.
- You must include:
  - Program entry: `🏁`
  - A top-level block: `🍇` ... `🍉`
  - Whatever statements you want to run inside that block.
- The minimal shape looks like:

```emojicode
🏁 🍇
  …your statements…
🍉
```

## Mental Model
You write a **full, valid Emojicode program**, starting with `🏁` and a `🍇 … 🍉` block, and we **compile and run it as-is**.  
Nothing is injected for you and no `main` wrapper is added – if your program wouldn’t compile with `emojicodec` on its own, it won’t compile as a fraglet.

## Basic Syntax
- `🏁` – Program entry point.
- `🍇` / `🍉` – Block start / end.
- `😀` – Print statement.
- `🔤…🔤` – String literal delimiters.
- `❗️` – Statement terminator.
- `💭` – Comment / annotation.

## Variables and Types
- `🖍🆕` – Declare a mutable variable.
- Common types:
  - `🔢` – Integer.
  - `🔡` – String.
- Example declaration:

```emojicode
🖍🆕 x 🔢 5❗️
```

## Examples

### Minimal Hello World
This is the smallest program you should expect to compile and run as a fraglet in this vein:

```emojicode
🏁 🍇
  😀 🔤Hello from Emojicode fraglet!🔤❗️
🍉
```

### Variables and printing
A slightly richer example with a variable and formatted output:

```emojicode
🏁 🍇
  🖍🆕 times 🔢 3❗️
  😀 🔤About to greet…🔤❗️
  😀 🔤Hello 🔤❗️
  😀 🔤We greeted 🔤❗️
  😀 🔤times: 🔤❗️
  😀 times❗️
🍉
```

Both examples are complete programs: if you drop them between `💭 BEGIN_FRAGLET` and `💭 END_FRAGLET` in `hello-world.🍇`, they should compile and run under this fraglet vein.

## Caveats
- **Full program required**: Fragments that are just statements like `😀 🔤Hello🔤❗️` without `🏁 🍇` … `🍉` will fail to compile.
- **Compiler errors are authoritative**: If execution fails, read the `emojicodec` error message and iterate until it compiles – this guide describes the expected structure, but the compiler is the final arbiter.
- Ensure your editor supports **Unicode emoji** so characters are preserved correctly.
- **String literals** must be wrapped in `🔤` delimiters.
- **Every statement** (including variable declarations and prints) must end with `❗️`.
- Variable declarations require the `🖍🆕` prefix and an appropriate type emoji. 
