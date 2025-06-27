#!/usr/bin/env python3
"""
🎯 EXACT FRANKZAGO PATTERN COPY 🎯

Copy the EXACT layout pattern from frankzago_hello.png:
- 72 red pixels → 1 dark_red pixel → 101 magenta pixels → 1 dark_magenta pixel...

Let's replicate this EXACTLY but with base64 ASCII values!
"""

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

def create_exact_frankzago_pattern(ascii_values):
    """Create EXACT frankzago layout but with our ASCII values"""
    
    print(f"🎯 Creating EXACT frankzago pattern for ASCII: {ascii_values}")
    
    # Use frankzago dimensions (30x29) but allow extension
    width, height = 50, 30
    img = Image.new('RGB', (width, height), COLORS['white'])
    
    # Color pairs (matching frankzago pattern)
    color_pairs = [
        ('red', 'dark_red'),
        ('magenta', 'dark_magenta'), 
        ('blue', 'dark_blue'),
        ('cyan', 'dark_cyan'),
        ('green', 'dark_green'),
        ('yellow', 'dark_yellow')
    ]
    
    x, y = 0, 0
    
    print("🔧 Building blocks with frankzago layout:")
    
    for i, ascii_val in enumerate(ascii_values):
        color_base, color_dark = color_pairs[i % len(color_pairs)]
        
        print(f"  Block {i+1}: {ascii_val} {color_base} pixels → 1 {color_dark} pixel")
        
        # Create main block (horizontal fill, then wrap to next row)
        pixels_placed = 0
        start_x, start_y = x, y
        
        # Fill the push block
        for row in range(height):
            for col in range(width):
                if pixels_placed >= ascii_val:
                    break
                
                px, py = start_x + col, start_y + row
                if px >= width:
                    # Wrap to next row
                    start_y += 1
                    px = 0
                    py = start_y
                    start_x = 0
                
                if py < height:
                    img.putpixel((px, py), COLORS[color_base])
                    pixels_placed += 1
                    x = px + 1
                    y = py
            
            if pixels_placed >= ascii_val:
                break
        
        # Place the outchar pixel (1 dark pixel)
        if x >= width:
            x = 0
            y += 1
        
        if y < height:
            img.putpixel((x, y), COLORS[color_dark])
            x += 1
        
        # Small gap
        x += 1
        if x >= width:
            x = 0
            y += 1
    
    print(f"✅ Exact pattern created: {width}x{height}")
    return img

def test_exact_pattern():
    """Test with simple ASCII values first"""
    
    print("🎯 EXACT FRANKZAGO PATTERN TEST 🎯")
    print("=" * 50)
    
    # Test with simple values first (like 'Hi')
    test_ascii = [72, 105]  # 'H', 'i'
    test_chars = ''.join(chr(val) for val in test_ascii)
    
    print(f"🧪 Testing with: '{test_chars}' (ASCII {test_ascii})")
    
    img = create_exact_frankzago_pattern(test_ascii)
    
    output_file = "exact_frankzago_test.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    # Test execution
    print(f"\n🧪 Testing execution...")
    try:
        result = subprocess.run(['../files/piet', '--debug', output_file, '1'],
                              capture_output=True, text=True, timeout=10)
        
        debug_output = result.stderr
        program_output = result.stdout.strip()
        
        print("📋 First few debug lines:")
        for line in debug_output.split('\n')[:8]:
            if line.strip():
                print(f"  {line}")
        
        print(f"\n📋 Program output: '{program_output}'")
        
        if program_output:
            print(f"🎯 Expected: '{test_chars}'")
            if test_chars[0] in program_output or test_chars[1] in program_output:
                print("🎉 SUCCESS! Found expected characters!")
                return True
            else:
                print("🔧 Got output but wrong characters")
        else:
            print("❌ No output")
        
        return False
        
    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def test_with_base64():
    """Test with actual base64 characters"""
    
    print("\n🎯 BASE64 CHARACTER TEST 🎯")
    print("=" * 50)
    
    # Get base64 for simple content
    test_content = "Hi"
    b64_content = __import__('base64').b64encode(test_content.encode()).decode()
    
    print(f"📄 Original: '{test_content}'")
    print(f"📦 Base64: '{b64_content}'")
    
    # Test with first 2 base64 characters
    test_b64_chars = b64_content[:2]
    test_ascii = [ord(c) for c in test_b64_chars]
    
    print(f"🧪 Testing base64: '{test_b64_chars}' (ASCII {test_ascii})")
    
    img = create_exact_frankzago_pattern(test_ascii)
    
    output_file = "exact_frankzago_base64.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    try:
        result = subprocess.run(['../files/piet', output_file, '1'],
                              capture_output=True, text=True, timeout=10)
        
        program_output = result.stdout.strip()
        print(f"📋 Output: '{program_output}'")
        
        if any(c in program_output for c in test_b64_chars):
            print("🎉 BASE64 SUCCESS!")
            return True
        else:
            print("🔧 Base64 needs adjustment")
            return False
            
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    success1 = test_exact_pattern()
    
    if success1:
        success2 = test_with_base64()
        
        if success2:
            print("\n🏆🏆🏆 FRANKZAGO PATTERN SUCCESS! 🏆🏆🏆")
            print("✅ Exact frankzago pattern working!")
            print("✅ Base64 encoding possible!")
            print("�� Ready for full implementation!")

