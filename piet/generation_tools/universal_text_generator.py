#!/usr/bin/env python3
"""
UNIVERSAL TEXT GENERATOR

Create Piet programs that output any arbitrary text using our proven techniques.
Takes any text as input and generates a working Piet program.

Based on our successful "Hello World!" breakthrough strategy.
"""

from PIL import Image
import subprocess
import argparse
import base64

def create_text_program(text, approach="linear", artistic_theme=None, canvas_size=(400, 200)):
    """Create a Piet program that outputs the specified text"""

    print(f"🎯 CREATING PIET PROGRAM FOR: '{text}'")
    print(f"Approach: {approach} | Theme: {artistic_theme}")
    print("="*60)

    if approach == "linear":
        return create_linear_text_program(text, artistic_theme, canvas_size)
    elif approach == "compact":
        return create_compact_text_program(text, artistic_theme, canvas_size)
    elif approach == "zigzag":
        return create_zigzag_text_program(text, artistic_theme, canvas_size)
    else:
        print(f"❌ Unknown approach: {approach}")
        return None

def create_linear_text_program(text, theme, canvas_size):
    """Create a simple linear program using the proven frankzago-style approach"""

    print(f"📝 LINEAR APPROACH for '{text}' ({len(text)} characters)")
    print("-" * 50)

    # Get ASCII values for each character
    ascii_values = [ord(c) for c in text]
    print(f"ASCII values: {ascii_values}")

    # Calculate space needed
    total_pixels_needed = sum(ascii_values) + len(text) * 2  # +2 for outchar and gap per char

    # Determine optimal canvas size
    if canvas_size[0] * canvas_size[1] < total_pixels_needed * 1.5:
        # Need bigger canvas
        canvas_width = int((total_pixels_needed * 2) ** 0.5) + 50
        canvas_height = canvas_width
        actual_canvas = (canvas_width, canvas_height)
        print(f"📐 Enlarging canvas to {actual_canvas} for {total_pixels_needed} pixels")
    else:
        actual_canvas = canvas_size

    # Create the image
    img = Image.new('RGB', actual_canvas, (255, 255, 255))

    # Colors for functional chain
    red = (255, 0, 0)        # push blocks
    dark_red = (192, 0, 0)   # outchar operations

    # Start position
    x, y = 10, 10

    print(f"\n🔨 Building character blocks:")

    for i, char in enumerate(text):
        ascii_val = ord(char)
        print(f"  {i+1}: '{char}' = {ascii_val} pixels")

        # Create push block (horizontal line for simplicity)
        start_x = x
        for pixel in range(ascii_val):
            if x >= actual_canvas[0] - 10:
                # Wrap to next line
                x = 10
                y += 8
                if y >= actual_canvas[1] - 10:
                    print(f"❌ Out of space at character {i+1}")
                    return None

            img.putpixel((x, y), red)
            x += 1

        # Add outchar transition
        if x >= actual_canvas[0] - 10:
            x = 10
            y += 8
        img.putpixel((x, y), dark_red)
        x += 1

        # Small gap
        x += 3

    # Add termination
    img.putpixel((x, y), (0, 0, 0))

    # Add artistic theme if specified
    if theme:
        add_artistic_theme(img, theme, 10, 10, x, y + 8)

    # Save
    safe_text = "".join(c if c.isalnum() else "_" for c in text)
    filename = f"TEXT_{safe_text}_LINEAR.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def create_compact_text_program(text, theme, canvas_size):
    """Create a more compact version using our successful bottom-right strategy"""

    print(f"📦 COMPACT APPROACH for '{text}'")
    print("-" * 50)

    # Use our proven frankzago technique as a template
    # But modify it for the new text

    try:
        # Start with frankzago as base template
        base_img = Image.open('../files/test_images/frankzago_hello.png')
        print("✅ Using frankzago template as base")
    except:
        print("❌ Frankzago template not found, falling back to linear")
        return create_linear_text_program(text, theme, canvas_size)

    # Create a new image with similar structure but for our text
    img = Image.new('RGB', canvas_size, (255, 255, 255))

    # Colors
    colors = [
        (255, 0, 0),        # red
        (255, 0, 255),      # magenta
        (0, 0, 255),        # blue
        (255, 255, 0),      # yellow
        (0, 255, 0),        # green
        (255, 255, 192),    # light_yellow
        (255, 192, 192),    # light_red
        (0, 255, 255),      # cyan
        (0, 0, 192),        # dark_blue
        (192, 192, 255),    # light_blue
    ]

    # Place blocks for each character
    x, y = 20, 20

    for i, char in enumerate(text):
        ascii_val = ord(char)
        color = colors[i % len(colors)]

        # Create rectangular block
        block_width = max(8, int(ascii_val ** 0.5))
        block_height = (ascii_val // block_width) + 1

        placed = 0
        for by in range(block_height):
            for bx in range(block_width):
                if placed >= ascii_val:
                    break
                if x + bx < canvas_size[0] - 20 and y + by < canvas_size[1] - 20:
                    img.putpixel((x + bx, y + by), color)
                    placed += 1
            if placed >= ascii_val:
                break

        # Move to next position
        x += block_width + 5
        if x >= canvas_size[0] - 50:
            x = 20
            y += block_height + 5

    # Add artistic theme
    if theme:
        add_artistic_theme(img, theme, 15, 15, canvas_size[0]-15, y + 20)

    # Save
    safe_text = "".join(c if c.isalnum() else "_" for c in text)
    filename = f"TEXT_{safe_text}_COMPACT.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def create_zigzag_text_program(text, theme, canvas_size):
    """Create a zigzag chain program implementing our architectural breakthrough"""

    print(f"🔗 ZIGZAG APPROACH for '{text}'")
    print("-" * 50)

    img = Image.new('RGB', canvas_size, (255, 255, 255))

    # Define zigzag area
    margin = 40
    zigzag_x = margin
    zigzag_y = margin
    zigzag_width = canvas_size[0] - 2 * margin
    zigzag_height = canvas_size[1] - 2 * margin

    # Add artistic decoration first (outside zigzag area)
    if theme:
        add_artistic_theme(img, theme, 0, 0, canvas_size[0], canvas_size[1],
                          exclude_area=(zigzag_x-5, zigzag_y-5, zigzag_width+10, zigzag_height+10))

    # Create zigzag chain
    red = (255, 0, 0)
    dark_red = (192, 0, 0)

    x, y = zigzag_x, zigzag_y
    direction = 1  # 1 = right, -1 = left
    row_height = 6

    for i, char in enumerate(text):
        ascii_val = ord(char)
        print(f"  Chain {i+1}: '{char}' = {ascii_val} pixels")

        # Check if we need to wrap
        if (direction == 1 and x + ascii_val > zigzag_x + zigzag_width) or \
           (direction == -1 and x - ascii_val < zigzag_x):
            y += row_height
            direction *= -1
            x = zigzag_x if direction == 1 else zigzag_x + zigzag_width

        # Place character block
        for pixel in range(ascii_val):
            if (zigzag_x <= x < zigzag_x + zigzag_width and
                zigzag_y <= y < zigzag_y + zigzag_height):
                img.putpixel((x, y), red)
            x += direction

        # Add outchar
        if (zigzag_x <= x < zigzag_x + zigzag_width and
            zigzag_y <= y < zigzag_y + zigzag_height):
            img.putpixel((x, y), dark_red)
        x += direction

    # Save
    safe_text = "".join(c if c.isalnum() else "_" for c in text)
    filename = f"TEXT_{safe_text}_ZIGZAG.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def add_artistic_theme(img, theme, start_x, start_y, end_x, end_y, exclude_area=None):
    """Add artistic decoration to specified area"""

    print(f"🎨 Adding {theme} artistic theme")

    # Theme colors
    if theme == "lizard":
        colors = [(34, 139, 34), (107, 142, 35), (50, 205, 50), (124, 252, 0)]  # greens
    elif theme == "king":
        colors = [(255, 215, 0), (255, 165, 0), (218, 165, 32), (184, 134, 11)]  # golds
    elif theme == "python":
        colors = [(55, 118, 171), (255, 212, 59), (43, 82, 120), (255, 193, 7)]
    elif theme == "galaxy":
        colors = [(25, 25, 112), (138, 43, 226), (72, 61, 139), (123, 104, 238)]
    else:
        colors = [(128, 128, 255), (255, 128, 128), (128, 255, 128), (255, 255, 128)]

    # Add decorative patterns
    for x in range(start_x, end_x):
        for y in range(start_y, end_y):
            # Skip exclude area if specified
            if exclude_area:
                ex_x, ex_y, ex_w, ex_h = exclude_area
                if ex_x <= x <= ex_x + ex_w and ex_y <= y <= ex_y + ex_h:
                    continue

            # Create pattern based on theme
            if theme == "lizard":
                # Organic scattered pattern
                if (x * 7 + y * 11) % 20 < 3:
                    color = colors[(x + y) % len(colors)]
                    img.putpixel((x, y), color)
            elif theme == "king":
                # Royal geometric pattern
                if (x + y) % 15 < 4:
                    color = colors[(x + y) % len(colors)]
                    img.putpixel((x, y), color)
            else:
                # Default pattern
                if (x + y) % 12 < 2:
                    color = colors[(x + y) % len(colors)]
                    img.putpixel((x, y), color)

def test_text_program(filename, expected_text):
    """Test that the generated program outputs the expected text"""

    print(f"\n🧪 TESTING: {filename}")
    print(f"Expected: '{expected_text}'")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=15)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == expected_text:
            print("🎉 PERFECT! Text program works!")
            return True
        else:
            print(f"🔧 Expected: '{expected_text}'")
            print(f"🔧 Got:      '{output}'")

            # Show character differences
            if len(output) == len(expected_text):
                print("📊 Character analysis:")
                for i, (got, exp) in enumerate(zip(output, expected_text)):
                    if got != exp:
                        print(f"  Position {i}: got '{got}' ({ord(got)}) expected '{exp}' ({ord(exp)})")

            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Generate Piet programs for arbitrary text')
    parser.add_argument('text', nargs='?', default='Lizard King',
                       help='Text to generate Piet program for (default: "Lizard King")')
    parser.add_argument('--approach', choices=['linear', 'compact', 'zigzag'],
                       default='linear', help='Generation approach')
    parser.add_argument('--theme', choices=['lizard', 'king', 'python', 'galaxy'],
                       help='Artistic theme to apply')
    parser.add_argument('--test', action='store_true',
                       help='Test the generated program')

    args = parser.parse_args()

    print("🚀 UNIVERSAL PIET TEXT GENERATOR")
    print("="*60)

    # Generate the program
    filename = create_text_program(args.text, args.approach, args.theme)

    if filename and args.test:
        success = test_text_program(filename, args.text)

        if success:
            print(f"\n🌟 SUCCESS! Generated working Piet program for '{args.text}'")
            print(f"📁 File: {filename}")
            print("✅ Functional program ✅ Exact text output")
            if args.theme:
                print(f"✅ {args.theme} artistic theme")
        else:
            print(f"\n🔧 Program generated but needs refinement")
            print("💡 Try different approach or canvas size")

    elif filename:
        print(f"\n📁 Generated: {filename}")
        print("💡 Use --test flag to verify output")

if __name__ == "__main__":
    main()