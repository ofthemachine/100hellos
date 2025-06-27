#!/usr/bin/env python3
"""
ZIGZAG CHAIN ENCODER

Create a functional "chain" of blocks that zigzags across the image,
then add beautiful artistic elements around the functional chain.

This creates digital artifacts that are:
- Functional programs (execute base64 output)
- Data storage (encoded source code)
- Visual art (beautiful themed decorations)
"""

from PIL import Image
import subprocess
import base64
import random

def create_zigzag_chain(content, img_width=200, img_height=150):
    """Create a zigzag chain of functional blocks"""

    print("🔗 CREATING ZIGZAG FUNCTIONAL CHAIN")
    print("="*60)

    # Encode the content
    b64_encoded = base64.b64encode(content.encode()).decode()
    print(f"📝 Original: {content}")
    print(f"🔐 Base64:   {b64_encoded}")
    print(f"📊 Length:   {len(b64_encoded)} characters")

    # Create image with white background
    img = Image.new('RGB', (img_width, img_height), (255, 255, 255))

    # Define the functional chain colors
    red = (255, 0, 0)      # push blocks
    dark_red = (192, 0, 0) # outchar blocks
    black = (0, 0, 0)      # barriers/termination

    # Zigzag parameters
    chain_start_x = 10
    chain_start_y = 10
    chain_width = img_width - 20  # leave margins for art
    row_height = 8  # height of each zigzag row

    x, y = chain_start_x, chain_start_y
    direction = 1  # 1 = right, -1 = left

    print(f"\n🔨 Building zigzag chain:")

    for i, char in enumerate(b64_encoded):
        ascii_val = ord(char)
        print(f"  {i+1}: '{char}' = {ascii_val} pixels")

        # Create the push block (ascii_val pixels)
        block_pixels_placed = 0
        block_start_x, block_start_y = x, y

        for pixel in range(ascii_val):
            # Check if we need to wrap to next row
            if (direction == 1 and x >= chain_start_x + chain_width) or \
               (direction == -1 and x <= chain_start_x):
                # Move to next row and flip direction
                y += row_height
                direction *= -1
                if direction == 1:
                    x = chain_start_x
                else:
                    x = chain_start_x + chain_width - 1

                # Check bounds
                if y >= img_height - 20:
                    print(f"❌ Out of vertical space at character {i+1}")
                    return None, None

            # Place pixel
            if 0 <= x < img_width and 0 <= y < img_height:
                img.putpixel((x, y), red)
                block_pixels_placed += 1

            x += direction

            if block_pixels_placed >= ascii_val:
                break

        # Add outchar transition
        if 0 <= x < img_width and 0 <= y < img_height:
            img.putpixel((x, y), dark_red)
        x += direction

        # Small gap between characters
        x += direction

    # Add termination
    if 0 <= x < img_width and 0 <= y < img_height:
        img.putpixel((x, y), black)

    # Calculate chain bounds for artistic decoration
    chain_bounds = {
        'min_x': chain_start_x - 5,
        'max_x': chain_start_x + chain_width + 5,
        'min_y': chain_start_y - 5,
        'max_y': y + row_height + 5
    }

    print(f"✅ Chain complete! Bounds: {chain_bounds}")

    return img, chain_bounds

