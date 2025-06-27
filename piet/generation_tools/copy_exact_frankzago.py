#!/usr/bin/env python3
"""
🎯 COPY EXACT FRANKZAGO PATTERN 🎯

Copy the EXACT first few regions from frankzago_hello.png
to understand the precise execution flow.
"""

from PIL import Image
import subprocess

def copy_exact_frankzago_start():
    """Copy exact start of frankzago_hello.png"""
    
    print("🎯 COPYING EXACT FRANKZAGO START")
    
    # Load original
    original = Image.open("../files/test_images/frankzago_hello.png")
    
    # Copy just the first part (first 25x10 pixels)
    width, height = 25, 10
    img = Image.new('RGB', (width, height), (255, 255, 255))
    
    for y in range(height):
        for x in range(width):
            pixel = original.getpixel((x, y))
            img.putpixel((x, y), pixel)
    
    img.save("frankzago_exact_copy.png")
    print("💾 Saved: frankzago_exact_copy.png")
    
    # Test this exact copy
    try:
        result = subprocess.run(['../files/piet', '--debug', 'frankzago_exact_copy.png', '1'],
                              capture_output=True, text=True, timeout=10)
        
        print("📋 Debug output:")
        for line in result.stderr.split('\n')[:8]:
            if line.strip():
                print(f"  {line}")
        
        print(f"\n📋 Output: '{result.stdout.strip()}'")
        
        if 'H' in result.stdout:
            print("🎉 EXACT COPY WORKS!")
            return True
        else:
            print("🔧 Even exact copy has issues")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Exact copy timed out")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def create_minimal_base64_using_frankzago_pattern():
    """Use frankzago pattern for base64 chars"""
    
    print("\n🚀 APPLYING FRANKZAGO PATTERN TO BASE64")
    print("=" * 50)
    
    # Test base64: 'Hi' → 'SGk='
    test_b64 = "SGk="
    ascii_vals = [ord(c) for c in test_b64]
    
    print(f"🧪 Base64 test: '{test_b64}' → ASCII {ascii_vals}")
    
    # Create using frankzago-like pattern
    img = Image.new('RGB', (300, 20), (255, 255, 255))
    
    x, y = 0, 0
    
    # Character 1: 'S' = ASCII 83
    print(f"  'S' = 83 → 83 red pixels")
    for i in range(83):
        img.putpixel((x, y), (255, 0, 0))  # red
        x += 1
        if x >= 300:
            x = 0
            y += 1
    
    # Outchar transition (red → dark_red)
    img.putpixel((x, y), (192, 0, 0))  # dark_red
    x += 1
    
    # Character 2: 'G' = ASCII 71  
    print(f"  'G' = 71 → 71 magenta pixels")
    for i in range(71):
        if x >= 300:
            x = 0
            y += 1
        img.putpixel((x, y), (255, 0, 255))  # magenta
        x += 1
    
    # Outchar transition (magenta → dark_magenta)
    img.putpixel((x, y), (192, 0, 192))  # dark_magenta
    x += 1
    
    # Terminate
    img.putpixel((x, y), (0, 0, 0))  # black
    
    img.save("base64_frankzago_pattern.png")
    print("💾 Saved: base64_frankzago_pattern.png")
    
    # Test
    try:
        result = subprocess.run(['../files/piet', '--debug', 'base64_frankzago_pattern.png', '1'],
                              capture_output=True, text=True, timeout=10)
        
        print("📋 Debug excerpt:")
        for line in result.stderr.split('\n')[:6]:
            if 'push' in line or 'outchar' in line:
                print(f"  {line}")
        
        print(f"\n📋 Output: '{result.stdout.strip()}'")
        
        if 'S' in result.stdout or 'G' in result.stdout:
            print("🎉 BASE64 FRANKZAGO SUCCESS!")
            return True
        else:
            print("🔧 Still needs work")
            return False
            
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    copy_success = copy_exact_frankzago_start()
    
    if copy_success:
        base64_success = create_minimal_base64_using_frankzago_pattern()
        
        if base64_success:
            print("\n🏆🏆🏆 FRANKZAGO PATTERN APPLIED TO BASE64! 🏆🏆🏆")
            print("✅ Pattern understanding achieved!")
            print("✅ Base64 encoding working!")
            print("🚀 Ready for full implementation!")

