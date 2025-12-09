# LOLCODE Fraglet Guide

## Language Version
LOLCODE (lci interpreter)

## Execution Model
- Interpreted language written entirely in lolspeak
- Code executes sequentially from top to bottom
- Uses lolspeak keywords for all operations
- BTW (comments) are ignored

## Key Characteristics
- **LOLSPEAK SYNTAX**: Everything is written in internet meme language
- Case-insensitive (but tradition uses ALL CAPS for keywords)
- Variables are dynamically typed
- BTW starts comments (By The Way)
- Indentation is preserved from the injection point

## Fragment Authoring
Fragments should be valid LOLCODE statements. They are injected into the main execution block, replacing the match marker. Code runs at the top level of the script.

## Key LOLCODE Concepts
- **HAI** / **KTHXBYE**: Program start/end (already in template)
- **VISIBLE**: Print output (like `print` or `console.log`)
- **I HAS A**: Variable declaration (`I HAS A VAR ITZ "value"`)
- **R**: Assignment operator (`VAR R "new value"`)
- **SUM OF** / **DIFF OF** / **PRODUKT OF** / **QUOSHUNT OF**: Math operations
- **BOTH SAEM** / **DIFFRINT**: Comparison operators
- **O RLY?** / **YA RLY** / **NO WAI**: If/else statements
- **IM IN YR LOOP** / **IM OUTTA YR LOOP**: Loops

## Common Patterns
- Print: `VISIBLE "message"`
- Variable: `I HAS A VAR ITZ "value"`
- Assignment: `VAR R "new value"`
- Math: `SUM OF 5 AN 10` (returns 15)
- Comparison: `BOTH SAEM VAR AN "test"`
- If/else: `O RLY? YA RLY ... NO WAI ... OIC`

## Examples
```lolcode
BTW Simple output
VISIBLE "Hello, World!"

BTW Variable assignment and output
I HAS A PHRASE ITZ "Hello, World!"
VISIBLE PHRASE

BTW Math operations (because why not?)
I HAS A NUM1 ITZ 5
I HAS A NUM2 ITZ 10
I HAS A TOTAL ITZ SUM OF NUM1 AN NUM2
VISIBLE TOTAL

BTW Conditional logic (O RLY? YA RLY!)
I HAS A MOOD ITZ "HAPPY"
O RLY?
  YA RLY
    VISIBLE "I'M HAPPY!"
  NO WAI
    VISIBLE "I'M SAD"
OIC

BTW Loop (IM IN YR LOOP)
I HAS A COUNTER ITZ 0
IM IN YR LOOP
  VISIBLE COUNTER
  COUNTER R SUM OF COUNTER AN 1
  BOTH SAEM COUNTER AN 5, O RLY?
    YA RLY, GTFO
  OIC
IM OUTTA YR LOOP
```

## Caveats
- Fragments must be valid LOLCODE that executes without errors
- Variables are scoped to the script level
- Use `VISIBLE` for output (not `print` or `console.log`)
- Remember: This is a REAL programming language, not a joke (well, it is, but it works!)
- Make fragments idempotent—repeated runs should succeed without manual cleanup
- **BTW** - Comments are important for readability, even in LOLCODE!

## Pro Tips
- **O RLY?** - When you need conditional logic, this is your friend
- **IM IN YR LOOP** - For iteration, obviously
- **SUM OF X AN Y** - Math is done with words, because why not?
- **VISIBLE** - The only way to output (invisible output would be useless)

**KTHXBYE!** (That means "thanks, bye!" in LOLCODE)

