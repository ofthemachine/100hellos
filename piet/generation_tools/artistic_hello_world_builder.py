#!/usr/bin/env python3
"""
ARTISTIC HELLO WORLD BUILDER

Take our successful "Hello World!" technique and create beautiful themed versions
by adding artistic elements around the functional core.

This creates the "visual polyglot poetry" - functional art representing programming languages.
"""

from PIL import Image
import subprocess
import random

def create_artistic_hello_world(theme="python", img_width=300, img_height=200):
    """Create themed Hello World with artistic decoration"""

    print(f"🎨 CREATING ARTISTIC HELLO WORLD: {theme}")
    print("="*60)

    # Start with our successful base image (bottom-right strategy)
    print("📋 Loading successful base pattern...")
    try:
        # Use our working strategy image as the functional core
        base_img = Image.open('STRATEGY_bottom_right.png')
        core_width, core_height = base_img.size
        print(f"✅ Base functional core: {core_width}x{core_height}")
    except:
        print("❌ Base image not found, using frankzago as fallback")
        base_img = Image.open('../files/test_images/frankzago_hello.png')
        core_width, core_height = base_img.size

    # Create larger canvas for artistic elements
    img = Image.new('RGB', (img_width, img_height), (255, 255, 255))

    # Position the functional core in the image
    core_x = (img_width - core_width) // 2
    core_y = (img_height - core_height) // 2

    # Paste the functional core
    img.paste(base_img, (core_x, core_y))

    print(f"✅ Functional core placed at ({core_x}, {core_y})")

    # Add theme-specific artistic elements
    add_theme_decoration(img, theme, core_x, core_y, core_width, core_height)

    # Save the artistic version
    filename = f"ARTISTIC_HELLO_WORLD_{theme.upper()}.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def add_theme_decoration(img, theme, core_x, core_y, core_width, core_height):
    """Add theme-specific artistic decorations around the functional core"""

    print(f"🖌️ Adding {theme} themed decorations...")

    width, height = img.size

    # Define theme colors and patterns
    if theme == "python":
        colors = [
            (55, 118, 171),   # python blue
            (255, 212, 59),   # python yellow
            (43, 82, 120),    # dark blue
            (255, 193, 7),    # amber
        ]
        pattern_func = create_serpentine_pattern

    elif theme == "java":
        colors = [
            (139, 69, 19),    # saddle brown (coffee)
            (160, 82, 45),    # rosy brown
            (210, 180, 140),  # tan
            (222, 184, 135),  # burlywood
        ]
        pattern_func = create_coffee_pattern

    elif theme == "javascript":
        colors = [
            (240, 219, 79),   # js yellow
            (50, 50, 50),     # dark gray
            (100, 100, 100),  # gray
            (200, 200, 200),  # light gray
        ]
        pattern_func = create_dynamic_pattern

    elif theme == "rust":
        colors = [
            (206, 73, 0),     # rust orange
            (139, 69, 19),    # brown
            (160, 82, 45),    # rosy brown
            (205, 133, 63),   # peru
        ]
        pattern_func = create_oxidation_pattern

    elif theme == "cpp":
        colors = [
            (100, 149, 237),  # cornflower blue
            (70, 130, 180),   # steel blue
            (119, 136, 153),  # light slate gray
            (112, 128, 144),  # slate gray
        ]
        pattern_func = create_mechanical_pattern

    else:  # default/rainbow
        colors = [
            (255, 99, 71),    # tomato
            (255, 165, 0),    # orange
            (255, 215, 0),    # gold
            (50, 205, 50),    # lime green
            (30, 144, 255),   # dodger blue
            (138, 43, 226),   # blue violet
        ]
        pattern_func = create_rainbow_pattern

    # Create decorative borders and patterns
    pattern_func(img, colors, core_x, core_y, core_width, core_height)

    print(f"  ✅ {theme} theme applied!")

def create_serpentine_pattern(img, colors, core_x, core_y, core_width, core_height):
    """Create Python-style serpentine patterns"""
    width, height = img.size

    # Wavy patterns around the core
    for x in range(width):
        for y in range(height):
            # Skip functional core area
            if core_x <= x <= core_x + core_width and core_y <= y <= core_y + core_height:
                continue

            # Create sine wave pattern
            wave = int(10 * (1 + 0.5 * (x / width))) + int(5 * (1 + 0.3 * (y / height)))
            if (x + y + wave) % 15 < 3:
                color = colors[(x + y) % len(colors)]
                img.putpixel((x, y), color)

def create_coffee_pattern(img, colors, core_x, core_y, core_width, core_height):
    """Create Java-style coffee bean patterns"""
    width, height = img.size

    # Coffee bean spots
    for x in range(0, width, 8):
        for y in range(0, height, 8):
            # Skip functional core area
            if core_x - 10 <= x <= core_x + core_width + 10 and core_y - 10 <= y <= core_y + core_height + 10:
                continue

            # Create coffee bean shapes
            if random.random() < 0.3:
                color = colors[random.randint(0, len(colors)-1)]
                for dx in range(-2, 3):
                    for dy in range(-3, 4):
                        if dx*dx + dy*dy < 6 and 0 <= x+dx < width and 0 <= y+dy < height:
                            img.putpixel((x+dx, y+dy), color)

