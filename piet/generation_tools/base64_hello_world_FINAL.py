#!/usr/bin/env python3
"""
FINAL CONSOLIDATION: Base64 Hello World Piet Generator

Applying all learnings from 50+ attempts:
1. Base64 encoding simplifies character range (43-122 vs 32-126)
2. Use proven working pattern: [N pixels] -> [transition] -> [output]
3. Focus on clean termination
4. Build from minimal working case

Goal: Create Piet program that outputs base64 of "Hello World!"
"""

from PIL import Image
import base64

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

def create_base64_hello_world():
    """Create Piet program that outputs base64 encoded 'Hello World!'"""

    # Step 1: Get base64 encoding
    original_text = "Hello World!"
    base64_text = base64.b64encode(original_text.encode()).decode()
    ascii_values = [ord(c) for c in base64_text]

    print(f"Original: '{original_text}'")
    print(f"Base64: '{base64_text}'")
    print(f"Length: {len(base64_text)} chars")
    print(f"ASCII values: {ascii_values}")
    print(f"Range: {min(ascii_values)} - {max(ascii_values)}")

    # Step 2: Calculate image dimensions
    # Need space for all blocks + transitions + termination
    total_pixels_needed = sum(ascii_values) + len(ascii_values)  # blocks + transitions
    width = 50  # Make it wide enough
    height = (total_pixels_needed // width) + 5  # Add buffer

    print(f"Creating {width}x{height} image")
    print(f"Total pixels needed: ~{total_pixels_needed}")

    # Step 3: Create image with white background
    img = Image.new('RGB', (width, height), COLORS['white'])

    # Step 4: Build the program using proven pattern
    # [N pixels of color] -> [1 transition pixel] -> outputs ASCII(N)

    x, y = 0, 0

    # Color sequence for variety (hue changes trigger different operations)
    color_sequence = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
    transition_sequence = ['dark_red', 'dark_yellow', 'dark_green', 'dark_cyan', 'dark_blue', 'dark_magenta']

    for i, ascii_val in enumerate(ascii_values):
        # Choose colors for this character
        color = color_sequence[i % len(color_sequence)]
        transition = transition_sequence[i % len(transition_sequence)]

        print(f"Char {i+1}: '{base64_text[i]}' (ASCII {ascii_val}) -> {ascii_val} {color} pixels + {transition} transition")

        # Place N pixels of the main color
        pixels_placed = 0
        while pixels_placed < ascii_val:
            if x >= width:
                x = 0
                y += 1
                if y >= height:
                    print("ERROR: Image too small!")
                    break

            img.putpixel((x, y), COLORS[color])
            x += 1
            pixels_placed += 1

        # Place transition pixel (triggers outchar)
        if x >= width:
            x = 0
            y += 1

        if y < height:
            img.putpixel((x, y), COLORS[transition])
            x += 1

    # Step 5: Add termination area (black border)
    # Fill remaining space with white, then add black border
    for border_y in range(height):
        for border_x in range(width):
            if border_x == 0 or border_x == width-1 or border_y == 0 or border_y == height-1:
                img.putpixel((border_x, border_y), COLORS['black'])

    return img, base64_text

def create_minimal_test():
    """Create minimal test - just first 4 chars of base64"""

    base64_text = "SGVs"  # First 4 chars of base64("Hello World!")
    ascii_values = [ord(c) for c in base64_text]

    print(f"MINIMAL TEST: '{base64_text}'")
    print(f"ASCII values: {ascii_values}")

    # Much smaller image for testing
    width, height = 20, 15
    img = Image.new('RGB', (width, height), COLORS['white'])

    x, y = 1, 1  # Start away from border

    colors = ['red', 'yellow', 'green', 'cyan']
    transitions = ['dark_red', 'dark_yellow', 'dark_green', 'dark_cyan']

    for i, ascii_val in enumerate(ascii_values):
        color = colors[i]
        transition = transitions[i]

        print(f"'{base64_text[i]}' = {ascii_val} {color} pixels -> {transition}")

        # Place main block
        for _ in range(ascii_val):
            if x >= width - 1:  # Leave room for border
                x = 1
                y += 1
            img.putpixel((x, y), COLORS[color])
            x += 1

        # Place transition
        if x >= width - 1:
            x = 1
            y += 1
        img.putpixel((x, y), COLORS[transition])
        x += 1

    # Add black border for termination
    for border_y in range(height):
        for border_x in range(width):
            if border_x == 0 or border_x == width-1 or border_y == 0 or border_y == height-1:
                img.putpixel((border_x, border_y), COLORS['black'])

    return img

if __name__ == "__main__":
    print("=== BASE64 HELLO WORLD PIET GENERATOR ===")
    print()

    # Create minimal test first
    print("1. Creating MINIMAL TEST (first 4 chars)...")
    minimal_img = create_minimal_test()
    minimal_img.save('base64_minimal_test.png')
    print("   Saved: base64_minimal_test.png")
    print()

    # Create full version
    print("2. Creating FULL BASE64 version...")
    full_img, base64_text = create_base64_hello_world()
    full_img.save('base64_hello_world_FINAL.png')
    print(f"   Saved: base64_hello_world_FINAL.png")
    print()

    print("=== TESTING INSTRUCTIONS ===")
    print("1. Test minimal version first:")
    print("   ../files/piet --debug base64_minimal_test.png 1")
    print()
    print("2. If that works, test full version:")
    print("   ../files/piet --debug base64_hello_world_FINAL.png 1")
    print()
    print(f"3. Expected output for full version: '{base64_text}'")
    print()
    print("🎯 SUCCESS = Base64 breakthrough validated!")
    print("🚀 NEXT = Add visual artistry while preserving function!")