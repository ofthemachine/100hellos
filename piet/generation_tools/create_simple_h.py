#!/usr/bin/env python3

from PIL import Image

def create_minimal_h():
    """
    Create the absolute minimal Piet program to output 'H' based on progopedia example.

    Structure:
    - 72 pixels in one color (ASCII 'H')
    - 1 pixel in darker shade (push command)
    - 1 pixel in different hue (output command)
    - Black termination
    """

    # Colors from Piet specification
    light_red = (255, 192, 192)    # Light hue, light lightness
    red = (255, 0, 0)              # Same hue, normal lightness (darker)
    light_green = (192, 255, 192)  # One hue clockwise, light lightness
    black = (0, 0, 0)

    # Create a 9x9 image (minimal size for 72 + 2 + termination)
    width, height = 9, 9
    img = Image.new('RGB', (width, height), black)
    pixels = img.load()

    # Fill the first 72 positions with light red
    pos = 0
    for y in range(height):
        for x in range(width):
            if pos < 72:
                pixels[x, y] = light_red
                pos += 1
            elif pos == 72:
                # Push command - darker shade of same hue
                pixels[x, y] = red
                pos += 1
            elif pos == 73:
                # Output command - different hue (clockwise)
                pixels[x, y] = light_green
                pos += 1
            else:
                # Already black (termination)
                break

    return img

# Create the program
img = create_minimal_h()
img.save('simple-h.png')

print("Created simple-h.png")
print("This should output 'H' and terminate")