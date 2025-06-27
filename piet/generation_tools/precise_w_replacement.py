#!/usr/bin/env python3
"""
PRECISE 'w' TO 'W' REPLACEMENT

Instead of removing pixels randomly, find the exact light_red block (119 pixels)
and replace it with a properly sized block (87 pixels) while maintaining connectivity.
"""

from PIL import Image
import subprocess

def find_w_block_region():
    """Find the exact coordinates of the 'w' block"""

    img = Image.open('../files/test_images/frankzago_hello.png')
    width, height = img.size

    # Find all light_red pixels (255, 192, 192)
    light_red_pixels = []
    for y in range(height):
        for x in range(width):
            if img.getpixel((x, y)) == (255, 192, 192):
                light_red_pixels.append((x, y))

    print(f"Found {len(light_red_pixels)} light_red pixels")
    print(f"First few: {light_red_pixels[:10]}")

    # Find bounding box
    if light_red_pixels:
        min_x = min(x for x, y in light_red_pixels)
        max_x = max(x for x, y in light_red_pixels)
        min_y = min(y for x, y in light_red_pixels)
        max_y = max(y for x, y in light_red_pixels)
        print(f"Bounding box: ({min_x},{min_y}) to ({max_x},{max_y})")
        print(f"Dimensions: {max_x-min_x+1} x {max_y-min_y+1}")

    return light_red_pixels

def create_precise_replacement():
    """Create exact replacement with 87 pixels instead of 119"""

    print("🎯 CREATING PRECISE 'W' REPLACEMENT")
    print("="*50)

    # Load original
    img = Image.open('../files/test_images/frankzago_hello.png')
    modified = img.copy()

    # Find the light_red region (119 pixels for 'w')
    w_pixels = find_w_block_region()

    if len(w_pixels) != 119:
        print(f"❌ Expected 119 light_red pixels, found {len(w_pixels)}")
        return False

    # Strategy: keep the first 87 pixels, turn the rest to white
    # This maintains connectivity at the start of the block
    pixels_to_keep = w_pixels[:87]
    pixels_to_remove = w_pixels[87:]

    print(f"Keeping first {len(pixels_to_keep)} pixels")
    print(f"Removing last {len(pixels_to_remove)} pixels")

    # Turn the excess pixels to white
    for x, y in pixels_to_remove:
        modified.putpixel((x, y), (255, 255, 255))  # white

    # Save
    modified.save('PRECISE_W_REPLACEMENT.png')
    print("💾 Saved: PRECISE_W_REPLACEMENT.png")

    return True

def test_replacement():
    """Test the precise replacement"""

    print(f"\n🧪 TESTING PRECISE REPLACEMENT")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', 'PRECISE_W_REPLACEMENT.png', '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Exact 'Hello World!' achieved!")
            return True
        else:
            print(f"🔧 Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")

            # Debug the W part specifically
            print("\n🔍 Debug trace (looking for W):")
            debug_result = subprocess.run(['../files/piet', 'PRECISE_W_REPLACEMENT.png', '1', '--debug'],
                                        capture_output=True, text=True, timeout=10)

            lines = debug_result.stderr.split('\n')
            for i, line in enumerate(lines):
                if 'push' in line and '87' in line:
                    print(f"  Found W push: {line}")
                    if i+1 < len(lines):
                        print(f"  Next: {lines[i+1]}")
                elif 'Output char: W' in line:
                    print(f"  ✅ Found W output: {line}")
                elif 'Output char:' in line:
                    char = line.split('Output char: ')[1].split(' ')[0] if 'Output char:' in line else '?'
                    print(f"  {char}")

            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 PRECISE 'w' TO 'W' REPLACEMENT")
    print("Surgical modification to change exactly 119→87 pixels")
    print()

    success = create_precise_replacement()

    if success:
        result = test_replacement()

        if result:
            print("\n" + "="*60)
            print("🎉 MISSION ACCOMPLISHED!")
            print("✅ Exact 'Hello World!' with capital W!")
            print("🎯 Perfect surgical replacement!")

            # Copy to official location
            import shutil
            shutil.copy('PRECISE_W_REPLACEMENT.png', '../hello-world.png')
            print("📋 Copied to ../hello-world.png")
            print("🌟 100th language milestone achieved!")
        else:
            print("\n🔧 Still working on the precise connectivity...")
    else:
        print("❌ Could not create replacement")