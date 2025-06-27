#!/usr/bin/env python3
"""
FINAL "Hello World!" - EXACT CAPITALIZATION

Based on the debug analysis:
- Original: push 119 → output 'w'
- Needed:   push 87  → output 'W'

Create a linear program following the frankzago pattern.
"""

from PIL import Image
import subprocess

def create_exact_hello_world():
    """Create program that outputs exactly 'Hello World!' with capital W"""

    print("🎯 CREATING EXACT 'Hello World!' PROGRAM")
    print("=" * 50)

    # The exact sequence we need:
    # H(72) e(101) l(108) l(108) o(111) space(32) W(87) o(111) r(114) l(108) d(100) !(33)
    text = "Hello World!"
    ascii_values = [ord(c) for c in text]
    print(f"📝 Target sequence: {text}")
    print(f"📝 ASCII values: {ascii_values}")

    # Create a linear layout like frankzago uses
    img_width = 500  # Wide enough for all blocks
    img_height = 50  # Tall enough
    img = Image.new('RGB', (img_width, img_height), (255, 255, 255))

    # Use simple red-to-dark_red pattern for all characters
    x, y = 0, 0

    for i, ascii_val in enumerate(ascii_values):
        char = text[i]
        print(f"  Creating block for '{char}': {ascii_val} pixels")

        # Create block of red pixels
        for pixel in range(ascii_val):
            if x >= img_width:
                x = 0
                y += 1
                if y >= img_height:
                    print(f"❌ Ran out of space at character {i+1}")
                    return False
            img.putpixel((x, y), (255, 0, 0))  # red
            x += 1

        # Add outchar transition (red to dark_red)
        if x >= img_width:
            x = 0
            y += 1
        img.putpixel((x, y), (192, 0, 0))  # dark_red for outchar
        x += 1

        # Add some spacing between characters
        if x >= img_width:
            x = 0
            y += 1
        x += 1  # white space separator

    # Add termination - black pixel
    if x >= img_width:
        x = 0
        y += 1
    img.putpixel((x, y), (0, 0, 0))  # black

    # Crop to used area
    used_height = y + 2
    img_final = img.crop((0, 0, img_width, used_height))

    # Save the program
    img_final.save('EXACT_HELLO_WORLD_CAPITAL.png')
    print(f"💾 Saved: EXACT_HELLO_WORLD_CAPITAL.png ({img_width}x{used_height})")

    # Test the program
    print("\n📋 Testing the program...")
    try:
        result = subprocess.run(['../files/piet', 'EXACT_HELLO_WORLD_CAPITAL.png', '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"✅ Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Exact 'Hello World!' achieved!")
            print("✅ Capital W confirmed!")
            return True
        else:
            print(f"🔧 Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")

            # Let's check with debug
            print("\n🔍 Debug analysis:")
            debug_result = subprocess.run(['../files/piet', '--debug', 'EXACT_HELLO_WORLD_CAPITAL.png', '1'],
                                        capture_output=True, text=True, timeout=10)
            debug_lines = debug_result.stderr.split('\n')
            for line in debug_lines[:15]:
                if 'push' in line or 'Output char' in line:
                    print(f"  {line}")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Program timed out (infinite loop)")
        return False
    except Exception as e:
        print(f"❌ Error testing program: {e}")
        return False

if __name__ == "__main__":
    print("🚀 FINAL 'Hello World!' CREATOR")
    print("Creating exact capitalization match!")
    print()

    success = create_exact_hello_world()

    if success:
        print("\n" + "=" * 60)
        print("🎉 SUCCESS! EXACT 'Hello World!' COMPLETE!")
        print("✅ Perfect capitalization: Hello World!")
        print("✅ Capital W confirmed")
        print("🌟 100th language specification met exactly!")

        # Copy to the official location
        import shutil
        shutil.copy('EXACT_HELLO_WORLD_CAPITAL.png', '../hello-world.png')
        print("📋 Copied to ../hello-world.png")
        print("🎯 Ready for final integration!")
    else:
        print("\n🔧 Still working on the exact pattern...")
        print("💡 The frank-zago pattern is complex, but we'll get it!")