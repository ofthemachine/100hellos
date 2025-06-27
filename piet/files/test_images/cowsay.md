# cowsay.png

## Description
Piet program that implements a cowsay-like function, displaying input text with ASCII art

## Usage
```bash
echo "It's alive." | ./piet test_images/cowsay.png 1
```

## Parameters
- **Image**: `test_images/cowsay.png`
- **Codel size**: `1`
- **Input**: Text string (e.g., "It's alive.")

## Expected Output
```
[Expected: ASCII art with the input text displayed]
```

## Notes
- Interactive program that reads text from stdin
- Uses codel size 1 (single pixel codels)
- Complex program demonstrating advanced Piet programming
- Part of the original frank-zago test suite
- Timeout set to 10 seconds due to complexity