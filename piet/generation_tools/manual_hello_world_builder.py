#!/usr/bin/env python3
"""
MANUAL "Hello World!" BUILDER

Manually recreate the exact frankzago structure pixel by pixel,
but with W(87) instead of w(119).
"""

from PIL import Image
import subprocess

def create_manual_hello_world():
    """Manually build Hello World! following frankzago pattern exactly"""

    print("🔨 MANUAL HELLO WORLD BUILDER")
    print("Replicating frankzago structure with W instead of w")
    print("="*60)

    # Create exact size image like frankzago
    img = Image.new('RGB', (30, 29), (255, 255, 255))  # white background

    # Define Piet colors
    red = (255, 0, 0)
    dark_red = (192, 0, 0)
    magenta = (255, 0, 255)
    dark_magenta = (192, 0, 192)
    blue = (0, 0, 255)
    cyan = (0, 255, 255)
    yellow = (255, 255, 0)
    green = (0, 255, 0)
    light_blue = (192, 192, 255)
    dark_blue = (0, 0, 192)
    light_red = (255, 192, 192)
    light_yellow = (255, 255, 192)
    black = (0, 0, 0)

    def put_block(start_x, start_y, width, height, color, size_needed):
        """Put a block of specific color and verify size"""
        pixels_placed = 0
        for y in range(start_y, start_y + height):
            for x in range(start_x, start_x + width):
                if x < 30 and y < 29:  # bounds check
                    img.putpixel((x, y), color)
                    pixels_placed += 1
                if pixels_placed >= size_needed:
                    return pixels_placed
        return pixels_placed

    def put_rectangular_block(start_x, start_y, color, size_needed):
        """Put a roughly rectangular block of exact size"""
        placed = 0
        # Try to make roughly square
        width = int(size_needed ** 0.5) + 1
        height = (size_needed // width) + 1

        for y in range(start_y, start_y + height):
            for x in range(start_x, start_x + width):
                if placed >= size_needed:
                    break
                if x < 30 and y < 29:  # bounds check
                    img.putpixel((x, y), color)
                    placed += 1
            if placed >= size_needed:
                break
        return placed, width, height

    # Build the program manually
    # H = 72 pixels (red)
    print("Creating H block (72 pixels)...")
    placed, w, h = put_rectangular_block(0, 0, red, 72)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x, current_y = w, 0

    # outchar transition
    img.putpixel((current_x, current_y), dark_red)
    current_x += 1

    # e = 101 pixels (magenta)
    print("Creating e block (101 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, magenta, 101)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # outchar transition
    img.putpixel((current_x, current_y), dark_magenta)
    current_x += 1

    # l = 108 pixels (blue)
    print("Creating l block (108 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, blue, 108)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # Move to next row for more space
    current_x = 0
    current_y = max(current_y + h + 1, 10)

    # l = 108 pixels (reuse - dup operation in original)
    # For simplicity, create another 108 block
    print("Creating second l block (108 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, yellow, 108)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # outchar transition
    img.putpixel((current_x, current_y), dark_red)
    current_x += 1

    # o = 111 pixels (green)
    print("Creating o block (111 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, green, 111)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # space = 32 pixels (light_yellow)
    print("Creating space block (32 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, light_yellow, 32)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # Move to next row again
    current_x = 0
    current_y = max(current_y + h + 1, 18)

    # *** KEY CHANGE: W = 87 pixels (not 119) ***
    print("Creating W block (87 pixels) - THE KEY CHANGE!")
    placed, w, h = put_rectangular_block(current_x, current_y, light_red, 87)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # outchar transition
    img.putpixel((current_x, current_y), dark_red)
    current_x += 1

    # o = 111 pixels (reuse from stack)
    print("Creating second o block (111 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, cyan, 111)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # r = 114 pixels (dark_blue)
    print("Creating r block (114 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, dark_blue, 114)
    print(f"  Placed {placed} pixels in {w}x{h} area")

    # Move to final row
    current_x = 0
    current_y = max(current_y + h + 1, 25)

    # l = 108 pixels (reuse)
    print("Creating final l block (108 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, light_blue, 108)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # d = 100 pixels
    print("Creating d block (100 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, magenta, 100)
    print(f"  Placed {placed} pixels in {w}x{h} area")
    current_x += w

    # ! = 33 pixels
    print("Creating ! block (33 pixels)...")
    placed, w, h = put_rectangular_block(current_x, current_y, yellow, 33)
    print(f"  Placed {placed} pixels in {w}x{h} area")

    # Add some black termination pixels
    img.putpixel((29, 28), black)

    # Save
    img.save('MANUAL_HELLO_WORLD.png')
    print("\n💾 Saved: MANUAL_HELLO_WORLD.png")

    return True

def test_manual_program():
    """Test the manually created program"""

    print(f"\n🧪 TESTING MANUAL PROGRAM")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', 'MANUAL_HELLO_WORLD.png', '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Manual construction succeeded!")
            return True
        elif "Hello" in output:
            print(f"🔧 Close! Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")

            # Show debug
            print("\n🔍 Debug trace:")
            debug_result = subprocess.run(['../files/piet', 'MANUAL_HELLO_WORLD.png', '1', '--debug'],
                                        capture_output=True, text=True, timeout=10)

            lines = debug_result.stderr.split('\n')
            char_outputs = [line for line in lines if 'Output char:' in line]
            for i, line in enumerate(char_outputs):
                print(f"  {i+1}: {line}")

            return False
        else:
            print(f"❌ Unexpected output: '{output}'")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 MANUAL HELLO WORLD BUILDER")
    print("Building from scratch with exact specifications")
    print()

    success = create_manual_hello_world()

    if success:
        result = test_manual_program()

        if result:
            print("\n" + "="*60)
            print("🎉 MANUAL CONSTRUCTION SUCCESS!")
            print("✅ Perfect 'Hello World!' with capital W!")
            print("🎯 Built from scratch successfully!")

            # Copy to official location
            import shutil
            shutil.copy('MANUAL_HELLO_WORLD.png', '../hello-world.png')
            print("📋 Copied to ../hello-world.png")
            print("🌟 Mission accomplished!")
        else:
            print("\n🔧 Manual construction needs refinement...")
            print("💡 But we're creating the blocks correctly!")