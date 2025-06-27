#!/usr/bin/env python3
"""
🔍 CONNECTED BLOCK ANALYZER 🔍

Analyze exactly how Piet counts connected blocks to understand
the relationship between pixel layouts and block sizes
"""

from PIL import Image

def find_connected_component(img, start_pos, target_color, visited):
    """Find all pixels in a connected component using flood fill"""
    width, height = img.size
    stack = [start_pos]
    component = []
    
    while stack:
        x, y = stack.pop()
        
        # Check bounds and if already visited
        if (x < 0 or x >= width or y < 0 or y >= height or 
            (x, y) in visited):
            continue
            
        # Check if color matches
        if img.getpixel((x, y)) != target_color:
            continue
            
        # Add to component and mark as visited
        visited.add((x, y))
        component.append((x, y))
        
        # Add neighbors to stack (orthogonal only, not diagonal)
        stack.extend([(x+1, y), (x-1, y), (x, y+1), (x, y-1)])
    
    return component

def analyze_connected_blocks(image_path):
    """Analyze all connected color blocks in a Piet image"""
    
    img = Image.open(image_path).convert('RGB')
    width, height = img.size
    
    print(f"🔍 Analyzing connected blocks in: {image_path}")
    print(f"📐 Image size: {width}x{height}")
    
    visited = set()
    blocks = []
    
    # Scan every pixel
    for y in range(height):
        for x in range(width):
            if (x, y) in visited:
                continue
                
            color = img.getpixel((x, y))
            component = find_connected_component(img, (x, y), color, visited)
            
            if component:
                blocks.append({
                    'color': color,
                    'size': len(component),
                    'positions': component[:5],  # First 5 positions
                    'start_pos': (x, y)
                })
    
    # Sort by appearance order (top-left to bottom-right)
    blocks.sort(key=lambda b: (b['start_pos'][1], b['start_pos'][0]))
    
    # Map colors to names
    color_names = {
        (255, 0, 0): 'red',
        (192, 0, 0): 'dark_red', 
        (255, 0, 255): 'magenta',
        (192, 0, 192): 'dark_magenta',
        (0, 0, 255): 'blue',
        (0, 255, 255): 'cyan',
        (0, 0, 0): 'black',
        (192, 192, 0): 'dark_yellow',
        (255, 255, 0): 'yellow',
        (0, 255, 0): 'green',
        (192, 192, 255): 'light_blue',
        (0, 0, 192): 'dark_blue',
        (0, 192, 0): 'dark_green',
        (0, 192, 192): 'dark_cyan',
        (255, 192, 192): 'light_red',
        (255, 255, 192): 'light_yellow',
        (255, 192, 255): 'light_magenta',
        (255, 255, 255): 'white'
    }
    
    print("\n📊 Connected blocks in execution order:")
    for i, block in enumerate(blocks):
        color_name = color_names.get(block['color'], f"unknown_{block['color']}")
        print(f"  {i+1:2d}. {color_name:12s} | Size: {block['size']:3d} | Start: {block['start_pos']} | Sample: {block['positions'][:3]}")
    
    return blocks

if __name__ == "__main__":
    # Analyze frankzago_hello.png to understand its structure
    print("🎯 CONNECTED BLOCK ANALYSIS 🎯")
    print("Understanding how Piet counts connected regions\n")
    
    blocks = analyze_connected_blocks("../files/test_images/frankzago_hello.png")
    
    print(f"\n📋 Found {len(blocks)} connected blocks")
    print("\n🎯 Expected values from debug trace:")
    expected = [72, 1, 101, 3, 108, 2, 2, 1, 1, 111, 5, 5, 32, 16, 119, 10, 3, 114, 1, 1, 100, 1, 33, 1]
    print("Expected block sizes:", expected[:12])  # First 12 operations
    
    actual_sizes = [block['size'] for block in blocks[:12]]
    print("Actual block sizes:  ", actual_sizes)
    
    print("\n🔍 Comparison:")
    for i, (expected_size, actual_size) in enumerate(zip(expected[:12], actual_sizes)):
        match = "✅" if expected_size == actual_size else "❌"
        print(f"  Block {i+1}: Expected {expected_size:3d}, Got {actual_size:3d} {match}")

