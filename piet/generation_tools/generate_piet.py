#!/usr/bin/env python3
"""
Generate a working Piet Hello World! program
Based on the research from working examples
"""

from PIL import Image
import subprocess
import sys

# Piet standard colors - exactly as specified in the language
COLORS = {
    'light_red': (255, 192, 192),
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'light_yellow': (255, 255, 192),
    'yellow': (255, 255, 0),
    'dark_yellow': (192, 192, 0),
    'light_green': (192, 255, 192),
    'green': (0, 255, 0),
    'dark_green': (0, 192, 0),
    'light_cyan': (192, 255, 255),
    'cyan': (0, 255, 255),
    'dark_cyan': (0, 192, 192),
    'light_blue': (192, 192, 255),
    'blue': (0, 0, 255),
    'dark_blue': (0, 0, 192),
    'light_magenta': (255, 192, 255),
    'magenta': (255, 0, 255),
    'dark_magenta': (192, 0, 192),
    'white': (255, 255, 255),
    'black': (0, 0, 0),
}

def create_hello_world_program():
    """Create a working Hello World! program using proven pattern"""

    # Create a simple program that outputs "Hello World!"
    # Using the pattern from the research: block size = ASCII value, then push, then output

    # Start with a simple "Hi" program first to verify the pattern works
    img = Image.new('RGB', (80, 20), COLORS['white'])

    # Let's create a very simple program that outputs "H" (72)
    # Using the approach: create blocks and use proper color transitions

    x, y = 2, 2

    # Create block of 72 pixels for 'H' (72)
    # 72 = 8 * 9, so we'll create 8 pixels, push, 9 pixels, push, multiply

    # Block of 8 red pixels (factor 1)
    for i in range(8):
        if x + i < 79:
            img.putpixel((x + i, y), COLORS['red'])
    x += 8

    # Push: transition from red to dark_red (lightness change)
    if x < 79:
        img.putpixel((x, y), COLORS['dark_red'])
    x += 1

    # Block of 9 yellow pixels (factor 2) - hue change from red
    for i in range(9):
        if x + i < 79:
            img.putpixel((x + i, y), COLORS['yellow'])
    x += 9

    # Push: transition from yellow to dark_yellow (lightness change)
    if x < 79:
        img.putpixel((x, y), COLORS['dark_yellow'])
    x += 1

    # Multiply: transition from dark_yellow to green (hue change)
    if x < 79:
        img.putpixel((x, y), COLORS['green'])
    x += 1

    # Output: transition from green to blue (hue change)
    if x < 79:
        img.putpixel((x, y), COLORS['blue'])
    x += 2

    # Now let's add 'i' (105) = 10 * 10 + 5
    # Block of 10 cyan pixels
    for i in range(10):
        if x + i < 79:
            img.putpixel((x + i, y), COLORS['cyan'])
    x += 10

    # Push: transition to dark_cyan
    if x < 79:
        img.putpixel((x, y), COLORS['dark_cyan'])
    x += 1

    # Block of 10 magenta pixels
    for i in range(10):
        if x + i < 79:
            img.putpixel((x + i, y), COLORS['magenta'])
    x += 10

    # Push: transition to dark_magenta
    if x < 79:
        img.putpixel((x, y), COLORS['dark_magenta'])
    x += 1

    # Multiply: transition to light_red
    if x < 79:
        img.putpixel((x, y), COLORS['light_red'])
    x += 1

    # Add 5: create block of 5
    for i in range(5):
        if x + i < 79:
            img.putpixel((x + i, y), COLORS['light_green'])
    x += 5

    # Push
    if x < 79:
        img.putpixel((x, y), COLORS['green'])
    x += 1

    # Add: transition to light_blue
    if x < 79:
        img.putpixel((x, y), COLORS['light_blue'])
    x += 1

    # Output: transition to light_cyan
    if x < 79:
        img.putpixel((x, y), COLORS['light_cyan'])
    x += 1

    # Add black borders to ensure proper termination
    for i in range(80):
        img.putpixel((i, 0), COLORS['black'])
        img.putpixel((i, 19), COLORS['black'])
    for i in range(20):
        img.putpixel((0, i), COLORS['black'])
        img.putpixel((79, i), COLORS['black'])

    # Create termination trap - black square that catches the program
    for i in range(76, 79):
        for j in range(16, 19):
            img.putpixel((i, j), COLORS['black'])

    return img

def test_program(img_path):
    """Test the generated program with npiet"""
    try:
        result = subprocess.run(['npiet', img_path],
                              capture_output=True, text=True, timeout=5)
        return result.stdout, result.stderr, result.returncode
    except subprocess.TimeoutExpired:
        return "", "Program timed out", -1
    except Exception as e:
        return "", str(e), -1

def main():
    print("Generating Piet 'Hi' test program...")

    # Create the program
    img = create_hello_world_program()

    # Save to output directory (will be volume mounted)
    output_path = "hello-world.png"
    img.save(output_path)
    print(f"Saved program to {output_path}")

    # Test the program
    print("Testing program...")
    stdout, stderr, returncode = test_program(output_path)

    print(f"Return code: {returncode}")
    print(f"Output: '{stdout}'")
    if stderr:
        print(f"Error: {stderr}")

    if stdout and len(stdout) > 0:
        print(f"SUCCESS: Program outputs: '{stdout}'")

        # If we get any output, we're on the right track
        # The goal is to get "Hello World!" but let's see what we get
        if "H" in stdout:
            print("Great! The H character is working!")
        if "i" in stdout:
            print("Great! The i character is working!")
    else:
        print("Program produced no output")

        # Create an even simpler test - just output one character
        print("Creating ultra-simple test...")
        simple_img = Image.new('RGB', (15, 10), COLORS['white'])

        # Just try to output ASCII 65 ('A') = 5 * 13
        x, y = 2, 5

        # Block of 5 red pixels
        for i in range(5):
            simple_img.putpixel((x + i, y), COLORS['red'])
        x += 5

        # Push (red to dark_red)
        simple_img.putpixel((x, y), COLORS['dark_red'])
        x += 1

        # Block of 13 yellow pixels
        for i in range(13):
            if x + i < 14:
                simple_img.putpixel((x + i, y), COLORS['yellow'])
        x = 14

        # Push (yellow to dark_yellow)
        if y + 1 < 9:
            simple_img.putpixel((x - 1, y + 1), COLORS['dark_yellow'])

        # Multiply (change hue)
        if y + 1 < 9:
            simple_img.putpixel((x - 2, y + 1), COLORS['green'])

        # Output (change hue)
        if y + 1 < 9:
            simple_img.putpixel((x - 3, y + 1), COLORS['blue'])

        simple_output_path = "hello-world-simple.png"
        simple_img.save(simple_output_path)
        print(f"Created simple test program: {simple_output_path}")

if __name__ == "__main__":
    main()