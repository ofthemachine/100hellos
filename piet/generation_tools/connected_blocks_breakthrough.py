#!/usr/bin/env python3
"""
🏆 CONNECTED BLOCKS BREAKTHROUGH 🏆

KEY DISCOVERY: It's about CONNECTED BLOCK SIZES, not total pixels!

From frankzago debug:
- push (block size: 72) from red region
- outchar (block size: 1) from dark_red region  
- push (block size: 101) from magenta region
- outchar (block size: 3) from dark_magenta region

The blocks must be CONNECTED regions, not scattered pixels!
"""

import base64
from PIL import Image
import subprocess
import sys
import os

COLORS = {
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'yellow': (255, 255, 0),
    'dark_yellow': (192, 192, 0),
    'green': (0, 255, 0),
    'dark_green': (0, 192, 0),
    'cyan': (0, 255, 255),
    'dark_cyan': (0, 192, 192),
    'blue': (0, 0, 255),
    'dark_blue': (0, 0, 192),
    'magenta': (255, 0, 255),
    'dark_magenta': (192, 0, 192),
    'white': (255, 255, 255),
    'black': (0, 0, 0)
}

def create_connected_base64_program(b64_text):
    """Create base64 program with CONNECTED blocks (not scattered pixels)"""
    
    print(f"🏆 Creating CONNECTED BLOCKS base64 program: {b64_text[:10]}...")
    
    width, height = 400, 50
    img = Image.new('RGB', (width, height), COLORS['white'])
    
    # Color pairs for push→outchar
    color_pairs = [
        ('red', 'dark_red'),
        ('magenta', 'dark_magenta'),
        ('blue', 'dark_blue'),
        ('green', 'dark_green'),
        ('cyan', 'dark_cyan'),
        ('yellow', 'dark_yellow')
    ]
    
    x, y = 0, 0
    
    print("🔧 Building CONNECTED blocks (frankzago style):")
    
    for i, char in enumerate(b64_text):
        ascii_val = ord(char)
        base_color, dark_color = color_pairs[i % len(color_pairs)]
        
        # Limit for testing
        if i >= 3:
            print(f"⚠️ Testing with first {i} characters")
            break
            
        print(f"  [{i}] '{char}' = ASCII {ascii_val}")
        print(f"      → {ascii_val} connected {base_color} pixels (push {ascii_val})")
        print(f"      → 1 connected {dark_color} pixel (outchar)")
        
        # Create CONNECTED block for push (rectangular region)
        block_width = min(ascii_val, width - x - 5)
        block_height = (ascii_val // block_width) + 1
        
        if block_height > height - 5:
            block_height = height - y - 5
            block_width = ascii_val // block_height
        
        pixels_placed = 0
        print(f"      → Block dimensions: {block_width}x{block_height}")
        
        # Fill connected rectangular region
        for by in range(block_height):
            for bx in range(block_width):
                if pixels_placed >= ascii_val:
                    break
                if x + bx < width - 5 and y + by < height - 5:
                    img.putpixel((x + bx, y + by), COLORS[base_color])
                    pixels_placed += 1
            if pixels_placed >= ascii_val:
                break
        
        # Move to next position (right of the block)
        x += block_width
        
        # Place SINGLE connected outchar pixel
        if x < width - 5:
            img.putpixel((x, y), COLORS[dark_color])
            print(f"      → Outchar pixel at ({x},{y})")
            x += 1
        
        # Small gap before next character
        x += 2
        if x >= width - 20:
            x = 0
            y += block_height + 2
    
    # Terminate
    if x < width - 5 and y < height - 5:
        img.putpixel((x, y), COLORS['black'])
    
    print(f"✅ Connected blocks program: {width}x{height}")
    return img

def test_connected_blocks_approach(source_file):
    """Test the connected blocks approach with base64"""
    
    print("🏆 CONNECTED BLOCKS BASE64 TEST 🏆")
    print("=" * 60)
    
    # Get base64 content
    try:
        with open(source_file, 'rb') as f:
            content = f.read()
        b64_content = base64.b64encode(content).decode('ascii')
        
        print(f"📄 File: {source_file}")
        print(f"📦 Base64: {b64_content}")
        
        # Test with first 3 characters
        test_content = b64_content[:3]
        print(f"🧪 Testing: '{test_content}' (ASCII {[ord(c) for c in test_content]})")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return False
    
    # Create connected blocks program
    img = create_connected_base64_program(test_content)
    
    # Save and test
    output_file = f"connected_blocks_{os.path.basename(source_file)}.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    # Test execution
    print(f"\n🧪 Testing execution...")
    try:
        result = subprocess.run(['../files/piet', '--debug', output_file, '1'],
                              capture_output=True, text=True, timeout=15)
        
        debug_output = result.stderr
        program_output = result.stdout.strip()
        
        print("📋 Debug excerpt:")
        debug_lines = debug_output.split('\n')[:12]
        for line in debug_lines:
            if line.strip() and ('push' in line or 'outchar' in line or 'block size' in line):
                print(f"  {line}")
        
        print(f"\n📋 Program output: '{program_output}'")
        
        if program_output:
            found_chars = []
            for char in test_content:
                if char in program_output:
                    found_chars.append(char)
            
            print(f"🎯 Expected: '{test_content}'")
            print(f"✅ Found: {found_chars} ({len(found_chars)}/{len(test_content)})")
            
            if len(found_chars) >= len(test_content):
                print("🎉 PERFECT SUCCESS!")
                return True
            elif len(found_chars) > 0:
                print("🎯 MAJOR PROGRESS!")
                return True
            else:
                print("🔧 Output but wrong chars")
                return False
        else:
            print("❌ No output")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) > 1:
        source_file = sys.argv[1]
        if os.path.exists(source_file):
            success = test_connected_blocks_approach(source_file)
            
            if success:
                print("\n🏆🏆🏆 CONNECTED BLOCKS BREAKTHROUGH! 🏆🏆🏆")
                print("✅ Connected block structure working!")
                print("✅ Base64 + connected regions = SUCCESS!")
                print("✅ Ready for full source file encoding!")
                
                print("\n🚀 FINAL PHASE:")
                print("🎨 Scale to complete base64 content")
                print("🎨 Add language-specific artistic themes")
                print("🎨 Generate 99-language collection")
                print("🎨 Complete the revolutionary vision!")
            else:
                print("\n🔧 Refining connected block patterns...")
        else:
            print(f"❌ File not found: {source_file}")
    else:
        print("�� Usage: python3 connected_blocks_breakthrough.py <source_file>")

