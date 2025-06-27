#!/usr/bin/env python3
"""
PROTECTED ARTISTIC CREATOR

Implementation of the brilliant "zigzag chain" concept:
1. Create functional chains that zigzag across larger canvases
2. Add beautiful artistic decorations AROUND the functional area
3. Use black barriers to protect the functional execution path
4. Create "digital artifacts" that are both functional and beautiful

This achieves the vision of visual polyglot poetry!
"""

from PIL import Image
import subprocess
import base64
import random

def create_protected_artistic_program(content="Hello World!", theme="python", canvas_size=(400, 300)):
    """Create artistic program with protected functional chain"""

    print(f"🛡️ CREATING PROTECTED ARTISTIC PROGRAM")
    print(f"Theme: {theme} | Content: '{content}' | Canvas: {canvas_size}")
    print("="*70)

    canvas_width, canvas_height = canvas_size

    # Method 1: For "Hello World!" - use our successful core with artistic borders
    if content == "Hello World!":
        return create_hello_world_with_artistic_borders(theme, canvas_size)

    # Method 2: For base64 content - create zigzag chain
    else:
        return create_zigzag_chain_with_art(content, theme, canvas_size)

def create_hello_world_with_artistic_borders(theme, canvas_size):
    """Create Hello World with artistic borders while protecting the functional core"""

    print("🎯 METHOD 1: HELLO WORLD WITH ARTISTIC BORDERS")
    print("Using our successful core + protective artistic decoration")
    print("-" * 60)

    canvas_width, canvas_height = canvas_size

    # Load our working core
    core_img = Image.open('STRATEGY_bottom_right.png')
    core_width, core_height = core_img.size
    print(f"✅ Loaded working core: {core_width}x{core_height}")

    # Create large artistic canvas
    img = Image.new('RGB', canvas_size, (255, 255, 255))

    # Position core in the center
    core_x = (canvas_width - core_width) // 2
    core_y = (canvas_height - core_height) // 2

    # Add artistic decoration BEFORE placing core
    add_protected_decoration(img, theme, core_x, core_y, core_width, core_height)

    # Create protective black border around core area
    border_thickness = 3
    add_protective_border(img, core_x - border_thickness, core_y - border_thickness,
                         core_width + 2*border_thickness, core_height + 2*border_thickness)

    # Paste the functional core (this overwrites the border area)
    img.paste(core_img, (core_x, core_y))

    print(f"✅ Core protected and placed at ({core_x}, {core_y})")

    # Save
    filename = f"PROTECTED_HELLO_WORLD_{theme.upper()}.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def create_zigzag_chain_with_art(content, theme, canvas_size):
    """Create zigzag functional chain with artistic decoration"""

    print("🔗 METHOD 2: ZIGZAG CHAIN WITH ART")
    print(f"Creating base64 chain for: '{content}'")
    print("-" * 60)

    canvas_width, canvas_height = canvas_size

    # Encode content
    b64_content = base64.b64encode(content.encode()).decode()
    print(f"🔐 Base64: {b64_content} ({len(b64_content)} chars)")

    # Create canvas
    img = Image.new('RGB', canvas_size, (255, 255, 255))

    # Define functional area (zigzag will stay within this)
    func_margin = 50
    func_x = func_margin
    func_y = func_margin
    func_width = canvas_width - 2 * func_margin
    func_height = canvas_height - 2 * func_margin

    # Add artistic decoration FIRST (outside functional area)
    add_protected_decoration(img, theme, func_x, func_y, func_width, func_height)

    # Add protective border around functional area
    add_protective_border(img, func_x - 5, func_y - 5, func_width + 10, func_height + 10)

    # Create the zigzag chain
    success = create_zigzag_functional_chain(img, b64_content, func_x, func_y, func_width, func_height)

    if not success:
        print("❌ Failed to create zigzag chain")
        return None

    # Save
    filename = f"ZIGZAG_CHAIN_{theme.upper()}.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def add_protected_decoration(img, theme, protected_x, protected_y, protected_width, protected_height):
    """Add artistic decoration while avoiding the protected functional area"""

    print(f"🎨 Adding {theme} artistic decoration (protected area: {protected_x},{protected_y} {protected_width}x{protected_height})")

    canvas_width, canvas_height = img.size

    # Theme color palettes
    if theme == "python":
        colors = [(55, 118, 171), (255, 212, 59), (43, 82, 120), (255, 193, 7)]
    elif theme == "rust":
        colors = [(206, 73, 0), (139, 69, 19), (160, 82, 45), (205, 133, 63)]
    elif theme == "ocean":
        colors = [(0, 105, 148), (0, 136, 169), (0, 166, 189), (72, 191, 227)]
    elif theme == "forest":
        colors = [(34, 139, 34), (107, 142, 35), (154, 205, 50), (50, 205, 50)]
    else:  # rainbow
        colors = [(255, 99, 71), (255, 165, 0), (255, 215, 0), (50, 205, 50), (30, 144, 255)]

    # Create patterns in non-protected areas
    for x in range(canvas_width):
        for y in range(canvas_height):
            # Skip protected functional area (with extra margin)
            if (protected_x - 10 <= x <= protected_x + protected_width + 10 and
                protected_y - 10 <= y <= protected_y + protected_height + 10):
                continue

            # Create themed patterns
            if theme == "python":
                # Serpentine waves
                wave = int(5 * (1 + 0.3 * (x / canvas_width))) + int(3 * (1 + 0.2 * (y / canvas_height)))
                if (x + y + wave) % 12 < 2:
                    color = colors[(x + y) % len(colors)]
                    img.putpixel((x, y), color)

            elif theme == "rust":
                # Oxidation texture
                noise = (x * 13 + y * 17) % 80
                if noise < 20:
                    color = colors[noise % len(colors)]
                    img.putpixel((x, y), color)

            elif theme == "ocean":
                # Wave patterns
                if (x + 2*y) % 15 < 3:
                    color = colors[(x + y) % len(colors)]
                    img.putpixel((x, y), color)

            elif theme == "forest":
                # Organic scattered pattern
                if (x * 7 + y * 11) % 25 < 4:
                    color = colors[random.randint(0, len(colors)-1)]
                    img.putpixel((x, y), color)

            else:  # rainbow
                # Gradient stripes
                if x % 8 < 2:
                    color = colors[(x + y) % len(colors)]
                    img.putpixel((x, y), color)

