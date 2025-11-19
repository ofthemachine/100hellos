# Python Language Guide

## Version
Python 3.x (Alpine package)

## Execution Context
- **Interpreter**: `/usr/bin/python3`
- **Shebang**: `#!/usr/bin/env python3`
- **Execution Model**: Interpreted, runs directly from source files
- **Entry Point**: Files with `.py` extension, executed via shebang

## Key Characteristics
- Indentation-sensitive (4 spaces standard)
- Dynamic typing
- Case-sensitive
- Main execution block: `if __name__ == "__main__":`

## Fragment Injection
Fragments are injected at the `MAIN` marker and should be valid Python statements or expressions. Indentation is automatically preserved based on the marker's position.

## Common Patterns
- Print: `print("message")`
- Main guard: `if __name__ == "__main__":`
- Functions: `def function_name():`

