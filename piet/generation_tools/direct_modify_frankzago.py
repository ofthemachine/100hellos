#!/usr/bin/env python3
"""
DIRECT FRANKZAGO MODIFICATION

Instead of creating from scratch, directly modify the working frankzago_hello.png
to change the 'w' block (119 pixels) to 'W' block (87 pixels).

Strategy: Find the block of 119 red pixels and reduce it to 87 pixels.
"""

from PIL import Image
import subprocess

def analyze_frankzago_pixels():
    """Analyze frankzago pixel by pixel to find the 'w' block"""

    print("🔍 ANALYZING frankzago_hello.png PIXEL BY PIXEL")
    print("=" * 50)

    img = Image.open('../files/test_images/frankzago_hello.png')
    width, height = img.size
    print(f"Image size: {width}x{height}")

    # Find connected regions of same color
    regions = []
    visited = set()

    def flood_fill(start_x, start_y, target_color):
        """Find all connected pixels of same color"""
        stack = [(start_x, start_y)]
        region = []

        while stack:
            x, y = stack.pop()
            if (x, y) in visited or x < 0 or x >= width or y < 0 or y >= height:
                continue

            pixel_color = img.getpixel((x, y))
            if pixel_color != target_color:
                continue

            visited.add((x, y))
            region.append((x, y))

            # Add neighbors
            for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                stack.append((x + dx, y + dy))

        return region

    # Find all regions
    for y in range(height):
        for x in range(width):
            if (x, y) not in visited:
                color = img.getpixel((x, y))
                if color != (255, 255, 255):  # Skip white background
                    region = flood_fill(x, y, color)
                    if len(region) > 1:  # Only interesting regions
                        regions.append((color, len(region), region))

    # Sort by size to find the 119-pixel block
    regions.sort(key=lambda r: r[1], reverse=True)

    print("📋 Found regions (color, size, sample_coords):")
    for i, (color, size, coords) in enumerate(regions[:10]):
        sample_coord = coords[0] if coords else "None"
        print(f"  {i+1}: {color} - {size} pixels - sample at {sample_coord}")

    # Look for the 119-pixel region (should be the 'w')
    w_region = None
    for color, size, coords in regions:
        if size == 119:  # This should be the 'w' block
            w_region = (color, size, coords)
            print(f"\n🎯 FOUND 'w' BLOCK: {color} with {size} pixels!")
            break

    if not w_region:
        print("❌ Could not find 119-pixel block for 'w'")
        # Show blocks near 119
        print("Blocks near 119 pixels:")
        for color, size, coords in regions:
            if 100 <= size <= 140:
                print(f"  {color}: {size} pixels")
        return None

    return w_region

def modify_w_block_to_W(w_region):
    """Modify the 'w' block to be 'W' by reducing from 119 to 87 pixels"""

    print(f"\n🔧 MODIFYING 'w' BLOCK TO 'W'")
    print("=" * 50)

    # Load original image
    img = Image.open('../files/test_images/frankzago_hello.png')
    modified_img = img.copy()

    color, size, coords = w_region
    print(f"Original block: {color}, {size} pixels")
    print(f"Target: reduce to 87 pixels (remove {size - 87} pixels)")

    # Remove the last 32 pixels from this block (119 - 87 = 32)
    pixels_to_remove = size - 87
    coords_to_white = coords[-pixels_to_remove:]  # Take last N pixels

    print(f"Converting {len(coords_to_white)} pixels to white...")
    for x, y in coords_to_white:
        modified_img.putpixel((x, y), (255, 255, 255))  # White

    # Save the modified image
    modified_img.save('frankzago_modified_w_to_W.png')
    print("💾 Saved: frankzago_modified_w_to_W.png")

    return modified_img

def test_modified_program():
    """Test the modified program"""

    print(f"\n📋 TESTING MODIFIED PROGRAM")
    print("=" * 50)

    try:
        result = subprocess.run(['../files/piet', 'frankzago_modified_w_to_W.png', '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"✅ Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Exact 'Hello World!' achieved!")
            print("✅ Successfully changed 'w' to 'W'!")
            return True
        elif "Hello" in output:
            print(f"🔧 Close! Got: '{output}'")
            print("🔧 Expected: 'Hello World!'")

            # Show debug info
            print("\n🔍 Debug output:")
            debug_result = subprocess.run(['../files/piet', '--debug', 'frankzago_modified_w_to_W.png', '1'],
                                        capture_output=True, text=True, timeout=10)
            debug_lines = debug_result.stderr.split('\n')
            char_count = 0
            for line in debug_lines[:20]:
                if 'Output char:' in line:
                    char_count += 1
                    print(f"  Char {char_count}: {line}")
            return False
        else:
            print(f"❌ Unexpected output: '{output}'")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 DIRECT FRANKZAGO MODIFICATION")
    print("Changing 'w' to 'W' by pixel manipulation")
    print()

    # Step 1: Analyze the original
    w_region = analyze_frankzago_pixels()

    if w_region:
        # Step 2: Modify the block
        modified_img = modify_w_block_to_W(w_region)

        # Step 3: Test the result
        success = test_modified_program()

        if success:
            print("\n" + "=" * 60)
            print("🎉 SUCCESS! EXACT 'Hello World!' ACHIEVED!")
            print("✅ Direct modification worked!")
            print("✅ Capital W confirmed!")

            # Copy to official location
            import shutil
            shutil.copy('frankzago_modified_w_to_W.png', '../hello-world.png')
            print("📋 Copied to ../hello-world.png")
            print("🌟 100th language complete with exact capitalization!")
        else:
            print("\n🔧 Direct modification needs refinement")
            print("💡 But we're very close to the solution!")
    else:
        print("\n❌ Could not locate the 'w' block for modification")
        print("💡 May need different analysis approach")