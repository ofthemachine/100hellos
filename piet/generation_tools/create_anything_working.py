#!/usr/bin/env python3
"""
🎯 CREATE ANYTHING WORKING 🎯

Goal: Generate the SIMPLEST possible working Piet program from scratch.
Just output ONE character. That's it. Prove we can create NEW programs.

Start with absolute basics:
- Push 72 (ASCII 'H')
- Output character
- Terminate cleanly
"""

from PIL import Image
import subprocess
import sys

COLORS = {
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'white': (255, 255, 255),
    'black': (0, 0, 0)
}

def create_ultra_simple_H():
    """Create the simplest possible program: just output 'H'"""
    
    print("🎯 Creating ULTRA SIMPLE 'H' program")
    print("Goal: push 72 → outchar → terminate")
    
    # Super minimal: 5x20 pixels
    img = Image.new('RGB', (100, 5), COLORS['white'])
    
    x, y = 0, 0
    
    # Method 1: Try exact frankzago pattern in miniature
    print("Method: Copy frankzago pattern exactly")
    
    # 72 red pixels in a line (push 72)
    for i in range(72):
        img.putpixel((x, y), COLORS['red'])
        x += 1
        if x >= 99:  # Leave room for outchar
            break
    
    # 1 dark_red pixel (outchar)
    img.putpixel((x, y), COLORS['dark_red'])
    
    print(f"Program: 72 red pixels + 1 dark_red pixel")
    print(f"Expected: push 72 → outchar 'H'")
    
    img.save("ultra_simple_H.png")
    return "ultra_simple_H.png"

def create_even_simpler():
    """Try with smaller ASCII value"""
    
    print("\n🎯 Creating EVEN SIMPLER program")
    print("Goal: push 33 → outchar '!' → terminate")
    
    img = Image.new('RGB', (40, 5), COLORS['white'])
    
    x, y = 0, 0
    
    # 33 red pixels (push 33 = '!')
    for i in range(33):
        img.putpixel((x, y), COLORS['red'])
        x += 1
    
    # 1 dark_red pixel (outchar)
    img.putpixel((x, y), COLORS['dark_red'])
    
    print(f"Program: 33 red pixels + 1 dark_red pixel")
    print(f"Expected: push 33 → outchar '!'")
    
    img.save("even_simpler_exclaim.png")
    return "even_simpler_exclaim.png"

def create_tiny_number():
    """Try with very small number"""
    
    print("\n🎯 Creating TINY program")
    print("Goal: push 10 → outchar newline")
    
    img = Image.new('RGB', (15, 5), COLORS['white'])
    
    x, y = 0, 0
    
    # 10 red pixels (push 10 = newline)
    for i in range(10):
        img.putpixel((x, y), COLORS['red'])
        x += 1
    
    # 1 dark_red pixel (outchar)
    img.putpixel((x, y), COLORS['dark_red'])
    
    print(f"Program: 10 red pixels + 1 dark_red pixel")
    print(f"Expected: push 10 → outchar newline")
    
    img.save("tiny_newline.png")
    return "tiny_newline.png"

def test_program(filename):
    """Test a generated program"""
    
    print(f"\n🧪 Testing {filename}...")
    
    try:
        # Try with debug first
        result = subprocess.run(['../files/piet', '--debug', filename, '1'],
                              capture_output=True, text=True, timeout=3)
        
        debug_output = result.stderr
        program_output = result.stdout
        
        print("📋 Debug output:")
        for line in debug_output.split('\n')[:5]:
            if line.strip():
                print(f"  {line}")
        
        print(f"📋 Program output: '{repr(program_output)}'")
        
        if program_output:
            print("🎉 SUCCESS! Program produced output!")
            return True
        elif "finished after" in debug_output:
            print("✅ Program terminated cleanly (no output)")
            return True
        else:
            print("❌ No output and unclear termination")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Timeout")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def analyze_differences():
    """Compare our programs with working ones"""
    
    print("\n🔍 ANALYZING DIFFERENCES")
    print("=" * 40)
    
    # Show our program structure
    print("Our programs:")
    print("  Pattern: N red pixels → 1 dark_red pixel")
    print("  Layout: Horizontal line")
    print("  Background: White")
    
    # Show frankzago structure (from earlier analysis)
    print("\nFrankzago structure:")
    print("  Block 1: red (72 pixels) → push 72")
    print("  Block 2: dark_red (1 pixel) → outchar")
    print("  Layout: Complex 2D pattern with other colors")
    print("  Background: White + other colored regions")
    
    print("\n💡 Possible issues:")
    print("  - Spatial connectivity patterns")
    print("  - Direction Pointer navigation")
    print("  - Codel Chooser behavior")
    print("  - Block boundary detection")
    print("  - Edge/termination conditions")

if __name__ == "__main__":
    
    print("🚀 CREATING ANYTHING WORKING - STEP BY STEP")
    print("=" * 60)
    
    # Try three different approaches
    programs = [
        create_ultra_simple_H(),
        create_even_simpler(), 
        create_tiny_number()
    ]
    
    success_count = 0
    
    for program in programs:
        if test_program(program):
            success_count += 1
    
    print(f"\n📊 RESULTS: {success_count}/{len(programs)} programs working")
    
    if success_count > 0:
        print("🎉 BREAKTHROUGH! We can create working programs!")
        print("🚀 Ready to scale up to more complex programs!")
    else:
        print("🔧 All programs failed - need deeper analysis")
        analyze_differences()
        
        print("\n💡 NEXT STEPS:")
        print("1. Study working program pixel-by-pixel")
        print("2. Replicate exact spatial patterns")
        print("3. Understand Direction Pointer flow")
        print("4. Test incremental modifications")

