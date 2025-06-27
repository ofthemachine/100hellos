#!/usr/bin/env python3
"""
Create exact "Hello World!" with capital W

Based on frankzago pattern analysis:
H(72) e(101) l(108) l(108) o(111) space(32) W(87) o(111) r(114) l(108) d(100) !(33)

The key change: w(119) → W(87) (change block size from 119 to 87)
"""

from PIL import Image
import subprocess

def create_hello_world_capital():
    """Create simple linear program outputting 'Hello World!' with capital W"""

    # Target sequence: "Hello World!"
    ascii_values = [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]  # W = 87, not w = 119

    print(f"🎯 Creating 'Hello World!' program")
    print(f"📝 ASCII values: {ascii_values}")

    # Use the simplest possible approach: red blocks for push, dark_red for outchar
    # Layout: [red_block_72][dark_red][red_block_101][dark_red]...

    img_width = 600
    img_height = 100
    img = Image.new('RGB', (img_width, img_height), (255, 255, 255))  # white background

    x, y = 0, 0

    for i, ascii_val in enumerate(ascii_values):
        char = chr(ascii_val)
        print(f"  Block {i+1}: '{char}' = {ascii_val} pixels")

        # Create red block of exactly ascii_val pixels
        for pixel in range(ascii_val):
            if x >= img_width:
                x = 0
                y += 1
                if y >= img_height:
                    print(f"❌ Out of space")
                    return False

            img.putpixel((x, y), (255, 0, 0))  # red
            x += 1

        # Add dark_red pixel for outchar operation
        if x >= img_width:
            x = 0
            y += 1

        img.putpixel((x, y), (192, 0, 0))  # dark_red (triggers outchar)
        x += 1

        # Small gap between characters
        x += 1

    # Add termination black pixel
    if x >= img_width:
        x = 0
        y += 1
    img.putpixel((x, y), (0, 0, 0))  # black

    # Crop to used area
    used_height = y + 2
    img_cropped = img.crop((0, 0, img_width, used_height))

    # Save
    filename = 'HELLO_WORLD_CAPITAL_W.png'
    img_cropped.save(filename)
    print(f"💾 Saved: {filename} ({img_width}x{used_height})")

    # Test
    print(f"\n🧪 Testing {filename}...")
    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == "Hello World!":
            print("🎉 SUCCESS! Perfect 'Hello World!' with capital W!")
            return True
        else:
            print(f"🔧 Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")

            # Debug
            print("\n🔍 Debug trace:")
            debug_result = subprocess.run(['../files/piet', filename, '1', '--debug'],
                                        capture_output=True, text=True, timeout=10)
            lines = debug_result.stderr.split('\n')
            for line in lines[:20]:
                if 'push' in line or 'Output char' in line:
                    print(f"  {line}")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout (infinite loop)")
        return False
    except Exception as e:
        print(f"❌ Test error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 HELLO WORLD CAPITAL W GENERATOR")
    print("Creating exact 'Hello World!' output")
    print()

    success = create_hello_world_capital()

    if success:
        print("\n" + "="*50)
        print("🎉 MISSION ACCOMPLISHED!")
        print("✅ 'Hello World!' with capital W created!")
        print("🎯 Exact specification met!")

        # Copy to the main location
        import shutil
        shutil.copy('HELLO_WORLD_CAPITAL_W.png', '../hello-world.png')
        print("📋 Copied to ../hello-world.png")
    else:
        print("\n🔧 Need to debug the execution flow...")