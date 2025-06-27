#!/usr/bin/env python3
"""
🔍 ANALYZE WORKING PROGRAM STRUCTURE 🔍

Study exactly HOW working programs create their transitions.
The issue might be connectivity, not just color transitions!
"""

from PIL import Image
import sys

COLORS = {
    (255, 0, 0): 'red',
    (192, 0, 0): 'dark_red',
    (255, 255, 0): 'yellow',
    (192, 192, 0): 'dark_yellow',
    (0, 255, 0): 'green',
    (0, 192, 0): 'dark_green',
    (0, 255, 255): 'cyan',
    (0, 192, 192): 'dark_cyan',
    (0, 0, 255): 'blue',
    (0, 0, 192): 'dark_blue',
    (255, 0, 255): 'magenta',
    (192, 0, 192): 'dark_magenta',
    (255, 255, 255): 'white',
    (0, 0, 0): 'black'
}

def analyze_program_structure(image_path, max_analyze=20):
    """Analyze the first few blocks of a working program"""
    
    print(f"🔍 Analyzing structure: {image_path}")
    print("=" * 60)
    
    try:
        img = Image.open(image_path)
        width, height = img.size
        
        print(f"📐 Image size: {width}x{height}")
        
        # Show the starting area in detail
        print("\n📍 Starting area (first 20x10):")
        for y in range(min(10, height)):
            row = ""
            for x in range(min(20, width)):
                pixel = img.getpixel((x, y))
                color_name = COLORS.get(pixel, f"RGB{pixel}")
                
                # Use single letter abbreviations
                abbrev = {
                    'red': 'R', 'dark_red': 'r',
                    'yellow': 'Y', 'dark_yellow': 'y',
                    'green': 'G', 'dark_green': 'g',
                    'cyan': 'C', 'dark_cyan': 'c',
                    'blue': 'B', 'dark_blue': 'b',
                    'magenta': 'M', 'dark_magenta': 'm',
                    'white': '.', 'black': '#'
                }.get(color_name, '?')
                
                row += abbrev
            print(f"  {y:2}: {row}")
        
        # Find connected regions
        print(f"\n🔗 Analyzing connected blocks:")
        
        visited = set()
        block_count = 0
        
        def flood_fill(start_x, start_y, target_color):
            """Find all connected pixels of the same color"""
            if (start_x, start_y) in visited:
                return []
            if start_x < 0 or start_x >= width or start_y < 0 or start_y >= height:
                return []
            if img.getpixel((start_x, start_y)) != target_color:
                return []
            
            visited.add((start_x, start_y))
            pixels = [(start_x, start_y)]
            
            # Check 4-connected neighbors
            for dx, dy in [(0,1), (0,-1), (1,0), (-1,0)]:
                pixels.extend(flood_fill(start_x + dx, start_y + dy, target_color))
            
            return pixels
        
        # Analyze first few blocks
        for y in range(min(5, height)):
            for x in range(min(50, width)):
                if (x, y) not in visited:
                    pixel = img.getpixel((x, y))
                    if pixel != (255, 255, 255) and pixel != (0, 0, 0):  # Not white or black
                        block_pixels = flood_fill(x, y, pixel)
                        if block_pixels:
                            block_count += 1
                            color_name = COLORS.get(pixel, f"RGB{pixel}")
                            print(f"  Block {block_count}: {color_name} at ({x},{y}) - {len(block_pixels)} pixels")
                            
                            if block_count >= 10:  # Limit output
                                break
            if block_count >= 10:
                break
        
        # Show transitions between first few blocks
        print(f"\n🔄 Color transitions in execution path:")
        prev_color = None
        transition_count = 0
        
        for x in range(min(100, width)):
            pixel = img.getpixel((x, 0))  # Scan along top row
            color_name = COLORS.get(pixel, f"RGB{pixel}")
            
            if color_name != 'white' and color_name != prev_color:
                if prev_color:
                    print(f"  {transition_count}: {prev_color} → {color_name}")
                    transition_count += 1
                    if transition_count >= 5:
                        break
                prev_color = color_name
        
        return True
        
    except Exception as e:
        print(f"❌ Error analyzing {image_path}: {e}")
        return False

if __name__ == "__main__":
    # Analyze known working programs
    working_programs = [
        "../files/test_images/hi.png",
        "../files/test_images/frankzago_hello.png",
    ]
    
    for program in working_programs:
        try:
            if analyze_program_structure(program):
                print("\n" + "="*60 + "\n")
        except:
            print(f"❌ Could not analyze {program}")

