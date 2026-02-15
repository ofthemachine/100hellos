# ArnoldC Fraglet Guide

## Language Version
ArnoldC

## Execution Model
- Compiled language where all keywords are Arnold Schwarzenegger quotes
- Code is compiled and then executed
- Uses Arnold's movie quotes for all programming constructs

## Key Characteristics
- **ARNOLD QUOTES AS KEYWORDS**: Every construct is a Schwarzenegger quote
- Case-sensitive
- Statically typed (like Java)

## Code format

- **Full program.** Your fragment is a complete program: `IT'S SHOWTIME`, then your statements, then `YOU HAVE BEEN TERMINATED`.

## Minimal fragment (copy and adapt)

```arnoldc
IT'S SHOWTIME
  TALK TO THE HAND "Hello from fragment!"
YOU HAVE BEEN TERMINATED
```

## Key ArnoldC Concepts
- **IT'S SHOWTIME** / **YOU HAVE BEEN TERMINATED**: Program start/end
- **TALK TO THE HAND**: Print output (`TALK TO THE HAND "message"`)
- **HEY CHRISTMAS TREE** / **YOU SET US UP**: Declare integer variable (`HEY CHRISTMAS TREE varname` then `YOU SET US UP value`). **I NEED YOUR CLOTHES YOUR BOOTS AND YOUR MOTORCYCLE** is for method arguments only.
- **GET TO THE CHOPPER**: Assignment (`GET TO THE CHOPPER VAR`)
- **HERE IS MY INVITATION**: Set value (`HERE IS MY INVITATION "value"`)
- **ENOUGH TALK**: End assignment
- **GET UP**: Addition (`GET UP 5`)
- **GET DOWN**: Subtraction (`GET DOWN 3`)
- **YOU'RE FIRED**: Multiplication (`YOU'RE FIRED 2`)
- **HE HAD TO SPLIT**: Division (`HE HAD TO SPLIT 2`)
- **CONSIDER THAT A DIVORCE**: Modulo (`CONSIDER THAT A DIVORCE 3`)
- **YOU ARE NOT YOU YOU ARE ME**: Equality comparison
- **LET OFF SOME STEAM BENNET**: Greater than
- **BECAUSE I'M GOING TO SAY PLEASE**: If (`BECAUSE I'M GOING TO SAY PLEASE value` then statements then `YOU HAVE NO RESPECT FOR LOGIC`)
- **BULLSHIT**: Else (between if and YOU HAVE NO RESPECT FOR LOGIC)
- **STICK AROUND**: While loop (`STICK AROUND ... CHILL`)

## Common Patterns
- Print: `TALK TO THE HAND "message"`
- Variable: `HEY CHRISTMAS TREE var` then `YOU SET US UP initialValue`
- Assignment: `GET TO THE CHOPPER var` then `HERE IS MY INVITATION value` (and optional ops) then `ENOUGH TALK`
- Math: `GET TO THE CHOPPER result` then `HERE IS MY INVITATION 5` then `GET UP 10` then `ENOUGH TALK`
- Stdin (integer): declare var, then `GET YOUR ASS TO MARS var`, `DO IT NOW`, `I WANT TO ASK YOU A BUNCH OF QUESTIONS AND I WANT TO HAVE THEM ANSWERED IMMEDIATELY`, then use var.
- If/else: `BECAUSE I'M GOING TO SAY PLEASE value` then statements, optional `BULLSHIT` and else block, then `YOU HAVE NO RESPECT FOR LOGIC`
- Loop: `STICK AROUND value` then statements then `CHILL`

## Examples
```arnoldc
IT'S SHOWTIME
  TALK TO THE HAND "Hello, World!"
YOU HAVE BEEN TERMINATED
```

```arnoldc
IT'S SHOWTIME
  TALK TO THE HAND "Math is easy!"
  TALK TO THE HAND "5 + 10 = 15"
YOU HAVE BEEN TERMINATED
```

```arnoldc
IT'S SHOWTIME
  HEY CHRISTMAS TREE sum
  YOU SET US UP 0
  GET TO THE CHOPPER sum
  HERE IS MY INVITATION 5
  GET UP 10
  ENOUGH TALK
  TALK TO THE HAND sum
YOU HAVE BEEN TERMINATED
```

## Caveats
- **Stdin**: Integer only. Use `GET YOUR ASS TO MARS var`, `DO IT NOW`, then `I WANT TO ASK YOU A BUNCH OF QUESTIONS AND I WANT TO HAVE THEM ANSWERED IMMEDIATELY` to read one integer into `var`. No string/line stdin.
- ArnoldC has no documented argv; use stdin or hardcoded values for input.
- Fragments must be valid ArnoldC that compiles without errors
- Variables must be declared before use (`HEY CHRISTMAS TREE varname` then `YOU SET US UP value`)
- Assignment requires the full `GET TO THE CHOPPER ... ENOUGH TALK` pattern
- Use `TALK TO THE HAND` for output (not `print` or `System.out.println`)
- Remember: This is a REAL language (just with Arnold quotes!)
- Make fragments idempotent—repeated runs should succeed without manual cleanup
- **GET TO THE CHOPPER** - Always end assignments with `ENOUGH TALK`

## Pro Tips
- **IT'S SHOWTIME** - Program start
- **TALK TO THE HAND** - The only way to output (because Arnold said so)
- **GET TO THE CHOPPER** - For all assignments (because helicopters are cool)
- **STICK AROUND** - For loops (because Arnold wants you to stay)
- **YOU HAVE BEEN TERMINATED** - Program end

**Hasta la vista, baby!** (That's Spanish for "see you later" - Arnold's favorite phrase)

