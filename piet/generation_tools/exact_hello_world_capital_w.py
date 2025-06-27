#!/usr/bin/env python3
"""
EXACT "Hello World!" CREATOR

Fix the capitalization: "Hello world!" → "Hello World!"
Need to change 'w' (ASCII 119) to 'W' (ASCII 87) = reduce by 32 pixels
"""

from PIL import Image
import subprocess

def analyze_and_fix_capitalization():
    """Analyze frankzago structure and create exact 'Hello World!' version"""

    print("🎯 CREATING EXACT 'Hello World!' (CAPITAL W)")
    print("=" * 50)

    # Load the working program
    original = Image.open('../files/test_images/frankzago_hello.png')

    # First, let's run debug to understand the exact structure
    try:
        result = subprocess.run(['../files/piet', '--debug', '../files/test_images/frankzago_hello.png', '1'],
                              capture_output=True, text=True, timeout=10)

        print("📋 Analyzing character sequence...")
        lines = result.stderr.split('\n')

        # Find the sequence: H-e-l-l-o-space-w-o-r-l-d-!
        push_blocks = []
        for line in lines:
            if 'push (block size:' in line:
                size = int(line.split('block size: ')[1].split(')')[0])
                push_blocks.append(size)
                if len(push_blocks) <= 12:  # Track first 12 characters
                    char = chr(size) if 32 <= size <= 126 else f"({size})"
                    print(f"  Block {len(push_blocks)}: {size} pixels → '{char}'")

        print(f"\n📋 Original output: '{result.stdout.strip()}'")

        # Find the 'w' block (should be block #7: "Hello w...")
        if len(push_blocks) >= 7:
            w_block_size = push_blocks[6]  # 0-indexed, so 6th = 7th character
            print(f"\n💡 Found 'w' block: {w_block_size} pixels (ASCII {w_block_size})")
            print(f"   Need 'W' instead: ASCII 87")
            print(f"   Difference: {w_block_size - 87} pixels to remove")

            if w_block_size == 119:  # Confirm it's 'w'
                return create_modified_program(original, w_block_size - 87)
            else:
                print(f"❌ Unexpected: Expected 119 for 'w', got {w_block_size}")
                return False
        else:
            print("❌ Could not find character sequence")
            return False

    except Exception as e:
        print(f"❌ Analysis error: {e}")
        return False

def create_modified_program(original_img, pixels_to_reduce):
    """Create modified program by reducing specific block by pixels_to_reduce"""

    print(f"\n🔧 MODIFYING PROGRAM: Reducing block by {pixels_to_reduce} pixels")

    # For now, let's use a simpler approach: create a new program that pushes 'W' instead of 'w'
    # Using the frankzago pattern but with corrected values

    width, height = 200, 20  # Sufficient space
    img = Image.new('RGB', (width, height), (255, 255, 255))  # White background

    x, y = 0, 0

    # Character sequence for "Hello World!"
    text = "Hello World!"
    ascii_values = [ord(c) for c in text]
    print(f"📝 Target ASCII values: {ascii_values}")

    colors = [
        (255, 0, 0),    # red
        (255, 0, 255),  # magenta
        (0, 255, 0),    # green
        (0, 255, 255),  # cyan
        (0, 0, 255),    # blue
        (255, 255, 0),  # yellow
    ]

    color_idx = 0

    for i, ascii_val in enumerate(ascii_values):
        print(f"  Char {i+1}: '{text[i]}' = ASCII {ascii_val}")

        # Create block of pixels for this character
        current_color = colors[color_idx % len(colors)]
        for pixel in range(ascii_val):
            if x >= width:
                x = 0
                y += 1
                if y >= height:
                    break
            img.putpixel((x, y), current_color)
            x += 1

        # Add transition pixel for outchar (darker version)
        if x >= width:
            x = 0
            y += 1
        dark_color = tuple(max(0, c - 64) for c in current_color)
        img.putpixel((x, y), dark_color)
        x += 1

        color_idx += 1

    # Add termination (black pixel)
    if x >= width:
        x = 0
        y += 1
    img.putpixel((x, y), (0, 0, 0))

    # Crop to actual used size
    used_height = y + 1
    img = img.crop((0, 0, width, used_height))

    img.save('HELLO_WORLD_CAPITAL_W.png')
    print(f"💾 Saved: HELLO_WORLD_CAPITAL_W.png ({width}x{used_height})")

    # Test the new program
    print("📋 Testing new program...")
    try:
        result = subprocess.run(['../files/piet', 'HELLO_WORLD_CAPITAL_W.png', '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"✅ Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Exact capitalization achieved!")
            return True
        else:
            print(f"🔧 Got: '{output}', wanted: 'Hello World!'")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 EXACT 'Hello World!' CREATOR")
    print("Fixing capitalization to match your specification!")
    print()

    success = analyze_and_fix_capitalization()

    if success:
        print("\n" + "=" * 50)
        print("✅ SUCCESS! Created EXACT 'Hello World!' program")
        print("🎯 Perfect capitalization achieved!")
        print("📝 Output: 'Hello World!' (capital W)")
        print("🌟 100th language specification met exactly!")
    else:
        print("\n❌ Need to debug further - will analyze the working pattern")