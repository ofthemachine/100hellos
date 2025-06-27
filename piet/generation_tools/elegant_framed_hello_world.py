#!/usr/bin/env python3
"""
ELEGANT FRAMED HELLO WORLD

Simple, elegant approach: Take our working Hello World and create beautiful
"picture frames" around it without touching the functional core at all.

This implements the zigzag concept for the frame decorations while
preserving the working functional core.
"""

from PIL import Image
import subprocess
import random

def create_elegant_framed_hello_world(theme="python", frame_width=50):
    """Create Hello World with elegant artistic frame"""

    print(f"🖼️ CREATING ELEGANT FRAMED HELLO WORLD")
    print(f"Theme: {theme} | Frame width: {frame_width}")
    print("="*60)

    # Load our working core
    core_img = Image.open('STRATEGY_bottom_right.png')
    core_width, core_height = core_img.size
    print(f"✅ Working core: {core_width}x{core_height}")

    # Create larger canvas for the frame
    canvas_width = core_width + 2 * frame_width
    canvas_height = core_height + 2 * frame_width
    img = Image.new('RGB', (canvas_width, canvas_height), (255, 255, 255))

    print(f"📐 Canvas with frame: {canvas_width}x{canvas_height}")

    # Add artistic frame FIRST
    add_elegant_frame(img, theme, frame_width, core_width, core_height)

    # Paste the working core in the center (completely untouched)
    core_x = frame_width
    core_y = frame_width
    img.paste(core_img, (core_x, core_y))

    print(f"✅ Core placed at ({core_x}, {core_y}) - completely preserved")

    # Save
    filename = f"FRAMED_HELLO_WORLD_{theme.upper()}.png"
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename

def add_elegant_frame(img, theme, frame_width, core_width, core_height):
    """Add elegant artistic frame around the core area"""

    print(f"🎨 Creating {theme} themed frame...")

    canvas_width, canvas_height = img.size

    # Define theme-specific colors and patterns
    if theme == "python":
        primary_color = (55, 118, 171)    # python blue
        secondary_color = (255, 212, 59)  # python yellow
        accent_colors = [(43, 82, 120), (255, 193, 7), (70, 130, 180)]
        pattern_func = create_serpentine_frame

    elif theme == "rust":
        primary_color = (206, 73, 0)      # rust orange
        secondary_color = (139, 69, 19)   # brown
        accent_colors = [(160, 82, 45), (205, 133, 63), (222, 184, 135)]
        pattern_func = create_oxidized_frame

    elif theme == "galaxy":
        primary_color = (25, 25, 112)     # midnight blue
        secondary_color = (138, 43, 226)  # blue violet
        accent_colors = [(72, 61, 139), (123, 104, 238), (147, 112, 219)]
        pattern_func = create_starfield_frame

    elif theme == "forest":
        primary_color = (34, 139, 34)     # forest green
        secondary_color = (107, 142, 35)  # olive drab
        accent_colors = [(50, 205, 50), (154, 205, 50), (124, 252, 0)]
        pattern_func = create_organic_frame

    else:  # rainbow
        primary_color = (255, 99, 71)     # tomato
        secondary_color = (255, 215, 0)   # gold
        accent_colors = [(255, 165, 0), (50, 205, 50), (30, 144, 255), (138, 43, 226)]
        pattern_func = create_rainbow_frame

    # Create the themed frame
    pattern_func(img, primary_color, secondary_color, accent_colors,
                frame_width, core_width, core_height)

def create_serpentine_frame(img, primary, secondary, accents, frame_width, core_width, core_height):
    """Create Python-style serpentine frame"""
    canvas_width, canvas_height = img.size

    # Serpentine waves in the frame area
    for x in range(canvas_width):
        for y in range(canvas_height):
            # Only draw in frame area (not in core)
            if (frame_width <= x < frame_width + core_width and
                frame_width <= y < frame_width + core_height):
                continue

            # Create wavy serpentine pattern
            wave = int(8 * (1 + 0.4 * ((x + y) / (canvas_width + canvas_height))))
            if (x + y + wave) % 16 < 4:
                # Alternate between colors based on position
                if (x + y) % 20 < 8:
                    color = primary
                elif (x + y) % 20 < 12:
                    color = secondary
                else:
                    color = accents[(x + y) % len(accents)]
                img.putpixel((x, y), color)

def create_oxidized_frame(img, primary, secondary, accents, frame_width, core_width, core_height):
    """Create Rust-style oxidized frame"""
    canvas_width, canvas_height = img.size

    for x in range(canvas_width):
        for y in range(canvas_height):
            # Only draw in frame area
            if (frame_width <= x < frame_width + core_width and
                frame_width <= y < frame_width + core_height):
                continue

            # Create rust/oxidation texture
            noise1 = (x * 17 + y * 23) % 100
            noise2 = (x * 13 + y * 19) % 80

            if noise1 < 25:
                if noise2 < 20:
                    color = primary
                elif noise2 < 40:
                    color = secondary
                else:
                    color = accents[noise1 % len(accents)]
                img.putpixel((x, y), color)

def create_starfield_frame(img, primary, secondary, accents, frame_width, core_width, core_height):
    """Create galaxy/starfield frame"""
    canvas_width, canvas_height = img.size

    # Fill frame with deep space color
    for x in range(canvas_width):
        for y in range(canvas_height):
            # Only draw in frame area
            if (frame_width <= x < frame_width + core_width and
                frame_width <= y < frame_width + core_height):
                continue

            # Base deep space
            if (x + y) % 12 < 8:
                img.putpixel((x, y), primary)

            # Add "stars"
            star_chance = (x * 7 + y * 11) % 200
            if star_chance < 5:
                img.putpixel((x, y), secondary)
            elif star_chance < 10:
                img.putpixel((x, y), accents[star_chance % len(accents)])

