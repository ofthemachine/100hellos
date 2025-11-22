# Python Fraglet Guide

## Language Version
Python 3.x

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level
- Main execution block: `if __name__ == "__main__":`

## Key Characteristics
- Indentation-sensitive (4 spaces standard)
- Dynamic typing
- Case-sensitive
- Indentation is automatically preserved based on the injection point

## Fragment Authoring
Fragments should be valid Python statements or expressions. They are injected into the main execution block, so code runs at the top level of the script.

## Available Packages
Standard Python library is available. No additional packages are pre-installed.

## Common Patterns
- Print: `print("message")`
- Main guard: `if __name__ == "__main__":`
- Functions: `def function_name():`
- List comprehensions: `[x*2 for x in range(10)]`
- String formatting: `f"Value: {value}"`

## Examples
```python
# Simple output
print("Hello, World!")

# Function definition
def greet(name):
    return f"Hello, {name}!"

print(greet("Alice"))

# List processing
numbers = [1, 2, 3, 4, 5]
squared = [x**2 for x in numbers]
print(f"Sum of squares: {sum(squared)}")
```
