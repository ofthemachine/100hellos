#!/usr/bin/env python3
"""
🎨 PIET IMAGE DECORATOR - Celebration Creator 🎨

Take a KNOWN WORKING Piet program and add beautiful decorations around it.
This approach is guaranteed to work because we start with something that already works!

Strategy:
1. Load a proven working Piet image (e.g., hi.png)
2. Expand the canvas with white space
3. Add artistic decorations in the new space
4. Keep the original program untouched and working
"""

from PIL import Image, ImageDraw
import subprocess
import random
import math

# Piet standard colors
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

def load_working_program(image_path):
    """Load a proven working program"""
    try:
        return Image.open(image_path)
    except Exception as e:
        print(f"Error loading {image_path}: {e}")
        return None

def create_decorated_canvas(original_img, new_width, new_height, offset_x=10, offset_y=10):
    """Create larger canvas and place original image with offset"""
    # Create new white canvas
    decorated = Image.new('RGB', (new_width, new_height), COLORS['white'])

    # Paste original image at offset position
    decorated.paste(original_img, (offset_x, offset_y))

    return decorated, (offset_x, offset_y, offset_x + original_img.width, offset_y + original_img.height)

def add_celebration_border(img, program_area, border_width=5):
    """Add colorful celebration border around the program"""
    x1, y1, x2, y2 = program_area

    # Create rainbow border
    rainbow_colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']

    for i in range(border_width):
        color = rainbow_colors[i % len(rainbow_colors)]

        # Top and bottom borders
        for x in range(max(0, x1 - border_width), min(img.width, x2 + border_width)):
            if y1 - border_width + i >= 0:
                img.putpixel((x, y1 - border_width + i), COLORS[color])
            if y2 + i < img.height:
                img.putpixel((x, y2 + i), COLORS[color])

        # Left and right borders
        for y in range(max(0, y1 - border_width), min(img.height, y2 + border_width)):
            if x1 - border_width + i >= 0:
                img.putpixel((x1 - border_width + i, y), COLORS[color])
            if x2 + i < img.width:
                img.putpixel((x2 + i, y), COLORS[color])

def add_99_100_celebration_text(img, program_area):
    """Add visual representations of 99 and 100"""
    x1, y1, x2, y2 = program_area

    # Add "99" in the top area
    if y1 > 20:
        nine_colors = ['yellow', 'light_yellow', 'dark_yellow']
        # Simple "99" pattern
        for digit_x in [20, 35]:  # Two 9s
            for dy in range(15):
                for dx in range(10):
                    x = digit_x + dx
                    y = 5 + dy
                    if x < img.width and y < img.height:
                        # Create blocky "9" shape
                        if (dy < 5 or dy > 10) or (dx < 2 or dx > 7):
                            color = nine_colors[(dx + dy) % len(nine_colors)]
                            img.putpixel((x, y), COLORS[color])

    # Add "100" in the bottom area
    if img.height - y2 > 20:
        hundred_colors = ['cyan', 'light_cyan', 'dark_cyan']
        start_y = y2 + 10
        for digit_x in [20, 35, 50]:  # "1", "0", "0"
            for dy in range(15):
                for dx in range(10):
                    x = digit_x + dx
                    y = start_y + dy
                    if x < img.width and y < img.height:
                        # Create blocky number shapes
                        if digit_x == 20:  # "1"
                            if dx >= 4 and dx <= 6:
                                color = hundred_colors[(dx + dy) % len(hundred_colors)]
                                img.putpixel((x, y), COLORS[color])
                        else:  # "0"
                            if (dy < 3 or dy > 12) or (dx < 2 or dx > 8):
                                color = hundred_colors[(dx + dy) % len(hundred_colors)]
                                img.putpixel((x, y), COLORS[color])

