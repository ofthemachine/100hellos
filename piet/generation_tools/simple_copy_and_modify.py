#!/usr/bin/env python3
"""
SIMPLE COPY AND MODIFY

Copy the exact working frankzago_hello.png and make the most minimal change:
Just reduce the light_red region from 119 pixels to 87 pixels in a way that preserves execution flow.
"""

from PIL import Image
import subprocess

def copy_and_modify_precisely():
    """Copy frankzago and make minimal targeted modification"""

    print("🔄 SIMPLE COPY AND MODIFY")
    print("Making the most minimal change possible")
    print("="*50)

    # Load the working original
    original = Image.open('../files/test_images/frankzago_hello.png')
    width, height = original.size
    print(f"Original size: {width}x{height}")

    # Create exact copy
    modified = original.copy()

    # Find all light_red pixels (the 'w' block)
    light_red = (255, 192, 192)
    w_pixels = []

    for y in range(height):
        for x in range(width):
            if original.getpixel((x, y)) == light_red:
                w_pixels.append((x, y))

    print(f"Found {len(w_pixels)} light_red pixels (should be 119)")

    if len(w_pixels) != 119:
        print(f"❌ Expected 119, got {len(w_pixels)}")
        return False

    # Strategy: Only convert the rightmost/bottommost 32 pixels to white
    # This should preserve the connectivity at the "start" of the block

    # Sort pixels by position (rightmost and bottommost first)
    w_pixels_sorted = sorted(w_pixels, key=lambda p: (p[1], p[0]), reverse=True)

    # Convert the last 32 pixels to white
    pixels_to_convert = w_pixels_sorted[:32]

    print(f"Converting {len(pixels_to_convert)} pixels to white")
    print(f"Keeping {len(w_pixels) - len(pixels_to_convert)} pixels as light_red")
    print(f"First few to convert: {pixels_to_convert[:5]}")
    print(f"Last few to keep: {w_pixels_sorted[32:37]}")

    # Convert to white
    for x, y in pixels_to_convert:
        modified.putpixel((x, y), (255, 255, 255))  # white

    # Save
    modified.save('SIMPLE_COPY_MODIFIED.png')
    print("💾 Saved: SIMPLE_COPY_MODIFIED.png")

    return True

def test_simple_modification():
    """Test the simple modification"""

    print(f"\n🧪 TESTING SIMPLE MODIFICATION")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', 'SIMPLE_COPY_MODIFIED.png', '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == "Hello World!":
            print("🎉 SUCCESS! Simple modification worked!")
            return True
        elif output == "Hello world!":
            print("🔧 Still lowercase w, need to adjust further")
            return False
        elif "Hello" in output and len(output) < 50:
            print(f"🔧 Close! Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")

            # Quick debug
            print("\n🔍 Quick debug check:")
            debug_result = subprocess.run(['../files/piet', 'SIMPLE_COPY_MODIFIED.png', '1', '--debug'],
                                        capture_output=True, text=True, timeout=10)

            # Look for the W character specifically
            if 'push (block size: 87)' in debug_result.stderr:
                print("  ✅ Found 87-pixel block (W)")
            else:
                print("  ❌ No 87-pixel block found")

            if 'Output char: W' in debug_result.stderr:
                print("  ✅ Found W output")
            else:
                print("  ❌ No W output found")

            return False
        else:
            print(f"❌ Unexpected output (length: {len(output)})")
            if len(output) < 100:
                print(f"   '{output}'")
            else:
                print(f"   '{output[:100]}...'")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def try_different_reduction_strategies():
    """Try different ways of reducing the block size"""

    print("\n🔬 TRYING DIFFERENT REDUCTION STRATEGIES")
    print("="*60)

    original = Image.open('../files/test_images/frankzago_hello.png')
    light_red = (255, 192, 192)

    # Get all light_red pixels
    w_pixels = []
    for y in range(original.height):
        for x in range(original.width):
            if original.getpixel((x, y)) == light_red:
                w_pixels.append((x, y))

    strategies = [
        ("bottom_right", lambda p: (-p[1], -p[0])),  # bottom-right first
        ("top_left", lambda p: (p[1], p[0])),        # top-left first
        ("center_out", lambda p: abs(p[0] - 15) + abs(p[1] - 23)),  # center outward
    ]

    for name, sort_key in strategies:
        print(f"\n--- Strategy: {name} ---")

        modified = original.copy()
        sorted_pixels = sorted(w_pixels, key=sort_key, reverse=True)

        # Remove 32 pixels
        for x, y in sorted_pixels[:32]:
            modified.putpixel((x, y), (255, 255, 255))

        filename = f'STRATEGY_{name}.png'
        modified.save(filename)

        # Test
        try:
            result = subprocess.run(['../files/piet', filename, '1'],
                                  capture_output=True, text=True, timeout=5)
            output = result.stdout.strip()

            if len(output) > 50:
                print(f"  Result: (too long, {len(output)} chars)")
            else:
                print(f"  Result: '{output}'")

            if output == "Hello World!":
                print(f"  🎉 SUCCESS with {name} strategy!")
                return filename

        except subprocess.TimeoutExpired:
            print(f"  Timeout with {name}")
        except Exception as e:
            print(f"  Error with {name}: {e}")

    return None

if __name__ == "__main__":
    print("🚀 SIMPLE COPY AND MODIFY APPROACH")
    print("Minimal change to working program")
    print()

    success = copy_and_modify_precisely()

    if success:
        result = test_simple_modification()

        if result:
            print("\n" + "="*60)
            print("🎉 SIMPLE MODIFICATION SUCCESS!")
            print("✅ Perfect 'Hello World!' achieved!")

            # Copy to official location
            import shutil
            shutil.copy('SIMPLE_COPY_MODIFIED.png', '../hello-world.png')
            print("📋 Copied to ../hello-world.png")
            print("🌟 Mission complete!")
        else:
            print("\n🔬 Trying alternative reduction strategies...")
            successful_strategy = try_different_reduction_strategies()

            if successful_strategy:
                print(f"\n🎉 SUCCESS with alternative strategy!")
                import shutil
                shutil.copy(successful_strategy, '../hello-world.png')
                print("📋 Copied to ../hello-world.png")
            else:
                print("\n🔧 All strategies need more work...")
    else:
        print("❌ Could not create modification")