def create_dynamic_pattern(img, colors, core_x, core_y, core_width, core_height):
    """Create JavaScript-style dynamic patterns"""
    width, height = img.size

    # Dynamic scattered elements
    for _ in range(width * height // 20):
        x = random.randint(0, width-1)
        y = random.randint(0, height-1)

        # Skip functional core area
        if core_x - 5 <= x <= core_x + core_width + 5 and core_y - 5 <= y <= core_y + core_height + 5:
            continue

        color = colors[random.randint(0, len(colors)-1)]
        # Create small dynamic shapes
        size = random.randint(1, 4)
        for dx in range(-size, size+1):
            for dy in range(-size, size+1):
                if 0 <= x+dx < width and 0 <= y+dy < height:
                    if random.random() < 0.6:
                        img.putpixel((x+dx, y+dy), color)

def create_oxidation_pattern(img, colors, core_x, core_y, core_width, core_height):
    """Create Rust-style oxidation patterns"""
    width, height = img.size

    # Rust-like scattered oxidation
    for x in range(width):
        for y in range(height):
            # Skip functional core area
            if core_x - 8 <= x <= core_x + core_width + 8 and core_y - 8 <= y <= core_y + core_height + 8:
                continue

            # Create rust texture
            noise = (x * 17 + y * 23) % 100
            if noise < 25:
                color = colors[noise % len(colors)]
                img.putpixel((x, y), color)

def create_mechanical_pattern(img, colors, core_x, core_y, core_width, core_height):
    """Create C++-style mechanical/gear patterns"""
    width, height = img.size

    # Grid-like mechanical structure
    for x in range(0, width, 6):
        for y in range(height):
            # Skip functional core area
            if core_x - 10 <= x <= core_x + core_width + 10 and core_y - 10 <= y <= core_y + core_height + 10:
                continue
            if 0 <= x < width:
                color = colors[(x + y) % len(colors)]
                img.putpixel((x, y), color)

    for x in range(width):
        for y in range(0, height, 6):
            # Skip functional core area
            if core_x - 10 <= x <= core_x + core_width + 10 and core_y - 10 <= y <= core_y + core_height + 10:
                continue
            if 0 <= y < height:
                color = colors[(x + y) % len(colors)]
                img.putpixel((x, y), color)

def create_rainbow_pattern(img, colors, core_x, core_y, core_width, core_height):
    """Create rainbow/spectrum patterns"""
    width, height = img.size

    # Rainbow gradients
    for x in range(width):
        for y in range(height):
            # Skip functional core area
            if core_x - 5 <= x <= core_x + core_width + 5 and core_y - 5 <= y <= core_y + core_height + 5:
                continue

            # Create rainbow effect
            color_idx = (x + y) % len(colors)
            if (x + y) % 8 < 3:
                img.putpixel((x, y), colors[color_idx])

def test_artistic_hello_world(filename):
    """Test that the artistic version still functions correctly"""

    print(f"\n🧪 TESTING ARTISTIC VERSION: {filename}")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Artistic version works!")
            print("✅ Functional program ✅ Visual art ✅ Programming theme")
            return True
        elif "Hello" in output:
            print(f"🔧 Close! Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")
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
    print("🚀 ARTISTIC HELLO WORLD BUILDER")
    print("Creating beautiful themed Hello World programs!")
    print()

    # Create themed Hello World programs
    themes = ["python", "java", "javascript", "rust", "cpp"]

    successful_themes = []

    for theme in themes:
        print(f"\n🎨 Creating {theme} themed Hello World...")

        try:
            filename = create_artistic_hello_world(theme)
            success = test_artistic_hello_world(filename)

            if success:
                successful_themes.append((theme, filename))
                print(f"  ✅ {theme} theme successful!")
            else:
                print(f"  🔧 {theme} theme needs work")

        except Exception as e:
            print(f"  ❌ {theme} theme failed: {e}")

    # Summary
    print(f"\n" + "="*60)
    print("🎭 ARTISTIC HELLO WORLD SUMMARY")
    print(f"✅ Successful themes: {len(successful_themes)}")

    for theme, filename in successful_themes:
        print(f"  🎨 {theme}: {filename}")

    if successful_themes:
        print("\n🌟 VISUAL POLYGLOT POETRY ACHIEVED!")
        print("✅ Functional programs that are also beautiful art!")
        print("✅ Each represents a different programming language theme!")
        print("✅ All output exactly 'Hello World!' with capital W!")
        print("🎯 Perfect for the 100th language celebration!")
    else:
        print("\n🔧 Artistic themes need refinement...")
        print("💡 But the foundation is solid!")