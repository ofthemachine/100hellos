# Piet Test Images Documentation

This directory contains various Piet programs for testing the interpreter implementation.

## Quick Start
For a fast overview, run the quick test suite:
```bash
make quick-test
```

## Test Categories

### Original Frank-Zago Repository Images
These images **MUST work** as they are from the reference implementation:

| Image | Codel Size | Description | Documentation |
|-------|------------|-------------|---------------|
| `hw4-1.gif` | 1 | Hello, world! | [hw4-1.md](hw4-1.md) |
| `hw1-11.gif` | 11 | Hello, world! (large) | [hw1-11.md](hw1-11.md) |
| `hw3-5.gif` | 5 | Hello, world! (medium) | - |
| `hw6_big.png` | 5 | Hello, world! (big) | [hw6_big.md](hw6_big.md) |
| `hi.png` | 16 | Simple "Hi" output | [hi.md](hi.md) |
| `tetris.png` | 1 | Outputs "Tetris" | [tetris.md](tetris.md) |
| `helloworld-mondrian.png` | 1 | Mondrian-style Hello World | - |
| `helloworld-piet.gif` | 1 | Classic Piet Hello World | - |

### Interactive Programs (Require Input)
| Image | Codel Size | Description | Documentation |
|-------|------------|-------------|---------------|
| `adder.png` | 1 | Adds two numbers | [adder.md](adder.md) |
| `power2.png` | 1 | Calculates powers | [power2.md](power2.md) |
| `euclid_clint_big.png` | 10 | GCD algorithm | [euclid_clint_big.md](euclid_clint_big.md) |
| `piet_factorial.png` | 1 | Factorial calculation | [piet_factorial.md](piet_factorial.md) |
| `cowsay.png` | 1 | ASCII art output | [cowsay.md](cowsay.md) |

### Complex Programs
| Image | Codel Size | Description | Documentation |
|-------|------------|-------------|---------------|
| `99bottles.png` | 1 | 99 Bottles song | [99bottles.md](99bottles.md) |

### Additional Hello World Variants
| Image | Codel Size | Description | Documentation |
|-------|------------|-------------|---------------|
| `progopedia_hello_basic.png` | 1 | Basic Hello World | [progopedia_hello_basic.md](progopedia_hello_basic.md) |
| `progopedia_hello_decorative.png` | 1 | Decorative Hello World | - |
| `frankzago_hello.png` | 1 | Frank-Zago Hello | - |
| `frankzago_hi.png` | 16 | Frank-Zago Hi | - |
| `our_hello_world.png` | 1 | Our Hello World | - |
| `our_hello_world_artistic.png` | 1 | Artistic Hello World | - |
| `esolangs_hello_world.gif` | 1 | Esolangs Hello World | - |
| `thomas_schoch_hello.gif` | 1 | Thomas Schoch Hello | - |

## Usage Examples

### Simple Output Programs
```bash
# Basic Hello World programs
./piet test_images/hw4-1.gif 1
./piet test_images/progopedia_hello_basic.png 1
./piet test_images/hi.png 16
./piet test_images/tetris.png 1
```

### Interactive Programs
```bash
# Math operations
echo "32 54" | ./piet test_images/adder.png 1
echo "12 3" | ./piet test_images/power2.png 1
echo "12" | ./piet test_images/piet_factorial.png 1
echo "10 6" | ./piet test_images/euclid_clint_big.png 10

# Text processing
echo "It's alive." | ./piet test_images/cowsay.png 1
```

### Complex Programs
```bash
# Long-running programs (use timeout)
timeout 30 ./piet test_images/99bottles.png 1
```

## Test Suites

Run predefined test suites from the Makefile:

```bash
# Quick tests of most reliable programs
make quick-test

# Test all original frank-zago images
make test-original

# Test hello world variants
make test-hello

# Test generated images
make test-generated

# Run all tests
make test
```

## Debugging

For detailed execution information, use the debug flag:
```bash
./piet --debug test_images/hi.png 16
```

## Notes

- **Codel Size**: This parameter indicates the size of each color block in pixels. For example, codel size 16 means each logical Piet "pixel" is represented as a 16×16 block in the image.
- **Timeouts**: Complex programs may require timeouts to prevent infinite loops.
- **Input Format**: Interactive programs typically expect input from stdin, often numbers separated by spaces or newlines.
- **Exit Codes**: Programs should exit with code 0 on success, or 1 on error/timeout.