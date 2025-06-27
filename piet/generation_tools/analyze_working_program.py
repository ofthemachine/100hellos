#!/usr/bin/env python3
"""
🔍 ANALYZE WORKING PROGRAM 🔍

Study the actual structure of working Piet programs to understand:
1. How blocks are arranged and connected
2. How execution flows between regions
3. What color transitions actually mean
"""

from PIL import Image
import subprocess

def analyze_image_structure(image_path):
    """Analyze the pixel structure of a working Piet program"""

    try:
        img = Image.open(image_path)
        print(f"📐 Analyzing {image_path}: {img.width}x{img.height}")

        # Convert to RGB and analyze pixel by pixel
        img = img.convert('RGB')

        # Track unique colors and their positions
        color_regions = {}

        for y in range(img.height):
            for x in range(img.width):
                pixel = img.getpixel((x, y))
                if pixel not in color_regions:
                    color_regions[pixel] = []
                color_regions[pixel].append((x, y))

        print(f"🎨 Found {len(color_regions)} unique colors:")

        # Map RGB to Piet color names
        piet_colors = {
            (255, 192, 192): 'light_red',    (255, 255, 192): 'light_yellow',
            (192, 255, 192): 'light_green',  (192, 255, 255): 'light_cyan',
            (192, 192, 255): 'light_blue',   (255, 192, 255): 'light_magenta',
            (255, 0, 0): 'red',              (255, 255, 0): 'yellow',
            (0, 255, 0): 'green',            (0, 255, 255): 'cyan',
            (0, 0, 255): 'blue',             (255, 0, 255): 'magenta',
            (192, 0, 0): 'dark_red',         (192, 192, 0): 'dark_yellow',
            (0, 192, 0): 'dark_green',       (0, 192, 192): 'dark_cyan',
            (0, 0, 192): 'dark_blue',        (192, 0, 192): 'dark_magenta',
            (255, 255, 255): 'white',        (0, 0, 0): 'black'
        }

        for color, positions in color_regions.items():
            color_name = piet_colors.get(color, f"unknown_{color}")
            print(f"  {color_name}: {len(positions)} pixels at {positions[:5]}{'...' if len(positions) > 5 else ''}")

        # Show the layout in ASCII
        print(f"\n📊 Visual layout (first 20x10 area):")
        color_chars = {}
        char_idx = 0
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789@#$%^&*'

        for y in range(min(10, img.height)):
            line = ""
            for x in range(min(20, img.width)):
                pixel = img.getpixel((x, y))
                if pixel not in color_chars:
                    color_chars[pixel] = chars[char_idx % len(chars)]
                    char_idx += 1
                line += color_chars[pixel]
            print(f"  {line}")

        print("\n🔤 Color legend:")
        for color, char in color_chars.items():
            color_name = piet_colors.get(color, f"unknown_{color}")
            print(f"  {char} = {color_name}")

        return color_regions

    except Exception as e:
        print(f"❌ Error analyzing {image_path}: {e}")
        return None

def trace_execution_path(image_path):
    """Trace how execution flows through the program"""

    print(f"\n🎯 Tracing execution path for {image_path}:")

    try:
        result = subprocess.run(['./piet', image_path, '16', '--debug'],
                              capture_output=True, text=True, timeout=5,
                              cwd='../files')

        if result.stdout:
            lines = result.stdout.strip().split('\n')
            print("📋 Execution trace:")
            for i, line in enumerate(lines[:15]):  # First 15 steps
                print(f"  {i+1:2d}: {line}")
            if len(lines) > 15:
                print(f"     ... and {len(lines)-15} more steps")

        if result.stderr:
            print(f"⚠️ Errors: {result.stderr}")

    except subprocess.TimeoutExpired:
        print("⏰ Execution timed out")
    except Exception as e:
        print(f"❌ Trace failed: {e}")

if __name__ == "__main__":
    print("🔍 ANALYZING WORKING PIET PROGRAMS 🔍")
    print("Learning the real structure and execution flow\n")

    # Analyze hi.png - our known working example
    print("=" * 50)
    analyze_image_structure('../files/test_images/hi.png')
    trace_execution_path('test_images/hi.png')

    print("\n" + "=" * 50)
    # Also analyze frankzago_hello.png
    analyze_image_structure('../files/test_images/frankzago_hello.png')
    trace_execution_path('test_images/frankzago_hello.png')

    print("\n🎓 Key learnings for building proper Piet programs:")
    print("1. Study the actual layout patterns")
    print("2. Understand connected regions vs isolated pixels")
    print("3. Map execution flow to see how transitions work")
    print("4. Build programs that match these proven patterns")