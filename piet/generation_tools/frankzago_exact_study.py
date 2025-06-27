#!/usr/bin/env python3
"""
🔍 EXACT FRANKZAGO PIXEL STUDY 🔍

Study the EXACT pixel placement in frankzago_hello.png to understand
how the Direction Pointer navigates between connected regions.
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

def study_frankzago_exact():
    """Study the exact pixel layout of frankzago_hello.png"""
    
    print("🔍 EXACT FRANKZAGO PIXEL STUDY")
    print("=" * 50)
    
    try:
        img = Image.open("../files/test_images/frankzago_hello.png")
        width, height = img.size
        
        print(f"�� Image: {width}x{height}")
        
        # Show exact pixel layout for first 30 columns and 15 rows
        print("\n📍 Exact pixel layout (showing transitions):")
        
        for y in range(min(15, height)):
            row = f"{y:2}: "
            for x in range(min(30, width)):
                pixel = img.getpixel((x, y))
                color_name = COLORS.get(pixel, '?')
                
                # Use abbreviations
                abbrev = {
                    'red': 'R', 'dark_red': 'r',
                    'magenta': 'M', 'dark_magenta': 'm',
                    'blue': 'B', 'dark_blue': 'b',
                    'cyan': 'C', 'dark_cyan': 'c',
                    'green': 'G', 'dark_green': 'g',
                    'yellow': 'Y', 'dark_yellow': 'y',
                    'white': '.', 'black': '#'
                }.get(color_name, '?')
                
                row += abbrev
            print(row)
        
        # Find exact transition points along top row
        print(f"\n🔄 Exact transitions in top row (y=0):")
        prev_color = None
        transition_x = []
        
        for x in range(width):
            pixel = img.getpixel((x, 0))
            color_name = COLORS.get(pixel, f"RGB{pixel}")
            
            if color_name != prev_color:
                if prev_color:
                    transition_x.append((x, prev_color, color_name))
                prev_color = color_name
        
        for x, from_color, to_color in transition_x[:10]:
            print(f"  x={x:2}: {from_color} → {to_color}")
        
        # Analyze connected regions starting from (0,0)
        print(f"\n🔗 Connected regions analysis:")
        
        def flood_fill_region(start_x, start_y, target_color, visited):
            """Find connected region size"""
            if (start_x, start_y) in visited:
                return 0
            if start_x < 0 or start_x >= width or start_y < 0 or start_y >= height:
                return 0
            if img.getpixel((start_x, start_y)) != target_color:
                return 0
            
            visited.add((start_x, start_y))
            size = 1
            
            # Check 4-connected neighbors
            for dx, dy in [(0,1), (0,-1), (1,0), (-1,0)]:
                size += flood_fill_region(start_x + dx, start_y + dy, target_color, visited)
            
            return size
        
        visited = set()
        region_count = 0
        
        for x in range(min(25, width)):
            for y in range(min(5, height)):
                if (x, y) not in visited:
                    pixel = img.getpixel((x, y))
                    if pixel != (255, 255, 255):  # Not white
                        color_name = COLORS.get(pixel, f"RGB{pixel}")
                        region_size = flood_fill_region(x, y, pixel, visited)
                        if region_size > 0:
                            region_count += 1
                            print(f"  Region {region_count}: {color_name} at ({x},{y}) - {region_size} pixels")
                            
                            if region_count >= 8:  # Limit output
                                break
            if region_count >= 8:
                break
        
        # Check specific key positions
        print(f"\n🎯 Key positions:")
        key_positions = [(0,0), (11,0), (12,0), (19,0), (20,0)]
        for x, y in key_positions:
            if x < width and y < height:
                pixel = img.getpixel((x, y))
                color_name = COLORS.get(pixel, f"RGB{pixel}")
                print(f"  ({x:2},{y}): {color_name} {pixel}")
        
        return True
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def create_exact_frankzago_replica():
    """Create an exact replica based on the study"""
    
    print(f"\n🎯 CREATING EXACT REPLICA")
    print("=" * 50)
    
    # Based on frankzago study, create minimal replica
    img = Image.new('RGB', (25, 3), (255, 255, 255))
    
    # From debug: push(72) → outchar(1) → push(101) → outchar(3)
    # From analyzer: red→dark_red→magenta→dark_magenta
    
    x = 0
    
    # 72 red pixels (push 72)
    for i in range(72):
        if x < 24:
            img.putpixel((x, 0), (255, 0, 0))  # red
            x += 1
        else:
            break
    
    # 1 dark_red pixel (outchar)
    if x < 24:
        img.putpixel((x, 0), (192, 0, 0))  # dark_red
        x += 1
    
    # Start next row for more space
    x = 0
    y = 1
    
    # 101 magenta pixels (push 101)  
    for i in range(min(101, 20)):  # Limit for test
        if x < 24:
            img.putpixel((x, y), (255, 0, 255))  # magenta
            x += 1
        else:
            break
    
    # 1 dark_magenta pixel (outchar)
    if x < 24:
        img.putpixel((x, y), (192, 0, 192))  # dark_magenta
        x += 1
    
    # Terminate
    if x < 24:
        img.putpixel((x, y), (0, 0, 0))  # black
    
    img.save("exact_frankzago_replica.png")
    print("💾 Saved: exact_frankzago_replica.png")
    
    # Test
    import subprocess
    try:
        result = subprocess.run(['../files/piet', 'exact_frankzago_replica.png', '1'],
                              capture_output=True, text=True, timeout=5)
        
        print(f"📋 Output: '{result.stdout.strip()}'")
        
        if 'H' in result.stdout:
            print("🎉 REPLICA SUCCESS! Found 'H'!")
            return True
        else:
            print("🔧 Replica needs adjustment")
            return False
            
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    study_success = study_frankzago_exact()
    
    if study_success:
        replica_success = create_exact_frankzago_replica()
        
        if replica_success:
            print("\n🏆 EXACT PATTERN DISCOVERED!")
            print("✅ Frankzago structure understood!")
            print("✅ Ready to apply to base64 encoding!")

