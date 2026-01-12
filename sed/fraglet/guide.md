# sed Fraglet Guide

## Language Version
GNU sed (stream editor)

## Execution Model
- Stream editor that processes text line by line
- Reads from stdin or files
- Applies commands to each line (or specified lines)
- Outputs modified text to stdout

## Key Characteristics
- Line-oriented processing
- Commands operate on pattern space (current line)
- Addresses specify which lines to process (line numbers, regex patterns)
- Commands: `s` (substitute), `p` (print), `d` (delete), `a` (append), `i` (insert), etc.
- Flags: `g` (global), `p` (print), `i` (case-insensitive)
- Delimiters: `/` is standard, but any character can be used
- Case-sensitive pattern matching (unless using `i` flag)

## Fragment Authoring
Write valid sed commands. Your fragment becomes the script body. Your fragment will execute as part of the sed script.

**Important**: sed processes input line by line. If your fragment needs to process multiple lines, you may need to use the hold space or multi-line commands.

## Available Commands
Standard sed commands are available:
- `s/pattern/replacement/flags` - Substitute pattern with replacement
- `p` - Print the pattern space
- `d` - Delete the pattern space
- `a\text` - Append text after the current line
- `i\text` - Insert text before the current line
- `c\text` - Change/replace the current line
- `y/src/dst/` - Transliterate characters
- `q` - Quit processing
- `=` - Print line number
- `r file` - Read file and append to output
- `w file` - Write pattern space to file

## Common Patterns
- Substitute: `s/old/new/` or `s/old/new/g` (global)
- Print: `p` (usually with `-n` flag to suppress default output)
- Delete: `d`
- Append: `a\Text to append`
- Insert: `i\Text to insert`
- Address ranges: `1,5s/old/new/` (lines 1-5), `/pattern/s/old/new/` (matching lines)
- Multiple commands: `s/old/new/; s/foo/bar/` or `-e 's/old/new/' -e 's/foo/bar/'`
- Conditional: `/pattern/{ s/old/new/; p; }`

## Examples
```sed
# Simple output
1s/^/Hello from fragment!/

# Multiple substitutions
1s/^/Hello /; 1s/$/ World!/

# Print with line numbers
=; p

# Append text
a\This is appended text

# Insert text
i\This is inserted text

# Substitute with case-insensitive flag
s/hello/HELLO/gi

# Process specific lines
1,3s/old/new/g

# Pattern-based substitution
/pattern/s/old/new/

# Multiple commands on same line
1s/^/Prefix /; 1s/$/ Suffix/

# Delete and substitute
1d; 2s/old/new/

# Conditional processing
/error/{ s/error/ERROR/; p; }

# Creative formatting: Transform a list into a formatted output
1s/^/Colors: /; 2s/^/  * /; 3s/^/  * /; 3s/$/ (favorite)/
```

## Caveats
- sed processes one line at a time by default
- Pattern space contains the current line
- Hold space can store data between lines (advanced)
- Addresses are line numbers or regex patterns
- Commands are separated by `;` or newlines
- Use `-n` flag with `p` command to avoid duplicate output
- Delimiters can be any character: `s|old|new|` works the same as `s/old/new/`
- Special characters in patterns need escaping: `\.`, `\*`, `\+`, etc.
- Replacement text can reference matched groups: `s/\(.*\)/\1/`
- Multi-line operations require special handling (hold space, `N` command)
