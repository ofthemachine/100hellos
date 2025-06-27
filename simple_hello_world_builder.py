#!/usr/bin/env python3

from PIL import Image, ImageDraw
import os

# Our exact color definitions from piet.go
COLORS = {
    'light_red': (255, 192, 192),     # 0
    'light_yellow': (255, 255, 192),  # 1
    'light_green': (192, 255, 192),   # 2
    'light_cyan': (192, 255, 255),    # 3
    'light_blue': (192, 192, 255),    # 4
    'light_magenta': (255, 192, 255), # 5
    'red': (255, 0, 0),               # 6
    'yellow': (255, 255, 0),          # 7
    'green': (0, 255, 0),             # 8
    'cyan': (0, 255, 255),            # 9
    'blue': (0, 0, 255),              # 10
    'magenta': (255, 0, 255),         # 11
    'dark_red': (192, 0, 0),          # 12
    'dark_yellow': (192, 192, 0),     # 13
    'dark_green': (0, 192, 0),        # 14
    'dark_cyan': (0, 192, 192),       # 15
    'dark_blue': (0, 0, 192),         # 16
    'dark_magenta': (192, 0, 192),    # 17
    'white': (255, 255, 255),         # 18
    'black': (0, 0, 0),               # 19
}

def create_hello_world_program():
    """
    Create a simple Piet program that outputs "Hello World!"

    String: "Hello World!"
    ASCII: [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]

    Strategy: Use the proven pattern from working examples:
    - Block of N pixels pushes N
    - Transition to different lightness = outchar
    - Design spatial layout for clean termination
    """

    # Target string ASCII values
    target = "Hello World!"
    ascii_vals = [ord(c) for c in target]
    print(f"Target ASCII values: {ascii_vals}")

    # Create a simple linear program
    # Each character: block of N pixels -> outchar transition

    width = 20  # Start with reasonable width
    height = len(ascii_vals) + 2  # Height for each character + termination

    # Create image
    img = Image.new('RGB', (width, height), COLORS['white'])

    # Build program row by row
    for i, ascii_val in enumerate(ascii_vals):
        y = i

        # Create block of ascii_val pixels (horizontal line)
        pixels_needed = ascii_val

        if pixels_needed > width - 2:  # Need to fit in width with border
            # Use arithmetic: smaller blocks that multiply/add to target
            # For simplicity, let's try a different approach
            pass

        # For now, create blocks directly where possible
        if pixels_needed <= width - 2:
            # Fill pixels_needed pixels with same color
            color = COLORS['red']  # Use red for push blocks
            for x in range(1, min(pixels_needed + 1, width - 1)):
                img.putpixel((x, y), color)

            # Add outchar transition (red -> dark_red)
            if pixels_needed + 1 < width - 1:
                img.putpixel((pixels_needed + 1, y), COLORS['dark_red'])

    # Add black borders for containment
    for x in range(width):
        img.putpixel((x, 0), COLORS['black'])  # Top border
        img.putpixel((x, height - 1), COLORS['black'])  # Bottom border

    for y in range(height):
        img.putpixel((0, y), COLORS['black'])  # Left border
        img.putpixel((width - 1, y), COLORS['black'])  # Right border

    return img

def create_arithmetic_hello_world():
    """
    Create a more sophisticated version using arithmetic for large ASCII values
    """

    target = "Hello World!"
    ascii_vals = [ord(c) for c in target]

    # Create a wider canvas for arithmetic operations
    width = 30
    height = 15

    img = Image.new('RGB', (width, height), COLORS['white'])

    # Start with a simple test - just output 'H' (72)
    # Strategy: 8 * 9 = 72

    row = 1

    # Push 8 (block of 8 red pixels)
    for x in range(1, 9):
        img.putpixel((x, row), COLORS['red'])

    # Push 9 (transition to different color, block of 9)
    for x in range(9, 18):
        img.putpixel((x, row), COLORS['yellow'])  # Different hue = push

    row += 1

    # Multiply operation (yellow -> green = mult)
    img.putpixel((1, row), COLORS['green'])

    # Output character (green -> dark_green = outchar)
    img.putpixel((2, row), COLORS['dark_green'])

    # Add borders
    for x in range(width):
        img.putpixel((x, 0), COLORS['black'])
        img.putpixel((x, height - 1), COLORS['black'])

    for y in range(height):
        img.putpixel((0, y), COLORS['black'])
        img.putpixel((width - 1, y), COLORS['black'])

    return img

def main():
    print("Creating simple Hello World Piet program...")

    # Try the arithmetic approach first (more likely to work)
    img = create_arithmetic_hello_world()
    img.save('test_hello_world.png')
    print("Created test_hello_world.png")

    # Also create the direct approach
    img2 = create_hello_world_program()
    img2.save('direct_hello_world.png')
    print("Created direct_hello_world.png")

if __name__ == "__main__":
    main()