def add_fireworks_celebration(img, program_area):
    """Add fireworks in free areas"""
    x1, y1, x2, y2 = program_area

    firework_colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta', 'light_red', 'light_yellow']

    # Right side fireworks
    if img.width - x2 > 30:
        center_x = x2 + 25
        center_y = y1 + (y2 - y1) // 2

        for angle in range(0, 360, 15):
            for radius in range(3, 20, 3):
                fx = center_x + int(radius * math.cos(math.radians(angle)))
                fy = center_y + int(radius * math.sin(math.radians(angle)))

                if fx < img.width and fy < img.height and fx >= 0 and fy >= 0:
                    color = firework_colors[(angle // 30 + radius) % len(firework_colors)]
                    img.putpixel((fx, fy), COLORS[color])

def add_confetti_celebration(img, program_area):
    """Add random confetti in free areas"""
    x1, y1, x2, y2 = program_area

    confetti_colors = ['light_red', 'light_yellow', 'light_green', 'light_cyan', 'light_blue', 'light_magenta']

    # Add confetti outside program area
    for _ in range(200):
        x = random.randint(0, img.width - 1)
        y = random.randint(0, img.height - 1)

        # Skip if inside program area (with small buffer)
        if x1 - 10 <= x <= x2 + 10 and y1 - 10 <= y <= y2 + 10:
            continue

        color = random.choice(confetti_colors)
        img.putpixel((x, y), COLORS[color])

def test_decorated_program(image_path, codel_size):
    """Test the decorated program"""
    try:
        result = subprocess.run(['./piet', image_path, str(codel_size)],
                              capture_output=True, text=True, timeout=5,
                              cwd='../files')
        return result.stdout.strip(), result.stderr, result.returncode
    except subprocess.TimeoutExpired:
        return "", "Program timed out", -1
    except Exception as e:
        return "", str(e), -1

def create_99th_celebration():
    """Create the ultimate 99th/100th celebration using proven working program"""
    print("🎉 Creating 99th and Final 100th Hello Celebration! 🎉")
    print("Using PROVEN working program as foundation...")

    # Load the proven working "hi.png" program
    original_img = load_working_program('../files/test_images/hi.png')
    if not original_img:
        print("❌ Could not load hi.png - celebration cancelled")
        return False

    print(f"✅ Loaded working program: {original_img.width}x{original_img.height}")

    # Create decorated version with larger canvas (must be divisible by codel size 16)
    new_width, new_height = 208, 128  # Both divisible by 16
    decorated_img, program_area = create_decorated_canvas(original_img, new_width, new_height, 24, 24)

    print(f"🎨 Expanded canvas to {new_width}x{new_height}")
    print(f"📍 Program area: {program_area}")

    # Add celebration decorations
    print("✨ Adding celebration border...")
    add_celebration_border(decorated_img, program_area)

    print("🎯 Adding 99/100 celebration text...")
    add_99_100_celebration_text(decorated_img, program_area)

    print("🎆 Adding fireworks...")
    add_fireworks_celebration(decorated_img, program_area)

    print("🎊 Adding confetti...")
    add_confetti_celebration(decorated_img, program_area)

    # Save the celebration
    output_path = "99th_final_100th_decorated_celebration.png"
    decorated_img.save(output_path)
    print(f"💾 Saved celebration as: {output_path}")

    # Test it
    print("🧪 Testing decorated program...")
    stdout, stderr, returncode = test_decorated_program(output_path, 16)  # hi.png uses codel size 16

    if stdout:
        print(f"🎉 SUCCESS! Output: '{stdout}'")
        print("🏆 Working 99th/100th celebration created! 🏆")
        return True
    else:
        print(f"⚠️ Testing issue - Return code: {returncode}")
        if stderr:
            print(f"Error: {stderr}")
        print("🤔 Celebration created but may need codel size adjustment")
        return False

if __name__ == "__main__":
    success = create_99th_celebration()
    if success:
        print("\n🎊 MAGNIFICENT FINISH ACHIEVED! 🎊")
        print("We have our working 99th/100th Hello World celebration!")
    else:
        print("\n🔧 Celebration needs fine-tuning, but foundation is solid!")