def create_organic_frame(img, primary, secondary, accents, frame_width, core_width, core_height):
    """Create organic/forest frame"""
    canvas_width, canvas_height = img.size

    for x in range(canvas_width):
        for y in range(canvas_height):
            # Only draw in frame area
            if (frame_width <= x < frame_width + core_width and
                frame_width <= y < frame_width + core_height):
                continue

            # Organic growth pattern
            growth = (x * 11 + y * 7) % 30
            if growth < 8:
                color = primary
            elif growth < 12:
                color = secondary
            elif growth < 16:
                color = accents[random.randint(0, len(accents)-1)]
            else:
                continue  # leave white

            img.putpixel((x, y), color)

def create_rainbow_frame(img, primary, secondary, accents, frame_width, core_width, core_height):
    """Create rainbow spectrum frame"""
    canvas_width, canvas_height = img.size

    for x in range(canvas_width):
        for y in range(canvas_height):
            # Only draw in frame area
            if (frame_width <= x < frame_width + core_width and
                frame_width <= y < frame_width + core_height):
                continue

            # Rainbow gradient effect
            color_cycle = (x + y) % 20
            if color_cycle < 4:
                img.putpixel((x, y), primary)
            elif color_cycle < 8:
                img.putpixel((x, y), secondary)
            elif color_cycle < 16:
                img.putpixel((x, y), accents[color_cycle % len(accents)])

def test_framed_hello_world(filename):
    """Test the framed Hello World"""

    print(f"\n🧪 TESTING FRAMED HELLO WORLD: {filename}")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=10)

        output = result.stdout.strip()
        print(f"📋 Output: '{output}'")

        if output == "Hello World!":
            print("🎉 PERFECT! Framed Hello World works!")
            print("✅ Functional core preserved ✅ Beautiful frame added")
            return True
        else:
            print(f"🔧 Expected: 'Hello World!'")
            print(f"🔧 Got:      '{output}'")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def create_base64_zigzag_demo(content="Hi!", theme="python"):
    """Create a demonstration of the zigzag chain concept"""

    print(f"\n🔗 ZIGZAG CHAIN DEMO: '{content}'")
    print("="*50)

    # For now, just create a visual demo of what the zigzag would look like
    import base64
    b64 = base64.b64encode(content.encode()).decode()
    print(f"📝 Content: '{content}' → Base64: '{b64}'")

    # Create a visual representation
    img = Image.new('RGB', (400, 200), (255, 255, 255))

    # Draw a zigzag pattern to show the concept
    x, y = 20, 50
    direction = 1
    colors = [(255, 0, 0), (0, 255, 0), (0, 0, 255), (255, 255, 0)]

    for i, char in enumerate(b64):
        ascii_val = ord(char)
        color = colors[i % len(colors)]

        # Draw a block representing this character
        for pixel in range(min(ascii_val, 50)):  # limit for demo
            if 0 <= x < 400 and 0 <= y < 200:
                img.putpixel((x, y), color)
            x += direction

            # Zigzag when hitting edges
            if x >= 380 or x <= 20:
                direction *= -1
                y += 10
                if y >= 180:
                    break

        # Small gap between characters
        x += direction * 3

    filename = f"ZIGZAG_DEMO_{theme.upper()}.png"
    img.save(filename)
    print(f"💾 Saved demo: {filename}")
    print("📝 This shows the concept - actual implementation needs execution flow work")

    return filename

if __name__ == "__main__":
    print("🚀 ELEGANT FRAMED HELLO WORLD CREATOR")
    print("Beautiful frames around working programs!")
    print()

    # Test elegant framing approach
    themes = ["python", "rust", "galaxy", "forest", "rainbow"]
    successful_frames = []

    for theme in themes:
        print(f"\n🖼️ Creating {theme} framed Hello World...")

        try:
            filename = create_elegant_framed_hello_world(theme, frame_width=40)
            success = test_framed_hello_world(filename)

            if success:
                successful_frames.append((theme, filename))
                print(f"  ✅ {theme} frame successful!")
            else:
                print(f"  🔧 {theme} frame needs work")

        except Exception as e:
            print(f"  ❌ {theme} frame failed: {e}")

    # Create zigzag demo
    if successful_frames:
        print("\n🔗 Creating zigzag chain demo...")
        demo_file = create_base64_zigzag_demo("Code!", "python")

    # Summary
    print(f"\n" + "="*60)
    print("🎭 ELEGANT FRAMING SUMMARY")
    print(f"✅ Successful frames: {len(successful_frames)}")

    for theme, filename in successful_frames:
        print(f"  🖼️ {theme}: {filename}")

    if successful_frames:
        print("\n🌟 ELEGANT FRAMING ACHIEVED!")
        print("✅ Working Hello World preserved!")
        print("✅ Beautiful artistic frames added!")
        print("✅ Foundation for zigzag chain concept!")
        print("🎯 Perfect stepping stone to full base64 encoding!")

        # Copy the best one to main location
        best_theme, best_file = successful_frames[0]
        import shutil
        target = f"../ARTISTIC_HELLO_WORLD_{best_theme.upper()}.png"
        shutil.copy(best_file, target)
        print(f"📋 Copied best version to {target}")

    else:
        print("\n🔧 All frames need work...")
        print("💡 But the core concept is sound!")