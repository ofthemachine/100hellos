# COBOL Fraglet Guide

## Language Version
COBOL (GnuCOBOL 3.x), compiled to native code via C

## Execution Model
- Compiled language using GnuCOBOL (cobc)
- Code is compiled to a binary, then executed
- Your fraglet is the **entire program**: IDENTIFICATION DIVISION through PROCEDURE DIVISION

## Key Characteristics
- **Free format** (no leading columns required); case-insensitive keywords
- Divisions: IDENTIFICATION, ENVIRONMENT, DATA (optional), PROCEDURE
- PROGRAM-ID required; PROCEDURE DIVISION contains executable logic
- DISPLAY for output; ACCEPT for input (stdin or COMMAND-LINE)

## Fragment Authoring
Write a **complete** COBOL program. The fraglet replaces the whole source between the markers. You must include:
- IDENTIFICATION DIVISION with PROGRAM-ID
- PROCEDURE DIVISION with your logic
- DATA DIVISION / WORKING-STORAGE SECTION when you need variables

## Stdin and Args
- **Read stdin**: Use `ACCEPT ws-line` in a loop; each ACCEPT reads one line. Use `FUNCTION UPPER-CASE` for uppercase.
- **Command-line args**: Use `ACCEPT ws-cmd FROM COMMAND-LINE` to get the full command line; parse or display as needed (e.g. skip program name for "Args: ...").

## Common Patterns
- Output: `DISPLAY "message"`
- Variables: WORKING-STORAGE SECTION, `01 my-var PIC X(20).`
- Numeric: `01 n PIC 99 VALUE 5.`
- Loop: `PERFORM UNTIL condition ... END-PERFORM` or `PERFORM VARYING i FROM 1 BY 1 UNTIL i > 5 ...`
- Uppercase: `FUNCTION UPPER-CASE(ws-line)`
- Trim: `FUNCTION TRIM(ws-cmd)`

## Examples

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       PROCEDURE DIVISION.
           DISPLAY "Hello, World!"
           STOP RUN.
```

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GREET.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  A PIC 99 VALUE 5.
       01  B PIC 99 VALUE 10.
       PROCEDURE DIVISION.
           COMPUTE A = A + B
           DISPLAY "Sum: " A
           STOP RUN.
```

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQUARES.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  I PIC 99.
       01  S PIC 999 VALUE ZERO.
       01  N PIC 99 VALUE 5.
       PROCEDURE DIVISION.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > N
               COMPUTE S = S + I * I
           END-PERFORM
           DISPLAY "Sum of squares: " S
           STOP RUN.
```

## Caveats
- PROGRAM-ID must be a valid COBOL name (alphanumeric, hyphen).
- Use STOP RUN to exit cleanly.
- String length in PIC (e.g. PIC X(80)) must be large enough for input.
- GnuCOBOL supports both fixed-format (columns 8–72) and free format (`-free`); the container uses **free format** so you can left-justify code (no leading spaces required).
