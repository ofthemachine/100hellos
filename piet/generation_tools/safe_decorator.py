#!/usr/bin/env python3
"""
🛡️ SAFE PIET DECORATOR - Black Barrier Isolation 🛡️

The safest possible approach:
1. Load working program
2. Surround it with BLACK BARRIER - execution cannot pass through black
3. Add decorations ONLY in areas completely separated by black barriers
"""

from PIL import Image
import subprocess

# Piet colors
COLORS = {
    'light_red': (255, 192, 192),    'light_yellow': (255, 255, 192),
    'light_green': (192, 255, 192),  'light_cyan': (192, 255, 255),
    'light_blue': (192, 192, 255),   'light_magenta': (255, 192, 255),
    'red': (255, 0, 0),              'yellow': (255, 255, 0),
    'green': (0, 255, 0),            'cyan': (0, 255, 255),
    'blue': (0, 0, 255),             'magenta': (255, 0, 255),
    'dark_red': (192, 0, 0),         'dark_yellow': (192, 192, 0),
    'dark_green': (0, 192, 0),       'dark_cyan': (0, 192, 192),
    'dark_blue': (0, 0, 192),        'dark_magenta': (192, 0, 192),
    'white': (255, 255, 255),        'black': (0, 0, 0)
}

def create_safe_decorated_program():
    """Create decorated program with complete black barrier isolation"""
    print("🛡️ Creating SAFE decorated Piet program with black barriers...")

    # Load the proven working hi.png
    try:
        original = Image.open('../files/test_images/hi.png')
        print(f"✅ Loaded original: {original.width}x{original.height}")
    except Exception as e:
        print(f"❌ Failed to load hi.png: {e}")
        return False

    # Create larger canvas (divisible by 16)
    barrier_thickness = 16  # Thick black barrier
    new_width = ((original.width + 2 * barrier_thickness + 15) // 16) * 16  # Round up to multiple of 16
    new_height = ((original.height + 2 * barrier_thickness + 15) // 16) * 16

    print(f"🎨 Creating {new_width}x{new_height} canvas with {barrier_thickness}px black barriers")

    # Start with white canvas
    decorated = Image.new('RGB', (new_width, new_height), COLORS['white'])

    # Place original program at (0,0) - execution must start there!
    decorated.paste(original, (0, 0))

    # Create black barriers to the right and bottom of the original program
    # This prevents execution from escaping into decoration areas

    # Right barrier (vertical black wall)
    for x in range(original.width, min(new_width, original.width + barrier_thickness)):
        for y in range(new_height):
            decorated.putpixel((x, y), COLORS['black'])

    # Bottom barrier (horizontal black wall)
    for y in range(original.height, min(new_height, original.height + barrier_thickness)):
        for x in range(new_width):
            decorated.putpixel((x, y), COLORS['black'])

    print(f"🖤 Added black isolation barriers")
    print(f"📍 Original program area: (0, 0) to ({original.width}, {original.height})")

    # Now add decorations ONLY in areas beyond the black barriers
    add_safe_decorations(decorated, 0, 0, original.width, original.height, barrier_thickness)

    # Save result
    output_path = "safe_decorated_hi.png"
    decorated.save(output_path)
    print(f"💾 Saved as: {output_path}")

    # Test it
    print("🧪 Testing safe decorated program...")
    try:
        result = subprocess.run(['./piet', output_path, '16'],
                              capture_output=True, text=True, timeout=5,
                              cwd='../files')
        if result.stdout:
            print(f"🎉 SUCCESS! Output: '{result.stdout.strip()}'")
            print("🏆 Safe decorated program works! 🏆")
            return True
        else:
            print(f"⚠️ No output. Return code: {result.returncode}")
            if result.stderr:
                print(f"Error: {result.stderr}")
    except subprocess.TimeoutExpired:
        print("❌ Program timed out - still has execution issues")
    except Exception as e:
        print(f"❌ Test failed: {e}")

    return False

def add_safe_decorations(img, prog_x, prog_y, prog_w, prog_h, barrier_thickness):
    """Add decorations only in areas beyond the black barriers"""

    # Right side decorations (beyond the right black barrier)
    decoration_start_x = prog_x + prog_w + barrier_thickness
    if decoration_start_x < img.width:
        for y in range(prog_h):  # Only up to original program height
            for x in range(decoration_start_x, img.width):
                if (x + y) % 4 == 0:
                    img.putpixel((x, y), COLORS['light_blue'])
                elif (x + y) % 4 == 1:
                    img.putpixel((x, y), COLORS['light_cyan'])

    # Bottom decorations (beyond the bottom black barrier)
    decoration_start_y = prog_y + prog_h + barrier_thickness
    if decoration_start_y < img.height:
        for x in range(prog_w):  # Only up to original program width
            for y in range(decoration_start_y, img.height):
                if (x + y) % 4 == 0:
                    img.putpixel((x, y), COLORS['light_green'])
                elif (x + y) % 4 == 1:
                    img.putpixel((x, y), COLORS['light_yellow'])

    # Corner decoration (bottom-right, beyond both barriers)
    if decoration_start_x < img.width and decoration_start_y < img.height:
        for x in range(decoration_start_x, img.width):
            for y in range(decoration_start_y, img.height):
                if (x + y) % 4 == 0:
                    img.putpixel((x, y), COLORS['light_red'])
                elif (x + y) % 4 == 1:
                    img.putpixel((x, y), COLORS['light_magenta'])

    print("🎨 Added safe decorations beyond black barriers")

if __name__ == "__main__":
    success = create_safe_decorated_program()
    if success:
        print("\n🎊 SAFE DECORATION SUCCESS! 🎊")
        print("We have a working decorated Piet program!")
    else:
        print("\n🔧 Need to debug further...")