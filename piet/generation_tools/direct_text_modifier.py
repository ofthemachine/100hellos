#!/usr/bin/env python3
"""
DIRECT TEXT MODIFIER

Take our WORKING "Hello World!" image and directly modify the pixel blocks
to output different text. This uses our proven execution flow and just changes
the block sizes to get different ASCII values.

This is the most reliable approach since we KNOW the execution flow works.
"""

from PIL import Image
import subprocess

def modify_working_image_for_text(text):
    """Modify our working Hello World image to output different text"""

    print(f"🎯 MODIFYING WORKING IMAGE FOR: '{text}'")
    print("Using our proven STRATEGY_bottom_right.png as base")
    print("="*60)

    # Load our working image
    try:
        working_img = Image.open('STRATEGY_bottom_right.png')
        print("✅ Loaded working Hello World image")
    except:
        print("❌ Working image not found!")
        return None

    # Get the original text and new text ASCII values
    original_text = "Hello World!"
    original_ascii = [ord(c) for c in original_text]
    new_ascii = [ord(c) for c in text]

    print(f"📊 Original '{original_text}': {original_ascii}")
    print(f"📊 New '{text}': {new_ascii}")

    # Calculate differences
    if len(new_ascii) != len(original_ascii):
        print(f"⚠️  Length mismatch: {len(new_ascii)} vs {len(original_ascii)} characters")
        print("💡 Will truncate or pad as needed")

    # Strategy: Find and modify each character block
    return modify_character_blocks(working_img, original_ascii, new_ascii, text)

def modify_character_blocks(img, original_ascii, new_ascii, text):
    """Modify the character blocks to change ASCII values"""

    print(f"\n🔧 MODIFYING CHARACTER BLOCKS")
    print("-" * 50)

    # Create a copy to work with
    modified_img = img.copy()
    width, height = modified_img.size

    # Analyze the image to find distinct color blocks
    color_blocks = find_color_blocks(modified_img)

    print(f"📊 Found {len(color_blocks)} color blocks in image")

    # Match blocks to characters (assuming order corresponds)
    min_blocks = min(len(color_blocks), len(new_ascii))

    for i in range(min_blocks):
        if i < len(original_ascii):
            original_size = original_ascii[i]
            new_size = new_ascii[i]
            char = text[i] if i < len(text) else '?'

            print(f"  Block {i+1}: '{char}' - change from {original_size} to {new_size} pixels")

            if new_size == original_size:
                print(f"    ✅ No change needed for '{char}'")
                continue
            elif new_size < original_size:
                # Remove pixels (bottom-right strategy)
                pixels_to_remove = original_size - new_size
                remove_pixels_from_block(modified_img, color_blocks[i], pixels_to_remove)
                print(f"    🔧 Removed {pixels_to_remove} pixels from '{char}' block")
            else:
                # Add pixels (challenging - need space)
                pixels_to_add = new_size - original_size
                print(f"    ⚠️  Need to add {pixels_to_add} pixels to '{char}' block (complex)")
                # For now, just note the issue

    # Save modified image
    safe_text = "".join(c if c.isalnum() else "_" for c in text)
    filename = f"MODIFIED_{safe_text}.png"
    modified_img.save(filename)
    print(f"💾 Saved modified image: {filename}")

    return filename

def find_color_blocks(img):
    """Find distinct color blocks in the image"""

    width, height = img.size
    colors_found = set()

    # Scan image for distinct colors (excluding white background)
    for y in range(height):
        for x in range(width):
            color = img.getpixel((x, y))
            if color != (255, 255, 255):  # not white
                colors_found.add(color)

    # For each color, find its bounding box and pixel count
    blocks = []
    for color in colors_found:
        pixels = []
        for y in range(height):
            for x in range(width):
                if img.getpixel((x, y)) == color:
                    pixels.append((x, y))

        if pixels:
            blocks.append({
                'color': color,
                'pixels': pixels,
                'count': len(pixels),
                'bbox': get_bounding_box(pixels)
            })

    # Sort blocks by position (top-left first)
    blocks.sort(key=lambda b: (b['bbox'][1], b['bbox'][0]))  # sort by y, then x

    return blocks

def get_bounding_box(pixels):
    """Get bounding box of pixel list"""
    if not pixels:
        return (0, 0, 0, 0)

    xs = [p[0] for p in pixels]
    ys = [p[1] for p in pixels]

    return (min(xs), min(ys), max(xs), max(ys))

def remove_pixels_from_block(img, block, pixels_to_remove):
    """Remove pixels from a block using bottom-right strategy"""

    pixels = block['pixels']
    color = block['color']

    # Sort pixels by bottom-right priority (highest y, then highest x)
    pixels_sorted = sorted(pixels, key=lambda p: (p[1], p[0]), reverse=True)

    # Remove the specified number of pixels
    for i in range(min(pixels_to_remove, len(pixels_sorted))):
        x, y = pixels_sorted[i]
        img.putpixel((x, y), (255, 255, 255))  # set to white

def test_modified_image(filename, expected_text):
    """Test the modified image"""

    print(f"\n🧪 TESTING MODIFIED IMAGE: {filename}")
    print(f"Expected: '{expected_text}'")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=15)

        output = result.stdout.strip()
        print(f"📋 Actual output: '{output}'")

        if output == expected_text:
            print("🎉 PERFECT! Modified image works!")
            return True
        else:
            print(f"🔧 Expected: '{expected_text}'")
            print(f"🔧 Got:      '{output}'")

            # Character-by-character analysis
            if len(output) == len(expected_text):
                print("📊 Character differences:")
                for i, (got, exp) in enumerate(zip(output, expected_text)):
                    if got != exp:
                        print(f"  Pos {i}: got '{got}' ({ord(got)}) expected '{exp}' ({ord(exp)})")

            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    import argparse

    parser = argparse.ArgumentParser(description='Modify working Hello World image for new text')
    parser.add_argument('text', nargs='?', default='Lizard King',
                       help='Text to modify image for')
    parser.add_argument('--test', action='store_true',
                       help='Test the modified image')

    args = parser.parse_args()

    print("🚀 DIRECT TEXT MODIFIER")
    print("Modifying our working Hello World image!")
    print()

    # Create modified image
    filename = modify_working_image_for_text(args.text)

    if filename and args.test:
        success = test_modified_image(filename, args.text)

        if success:
            print(f"\n🌟 SUCCESS! Modified image works for '{args.text}'!")
            print(f"📁 File: {filename}")
            print("✅ Used proven execution flow ✅ Modified character blocks")
        else:
            print(f"\n🔧 Modification needs refinement")
            print("💡 The approach is sound, fine-tuning needed")

    elif filename:
        print(f"\n📁 Generated: {filename}")
        print("💡 Use --test to verify")

if __name__ == "__main__":
    main()