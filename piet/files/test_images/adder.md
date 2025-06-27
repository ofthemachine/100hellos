# adder.png

## Description
Piet program that adds two numbers provided as input

## Usage
```bash
echo "32 54" | ./piet test_images/adder.png 1
```

## Parameters
- **Image**: `test_images/adder.png`
- **Codel size**: `1`
- **Input**: Two numbers separated by space (e.g., "32 54")

## Expected Output
```
86
```
(The sum of the two input numbers)

## Notes
- Interactive program that reads two numbers from stdin
- Uses codel size 1 (single pixel codels)
- Demonstrates input/output operations in Piet
- Part of the original frank-zago test suite