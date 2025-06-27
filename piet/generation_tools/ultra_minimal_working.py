#!/usr/bin/env python3
"""
🎯 ULTRA MINIMAL WORKING PROGRAM 🎯

Create the absolute smallest possible working Piet program:
Just push 72 → outchar 'H' → terminate

Based on frankzago analysis:
- 72 red pixels (push 72)
- 1 dark_red pixel (outchar)  
- 1 black pixel (terminate)
"""

from PIL import Image
import subprocess

COLORS = {
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'white': (255, 255, 255),
    'black': (0, 0, 0)
}

def create_ultra_minimal():
    """Create ultra minimal: 72 red + 1 dark_red + 1 black"""
    
    print("🎯 Creating ULTRA MINIMAL Piet program")
    print("Pattern: 72×red → 1×dark_red → 1×black")
    
    # Calculate minimal dimensions
    total_pixels = 72 + 1 + 1  # 74 pixels total
    width = 80
    height = 2
    
    img = Image.new('RGB', (width, height), COLORS['white'])
    
    x, y = 0, 0
    
    # 72 red pixels (push 72)
    print("  Adding 72 red pixels (push 72)...")
    for i in range(72):
        img.putpixel((x, y), COLORS['red'])
        x += 1
        if x >= width:
            x = 0
            y += 1
    
    # 1 dark_red pixel (outchar)
    print("  Adding 1 dark_red pixel (outchar)...")
    img.putpixel((x, y), COLORS['dark_red'])
    x += 1
    
    # 1 black pixel (terminate)
    print("  Adding 1 black pixel (terminate)...")
    img.putpixel((x, y), COLORS['black'])
    
    print(f"✅ Ultra minimal: {width}x{height}")
    return img

def test_ultra_minimal():
    """Test the ultra minimal program"""
    
    print("🧪 ULTRA MINIMAL TEST 🧪")
    print("=" * 40)
    
    img = create_ultra_minimal()
    
    output_file = "ultra_minimal_H.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    # Verify starting pixel
    start_pixel = img.getpixel((0, 0))
    print(f"🔍 Start pixel (0,0): {start_pixel} {'✅' if start_pixel == COLORS['red'] else '❌'}")
    
    # Test execution
    print(f"\n🧪 Testing execution...")
    try:
        result = subprocess.run(['../files/piet', '--debug', output_file, '1'],
                              capture_output=True, text=True, timeout=5)
        
        debug_output = result.stderr
        program_output = result.stdout.strip()
        
        print("📋 Debug output:")
        for line in debug_output.split('\n')[:6]:
            if line.strip():
                print(f"  {line}")
        
        print(f"\n📋 Program output: '{program_output}'")
        
        if program_output == 'H':
            print("🎉 PERFECT! Ultra minimal working!")
            return True
        elif program_output:
            print(f"🔧 Got output '{program_output}' (expected 'H')")
            return False
        else:
            print("❌ No output")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Timeout on ultra minimal!")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def try_even_simpler():
    """Try with even smaller values"""
    
    print("\n🎯 EVEN SIMPLER TEST: ASCII 33 ('!')")
    print("=" * 40)
    
    img = Image.new('RGB', (40, 2), COLORS['white'])
    
    x, y = 0, 0
    
    # 33 red pixels (push 33 = '!')  
    for i in range(33):
        img.putpixel((x, y), COLORS['red'])
        x += 1
    
    # 1 dark_red pixel (outchar)
    img.putpixel((x, y), COLORS['dark_red'])
    x += 1
    
    # 1 black pixel (terminate)
    img.putpixel((x, y), COLORS['black'])
    
    output_file = "ultra_simple_exclaim.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    try:
        result = subprocess.run(['../files/piet', output_file, '1'],
                              capture_output=True, text=True, timeout=3)
        
        print(f"📋 Output: '{result.stdout.strip()}'")
        
        if result.stdout.strip() == '!':
            print("🎉 SIMPLE SUCCESS!")
            return True
        else:
            print("🔧 Still not working")
            return False
            
    except:
        print("❌ Failed")
        return False

if __name__ == "__main__":
    success1 = test_ultra_minimal()
    
    if not success1:
        success2 = try_even_simpler()
        
        if not success2:
            print("\n❌ Even ultra minimal programs not working")
            print("🔍 Need to examine actual working program structure")
            print("💡 The issue may be spatial connectivity, not just colors")