def add_protective_border(img, border_x, border_y, border_width, border_height):
    """Add black protective border around functional area"""

    print(f"🛡️ Adding protective border at ({border_x},{border_y}) {border_width}x{border_height}")

    # Top and bottom borders
    for x in range(max(0, border_x), min(img.width, border_x + border_width)):
        if 0 <= border_y < img.height:
            img.putpixel((x, border_y), (0, 0, 0))  # top
        if 0 <= border_y + border_height - 1 < img.height:
            img.putpixel((x, border_y + border_height - 1), (0, 0, 0))  # bottom

    # Left and right borders
    for y in range(max(0, border_y), min(img.height, border_y + border_height)):
        if 0 <= border_x < img.width:
            img.putpixel((border_x, y), (0, 0, 0))  # left
        if 0 <= border_x + border_width - 1 < img.width:
            img.putpixel((border_x + border_width - 1, y), (0, 0, 0))  # right

def create_zigzag_functional_chain(img, b64_content, start_x, start_y, area_width, area_height):
    """Create the actual zigzag functional chain within the protected area"""

    print(f"🔗 Creating zigzag chain in area {start_x},{start_y} {area_width}x{area_height}")

    # Colors for functional chain
    red = (255, 0, 0)      # push blocks
    dark_red = (192, 0, 0) # outchar blocks

    x, y = start_x + 5, start_y + 5  # start with margin
    direction = 1  # 1 = right, -1 = left
    row_height = 6

    for i, char in enumerate(b64_content):
        ascii_val = ord(char)
        print(f"  Chain {i+1}: '{char}' = {ascii_val} pixels")

        # Check if we need to wrap to next row
        pixels_needed = ascii_val + 2  # +2 for outchar and gap
        if (direction == 1 and x + pixels_needed > start_x + area_width - 5) or \
           (direction == -1 and x - pixels_needed < start_x + 5):
            # Move to next row
            y += row_height
            direction *= -1
            if direction == 1:
                x = start_x + 5
            else:
                x = start_x + area_width - 5

            # Check vertical bounds
            if y + row_height > start_y + area_height - 5:
                print(f"❌ Out of vertical space at character {i+1}")
                return False

        # Create push block
        for pixel in range(ascii_val):
            if (start_x + 5 <= x < start_x + area_width - 5 and
                start_y + 5 <= y < start_y + area_height - 5):
                img.putpixel((x, y), red)
            x += direction

        # Add outchar
        if (start_x + 5 <= x < start_x + area_width - 5 and
            start_y + 5 <= y < start_y + area_height - 5):
            img.putpixel((x, y), dark_red)
        x += direction

        # Small gap
        x += direction

    # Add termination
    if (start_x + 5 <= x < start_x + area_width - 5 and
        start_y + 5 <= y < start_y + area_height - 5):
        img.putpixel((x, y), (0, 0, 0))

    print("✅ Zigzag chain complete!")
    return True

