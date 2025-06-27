#!/usr/bin/env python3

from PIL import Image

# Piet colors - we'll use basic ones
# Red hue family: light red (255,192,192), red (255,0,0), dark red (192,0,0)
light_red = (255, 192, 192)
red = (255, 0, 0)
dark_red = (192, 0, 0)

# Green hue family for output command
light_green = (192, 255, 192)
green = (0, 255, 0)

# Black for termination
black = (0, 0, 0)
white = (255, 255, 255)

def create_simple_h_program():
    """
    Create a simple Piet program that outputs 'H' and terminates.

    The program structure:
    1. A block of 72 pixels (ASCII value of 'H') in light red
    2. A single pixel in red (darker shade) to push the value
    3. A single pixel in light green (one hue left) to output character
    4. Black pixels for termination trap
    """

    # Create a simple 10x10 image (100 pixels total)
    width, height = 10, 10
    img = Image.new('RGB', (width, height), white)
    pixels = img.load()

    # Create a block of 72 pixels for ASCII 'H'
    # We'll make an 8x9 rectangle (72 pixels) in light red
    count = 0
    for y in range(height):
        for x in range(width):
            if count < 72:
                pixels[x, y] = light_red
                count += 1
            elif count == 72:
                # Push command (darker shade)
                pixels[x, y] = red
                count += 1
            elif count == 73:
                # Output command (one hue to the left)
                pixels[x, y] = light_green
                count += 1
            else:
                # Termination trap - surround with black
                pixels[x, y] = black

    return img

def create_minimal_h_program():
    """
    Create an even simpler version - just the essential blocks.
    """
    # Create a minimal 12x6 image
    width, height = 12, 6
    img = Image.new('RGB', (width, height), white)
    pixels = img.load()

    # Fill first 72 pixels with light red (H = ASCII 72)
    count = 0
    for y in range(height):
        for x in range(width):
            if count < 72:
                pixels[x, y] = light_red
                count += 1
            elif x == 0 and y == height - 1:
                # Push command (darker shade) at position after the 72-pixel block
                pixels[x, y] = red
            elif x == 1 and y == height - 1:
                # Output command (one hue to the left)
                pixels[x, y] = light_green
            else:
                # Create termination by surrounding remaining area with black
                pixels[x, y] = black

    return img

# Create both versions
simple_h = create_simple_h_program()
minimal_h = create_minimal_h_program()

# Save as PNG (better compatibility than GIF)
simple_h.save('hello-h-simple.png')
minimal_h.save('hello-h-minimal.png')

print("Created two Piet programs:")
print("1. hello-h-simple.png - 10x10 version")
print("2. hello-h-minimal.png - 12x6 version")
print("Both should output 'H' and terminate")