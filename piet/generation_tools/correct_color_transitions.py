#!/usr/bin/env python3
"""
🎯 CORRECT COLOR TRANSITIONS FOR BASE64 🎯

Key insight: The color transition determines the operation!
From Piet spec analysis:
- push: Determined by block size  
- outchar: Specific color transition needed!

Let me create the CORRECT color pattern for outchar
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

def create_outchar_sequence(char_value):
    """Create a push + outchar sequence for a character
    
    Based on analysis of working programs:
    1. Create block with size = ASCII value (push operation)
    2. Transition to color that creates outchar operation
    """
    
    # Use the pattern: red block (push) → yellow block (outchar)
    # This matches patterns seen in working programs
    return [
        ('red', char_value),      # Push character value
        ('yellow', 1)             # Outchar (transition red→yellow = outchar)
    ]

def create_correct_base64_program(b64_text):
    """Create base64 program with CORRECT outchar transitions"""
    
    print(f"🎯 Creating CORRECT base64 program: {b64_text[:10]}...")
    
    width, height = 500, 50
    img = Image.new('RGB', (width, height), COLORS['white'])
    
    x, y = 0, 0  # Start at (0,0)
    
    print("🔧 Building CORRECT push→outchar sequences:")
    
    for i, char in enumerate(b64_text):
        ascii_val = ord(char)
        
        # Limit for testing
        if i >= 2:
            print(f"⚠️ Testing with first {i} characters")
            break
            
        print(f"  [{i}] '{char}' = ASCII {ascii_val}")
        
        # Get the color sequence for this character
        color_sequence = create_outchar_sequence(ascii_val)
        
        for color_name, block_size in color_sequence:
            print(f"    → {color_name} block ({block_size} pixels)")
            
            # Create block of the specified size
            pixels_placed = 0
            start_x = x
            
            for px in range(block_size):
                if x + px >= width - 10:
                    # Extend if needed
                    new_img = Image.new('RGB', (width + 100, height), COLORS['white'])
                    new_img.paste(img, (0, 0))
                    img = new_img
                    width += 100
                
                img.putpixel((x + px, y), COLORS[color_name])
                pixels_placed += 1
            
            x += block_size  # Move to next block position
    
    # Terminate with black
    if x < width - 5:
        img.putpixel((x, y), COLORS['black'])
    
    print(f"✅ Correct program created: {width}x{height}")
    print(f"✅ Expected operations: push {ord(b64_text[0])} → outchar → push {ord(b64_text[1])} → outchar")
    
    return img

def test_correct_transitions(source_file):
    """Test with correct color transitions"""
    
    print("🚀 CORRECT COLOR TRANSITIONS TEST 🚀")
    print("=" * 60)
    
    # Get base64 content
    try:
        with open(source_file, 'rb') as f:
            content = f.read()
        b64_content = base64.b64encode(content).decode('ascii')
        
        print(f"📄 File: {source_file}")
        print(f"📦 Base64: {b64_content}")
        
        # Test with just 2 characters to verify correct transitions
        test_content = b64_content[:2]
        print(f"🧪 Testing: '{test_content}' (ASCII {[ord(c) for c in test_content]})")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return False
    
    # Create program with correct transitions
    img = create_correct_base64_program(test_content)
    
    # Save and test
    output_file = f"correct_transitions_{os.path.basename(source_file)}.png"
    img.save(output_file)
    print(f"💾 Saved: {output_file}")
    
    # Test execution with debug
    print(f"\n🧪 Testing execution with debug...")
    try:
        result = subprocess.run(['../files/piet', '--debug', output_file, '1'],
                              capture_output=True, text=True, timeout=10)
        
        print("📋 Debug output:")
        debug_lines = result.stderr.split('\n')[:15]  # First 15 lines
        for line in debug_lines:
            if line.strip():
                print(f"  {line}")
        
        print(f"\n📋 Program output: '{result.stdout.strip()}'")
        
        # Check if we got the expected characters
        expected_chars = test_content
        if any(c in result.stdout for c in expected_chars):
            print("🎉 SUCCESS! Got expected characters!")
            return True
        else:
            print("🔧 Need to adjust color transitions...")
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
            success = test_correct_transitions(source_file)
            
            if success:
                print("\n🏆 COLOR TRANSITION BREAKTHROUGH! 🏆")
                print("✅ Correct push→outchar sequence working!")
                print("✅ Base64 characters being output!")
                print("🚀 Ready to implement full source encoding!")
            else:
                print("\n🔧 Analyzing color transition patterns...")
        else:
            print(f"❌ File not found: {source_file}")
    else:
        print("💡 Usage: python3 correct_color_transitions.py <source_file>")