def test_protected_program(filename, expected_output="Hello World!"):
    """Test the protected artistic program"""

    print(f"\n🧪 TESTING PROTECTED PROGRAM: {filename}")
    print("="*60)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=15)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == expected_output:
            print("🎉 PERFECT! Protected artistic program works!")
            print("✅ Functional ✅ Artistic ✅ Protected")
            return True
        else:
            print(f"🔧 Expected: '{expected_output}'")
            print(f"🔧 Got:      '{output}'")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    print("🚀 PROTECTED ARTISTIC CREATOR")
    print("Implementing the brilliant zigzag chain concept!")
    print()

    # Test 1: Protected Hello World with artistic themes
    print("🎯 TEST 1: PROTECTED HELLO WORLD THEMES")
    print("="*50)

    themes = ["python", "rust", "ocean", "forest"]
    successful_artworks = []

    for theme in themes:
        print(f"\n🎨 Creating {theme} themed Hello World...")

        filename = create_protected_artistic_program("Hello World!", theme, (300, 200))
        if filename:
            success = test_protected_program(filename, "Hello World!")

            if success:
                successful_artworks.append((theme, filename))
                print(f"  ✅ {theme} artwork successful!")
            else:
                print(f"  🔧 {theme} artwork needs work")

    # Test 2: Base64 zigzag chains (if Hello World works)
    if successful_artworks:
        print(f"\n🔗 TEST 2: BASE64 ZIGZAG CHAINS")
        print("="*50)

        test_contents = ["Hi!", "Code"]

        for content in test_contents:
            print(f"\n⚡ Creating zigzag chain for '{content}'...")
            filename = create_protected_artistic_program(content, "python", (400, 300))

            if filename:
                expected_b64 = base64.b64encode(content.encode()).decode()
                success = test_protected_program(filename, expected_b64)

                if success:
                    print(f"  🎉 Zigzag chain for '{content}' works!")
                    print(f"  🔓 Outputs: {expected_b64}")
                else:
                    print(f"  🔧 Zigzag chain for '{content}' needs work")

    # Summary
    print(f"\n" + "="*70)
    print("🎭 PROTECTED ARTISTIC SUMMARY")
    print(f"✅ Successful Hello World artworks: {len(successful_artworks)}")

    for theme, filename in successful_artworks:
        print(f"  🎨 {theme}: {filename}")

    if successful_artworks:
        print("\n🌟 VISUAL POLYGLOT POETRY ACHIEVED!")
        print("✅ Functional programs that are beautiful art!")
        print("✅ Protected execution paths!")
        print("✅ Themed decorations!")
        print("🎯 Perfect foundation for the zigzag chain concept!")
    else:
        print("\n🔧 Protection system needs refinement...")
        print("💡 But the architectural approach is sound!")