def add_artistic_decoration(img, chain_bounds, theme="programming"):
    """Add beautiful artistic elements around the functional chain"""

    print(f"\n🎨 ADDING ARTISTIC DECORATION: {theme}")
    print("="*50)

    width, height = img.size

    # Define artistic colors based on theme
    if theme == "programming":
        colors = [
            (100, 149, 237),  # cornflower blue
            (72, 61, 139),    # dark slate blue
            (123, 104, 238),  # medium slate blue
            (147, 112, 219),  # medium purple
            (138, 43, 226),   # blue violet
        ]
    elif theme == "nature":
        colors = [
            (34, 139, 34),    # forest green
            (107, 142, 35),   # olive drab
            (154, 205, 50),   # yellow green
            (50, 205, 50),    # lime green
            (0, 128, 0),      # green
        ]
    elif theme == "sunset":
        colors = [
            (255, 69, 0),     # red orange
            (255, 140, 0),    # dark orange
            (255, 165, 0),    # orange
            (255, 215, 0),    # gold
            (255, 255, 0),    # yellow
        ]
    else:  # default
        colors = [
            (128, 128, 255),  # light blue
            (255, 128, 128),  # light red
            (128, 255, 128),  # light green
            (255, 255, 128),  # light yellow
            (255, 128, 255),  # light magenta
        ]

    # Add decorative elements in non-functional areas
    print("  Creating decorative patterns...")

    # Top decoration
    for y in range(0, chain_bounds['min_y']):
        for x in range(0, width):
            if random.random() < 0.3:  # 30% fill rate
                color = random.choice(colors)
                img.putpixel((x, y), color)

    # Bottom decoration
    for y in range(chain_bounds['max_y'], height):
        for x in range(0, width):
            if random.random() < 0.3:
                color = random.choice(colors)
                img.putpixel((x, y), color)

    # Left side decoration
    for y in range(chain_bounds['min_y'], chain_bounds['max_y']):
        for x in range(0, chain_bounds['min_x']):
            if random.random() < 0.4:
                color = random.choice(colors)
                img.putpixel((x, y), color)

    # Right side decoration
    for y in range(chain_bounds['min_y'], chain_bounds['max_y']):
        for x in range(chain_bounds['max_x'], width):
            if random.random() < 0.4:
                color = random.choice(colors)
                img.putpixel((x, y), color)

    # Add some geometric patterns
    print("  Adding geometric patterns...")

    # Corner decorations
    corner_size = 20
    for corner_x, corner_y in [(0, 0), (width-corner_size, 0),
                              (0, height-corner_size), (width-corner_size, height-corner_size)]:
        for y in range(corner_y, min(corner_y + corner_size, height)):
            for x in range(corner_x, min(corner_x + corner_size, width)):
                if (x + y) % 3 == 0:  # diagonal pattern
                    color = random.choice(colors)
                    img.putpixel((x, y), color)

    print("  ✅ Artistic decoration complete!")

    return img

def create_digital_artifact(content, theme="programming", filename_prefix="DIGITAL_ARTIFACT"):
    """Create a complete digital artifact: functional + artistic"""

    print("🌟 CREATING DIGITAL ARTIFACT")
    print("="*60)

    # Create the functional chain
    img, chain_bounds = create_zigzag_chain(content)

    if img is None:
        print("❌ Failed to create functional chain")
        return None

    # Add artistic decoration
    img = add_artistic_decoration(img, chain_bounds, theme)

    # Save the artifact
    filename = f"{filename_prefix}_{theme}.png"
    img.save(filename)
    print(f"\n💾 Saved digital artifact: {filename}")

    return filename

def test_digital_artifact(filename, expected_content):
    """Test that the digital artifact functions correctly"""

    print(f"\n🧪 TESTING DIGITAL ARTIFACT: {filename}")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=15)

        output = result.stdout.strip()
        expected_b64 = base64.b64encode(expected_content.encode()).decode()

        print(f"📋 Output length: {len(output)}")

        if output == expected_b64:
            print("🎉 PERFECT! Digital artifact works!")
            print(f"🔓 Contains: '{expected_content}'")
            print("✅ Functional program ✅ Data storage ✅ Visual art")
            return True
        else:
            print(f"🔧 Expected base64: {expected_b64}")
            if len(output) < 100:
                print(f"🔧 Got: {output}")
            else:
                print(f"🔧 Got: {output[:50]}...{output[-20:]}")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout - execution issues")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 ZIGZAG CHAIN DIGITAL ARTIFACT CREATOR")
    print("Creating beautiful functional art!")
    print()

    # Test with simple content first
    test_content = "Hello!"

    print("🧪 Testing with simple content...")
    artifact_file = create_digital_artifact(test_content, "programming", "TEST_ARTIFACT")

    if artifact_file:
        success = test_digital_artifact(artifact_file, test_content)

        if success:
            print("\n" + "="*60)
            print("🎉 ZIGZAG CHAIN SUCCESS!")
            print("✅ Functional zigzag chain works!")
            print("✅ Artistic decoration applied!")
            print("✅ Digital artifact created!")
            print("🌟 Ready to create themed collections!")

            # Create a few themed examples
            print("\n🎨 Creating themed examples...")

            examples = [
                ("Python rules!", "programming"),
                ("Nature code", "nature"),
                ("Sunset data", "sunset")
            ]

            for content, theme in examples:
                print(f"\n  Creating {theme} themed artifact...")
                example_file = create_digital_artifact(content, theme, f"EXAMPLE_{theme.upper()}")
                if example_file:
                    print(f"    ✅ {example_file} created!")

        else:
            print("\n🔧 Zigzag chain needs refinement...")
            print("💡 But the concept is sound!")
    else:
        print("❌ Could not create artifact")