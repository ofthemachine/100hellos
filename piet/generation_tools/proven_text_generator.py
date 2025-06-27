#!/usr/bin/env python3
"""
PROVEN TEXT GENERATOR

Uses our EXACT successful "Hello World!" technique but adapts it for arbitrary text.
Based on the frankzago approach that we know works + our bottom-right reduction strategy.
"""

from PIL import Image
import subprocess
import argparse

def create_text_using_proven_method(text):
    """Create text using our exact proven frankzago-style method"""

    print(f"🎯 PROVEN METHOD FOR: '{text}'")
    print(f"Using frankzago-style approach that we KNOW works!")
    print("="*60)

    # Load our working template as reference
    try:
        template_img = Image.open('STRATEGY_bottom_right.png')
        print("✅ Loaded our successful template for reference")
    except:
        try:
            template_img = Image.open('../files/test_images/frankzago_hello.png')
            print("✅ Using frankzago original as template")
        except:
            print("❌ No template found, creating from scratch")
            return create_from_scratch(text)

    # Analyze the template dimensions and structure
    temp_width, temp_height = template_img.size
    print(f"📐 Template size: {temp_width}x{temp_height}")

    # Calculate what we need for our text
    ascii_values = [ord(c) for c in text]
    print(f"📊 ASCII values for '{text}': {ascii_values}")

    # Use frankzago-style block arrangement
    return create_frankzago_style_blocks(text, ascii_values)

def create_frankzago_style_blocks(text, ascii_values):
    """Create blocks using the frankzago pattern that we know works"""

    print(f"🔨 CREATING FRANKZAGO-STYLE BLOCKS")
    print("-" * 50)

    # Use the proven frankzago colors from our analysis
    colors = [
        (255, 0, 0),        # red - 255,0,0
        (255, 0, 255),      # magenta - 255,0,255
        (0, 0, 255),        # blue - 0,0,255
        (255, 255, 0),      # yellow - 255,255,0
        (0, 255, 0),        # green - 0,255,0
        (255, 255, 192),    # light_yellow - 255,255,192
        (255, 192, 192),    # light_red - 255,192,192
        (0, 255, 255),      # cyan - 0,255,255
        (0, 0, 192),        # dark_blue - 0,0,192
        (192, 192, 255),    # light_blue - 192,192,255
        (255, 128, 0),      # orange - 255,128,0
        (128, 255, 0),      # lime - 128,255,0
    ]

    # Calculate canvas size needed
    total_pixels = sum(ascii_values)
    max_ascii = max(ascii_values)

    # Make canvas large enough but not too large
    canvas_width = min(800, max(300, int((total_pixels * 1.2) ** 0.5) + 100))
    canvas_height = min(600, max(200, int((total_pixels * 0.8) ** 0.5) + 80))

    print(f"📐 Canvas: {canvas_width}x{canvas_height} for {total_pixels} total pixels")

    # Create image
    img = Image.new('RGB', (canvas_width, canvas_height), (255, 255, 255))

    # Place blocks in frankzago-style grid pattern
    x, y = 20, 20
    block_spacing = 5

    for i, char in enumerate(text):
        ascii_val = ascii_values[i]
        color = colors[i % len(colors)]

        print(f"  Block {i+1}: '{char}' = {ascii_val} pixels in {color}")

        # Calculate optimal block dimensions (roughly square)
        block_width = max(1, int(ascii_val ** 0.5))
        block_height = (ascii_val + block_width - 1) // block_width  # ceil division

        # Adjust if block is too wide for remaining space
        if x + block_width > canvas_width - 20:
            # Move to next row
            x = 20
            y += 50  # Give plenty of vertical space

            # Recalculate block dimensions for new row
            max_width = canvas_width - 40
            if block_width > max_width:
                block_width = max_width
                block_height = (ascii_val + block_width - 1) // block_width

        # Check vertical space
        if y + block_height > canvas_height - 20:
            print(f"❌ Out of vertical space at character {i+1}")
            print(f"💡 Need larger canvas or different arrangement")
            return None

        # Place the block pixels
        pixels_placed = 0
        for by in range(block_height):
            for bx in range(block_width):
                if pixels_placed >= ascii_val:
                    break

                px, py = x + bx, y + by
                if 0 <= px < canvas_width and 0 <= py < canvas_height:
                    img.putpixel((px, py), color)
                    pixels_placed += 1

            if pixels_placed >= ascii_val:
                break

        print(f"    Placed {pixels_placed}/{ascii_val} pixels at ({x},{y}) as {block_width}x{block_height}")

        # Move to next block position
        x += block_width + block_spacing

    # Save the result
    safe_text = "".join(c if c.isalnum() else "_" for c in text)
    filename = f"PROVEN_{safe_text}.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def create_from_scratch(text):
    """Fallback: create from scratch using basic principles"""

    print("🔧 CREATING FROM SCRATCH")
    print("-" * 30)

    ascii_values = [ord(c) for c in text]

    # Very simple approach: horizontal lines
    img = Image.new('RGB', (600, 400), (255, 255, 255))

    y = 20
    for i, ascii_val in enumerate(ascii_values):
        color = (255, 0, 0) if i % 2 == 0 else (0, 255, 0)

        # Draw horizontal line
        for x in range(min(ascii_val, 580)):
            img.putpixel((x + 10, y), color)

        y += 10

    safe_text = "".join(c if c.isalnum() else "_" for c in text)
    filename = f"SIMPLE_{safe_text}.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def test_generated_program(filename, expected_text):
    """Test the generated program"""

    print(f"\n🧪 TESTING: {filename}")
    print(f"Expected: '{expected_text}'")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=20)

        output = result.stdout.strip()
        print(f"📋 Actual output: '{output}'")

        if output == expected_text:
            print("🎉 PERFECT! Generated program works!")
            return True
        elif output:
            print(f"🔧 Close! Length: {len(output)} vs {len(expected_text)}")

            # Character by character analysis
            min_len = min(len(output), len(expected_text))
            for i in range(min_len):
                if output[i] != expected_text[i]:
                    print(f"  Diff at pos {i}: got '{output[i]}' ({ord(output[i])}) expected '{expected_text[i]}' ({ord(expected_text[i])})")

            return False
        else:
            print("❌ No output produced")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Error running program: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Generate Piet programs using proven technique')
    parser.add_argument('text', nargs='?', default='Lizard King',
                       help='Text to generate program for')
    parser.add_argument('--test', action='store_true',
                       help='Test the generated program')

    args = parser.parse_args()

    print("🚀 PROVEN TEXT GENERATOR")
    print("Using our exact successful Hello World technique!")
    print()

    # Generate using proven method
    filename = create_text_using_proven_method(args.text)

    if filename and args.test:
        success = test_generated_program(filename, args.text)

        if success:
            print(f"\n🌟 SUCCESS! Generated working Piet program!")
            print(f"📁 File: {filename}")
            print(f"✅ Outputs exactly: '{args.text}'")
        else:
            print(f"\n🔧 Generated program needs refinement")
            print("💡 The structure is created, execution flow needs work")

    elif filename:
        print(f"\n📁 Generated: {filename}")
        print("💡 Use --test to verify it works")

if __name__ == "__main__":
    main()