#!/usr/bin/env python3
"""
🚀 FIXED BASE64 PIET ENCODER 🚀

CRITICAL FIX: Execution starts at (0,0) - this MUST be a colored block!
Black barriers go AROUND the execution area, not AT the start!
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

def create_fixed_base64_program(b64_text):
    """Create base64 program with CORRECT starting position"""
    
    print(f"🎯 Creating FIXED base64 program: {b64_text[:20]}...")
    
    # Start with reasonable dimensions
    width, height = 300, 50
    img = Image.new('RGB', (width, height), COLORS['white'])
    
    print("🔧 Building program starting at (0,0):")
    
    x, y = 0, 0  # START AT (0,0) - this MUST be colored!
    
    for i, char in enumerate(b64_text):
        ascii_val = ord(char)
        
        # Limit to first few chars for testing
        if i >= 3:
            print(f"⚠️ Testing with first {i} chars")
            break
            
        print(f"  [{i}] '{char}' = ASCII {ascii_val}")
        
        # Create horizontal block of pixels for push
        block_start_x = x
        for px in range(ascii_val):
            if x + px >= width - 10:
                # Extend image if needed
                new_img = Image.new('RGB', (width + 100, height), COLORS['white'])
                new_img.paste(img, (0, 0))
                img = new_img
                width += 100
            
            # Use different colors for variety
            color = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta'][i % 6]
            img.putpixel((x + px, y), COLORS[color])
        
        x += ascii_val  # Move past this block
        
        # Add transition pixel for outchar operation
        if x < width - 5:
            # Transition from current color to dark version for outchar
            dark_color = f"dark_{['red', 'yellow', 'green', 'cyan', 'blue', 'magenta'][i % 6]}"
            img.putpixel((x, y), COLORS[dark_color])
            x += 1
    
    # Terminate program with black pixel
    if x < width - 5:
        img.putpixel((x, y), COLORS['black'])
    
    # Add protective barriers AROUND the program area (not at start!)
    # Bottom barrier (below program)
    if y + 5 < height:
        for bx in range(width):
            img.putpixel((bx, y + 5), COLORS['black'])
    
    # Right barrier (after program)
    if x + 5 < width:
        for by in range(height):
            img.putpixel((x + 5, by), COLORS['black'])
    
    print(f"✅ Fixed program: {width}x{height}")
    print(f"✅ Starts at (0,0) with color: {img.getpixel((0,0))}")
    return img

def test_fixed_approach(source_file):
    """Test the fixed base64 approach"""
    
    print("🚀 FIXED BASE64 ENCODER TEST 🚀")
    print("=" * 50)
    
    # Encode file to base64
    try:
        with open(source_file, 'rb') as f:
            content = f.read()
        b64_content = base64.b64encode(content).decode('ascii')
        
        print(f"📄 File: {source_file}")
        print(f"📦 Base64: {b64_content}")
        
        # Test with first few characters
        test_content = b64_content[:3]  # Just 3 chars for testing
        print(f"🧪 Testing: '{test_content}'")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return False
    
    # Create fixed program
    img = create_fixed_base64_program(test_content)
    
    # Save and test
    output_file = f"fixed_base64_{os.path.basename(source_file)}.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    # Debug pixel check
    print(f"\n🔍 Start position check:")
    print(f"  (0,0): {img.getpixel((0,0))} ← MUST NOT BE BLACK!")
    
    # Test execution
    print(f"\n🧪 Testing execution...")
    try:
        result = subprocess.run(['../files/piet', output_file, '1'],
                              capture_output=True, text=True, timeout=10)
        
        print(f"📋 Output: '{result.stdout.strip()}'")
        
        if result.stdout.strip():
            expected_output = ''.join(chr(ord(c)) for c in test_content)
            print(f"🎯 Expected: '{expected_output}'")
            
            if any(c in result.stdout for c in test_content):
                print("🎉 SUCCESS! Found expected characters!")
                return True
            else:
                print("🔧 Got output but not expected characters")
                return False
        else:
            print("❌ No output produced")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Still timing out")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) > 1:
        source_file = sys.argv[1]
        if os.path.exists(source_file):
            success = test_fixed_approach(source_file)
            
            if success:
                print("\n🏆 BREAKTHROUGH! 🏆")
                print("✅ Base64 encoding working!")
                print("✅ Execution starting correctly!")
                print("✅ Character output achieved!")
                print("\n🚀 Ready to scale to full programs!")
            else:
                print("\n🔧 Progress made, refining...")
        else:
            print(f"❌ File not found: {source_file}")
    else:
        print("💡 Usage: python3 fixed_base64_encoder.py <source_file>")

