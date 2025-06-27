#!/usr/bin/env python3
"""
�� PATTERN-BASED FILE ENCODER 🎯

Replicates the EXACT working pattern from frankzago_hello.png:
- Each ASCII value becomes a block of that exact size
- Color transitions create push -> outchar sequences
- Simple linear layout that's proven to work
"""

from PIL import Image
import subprocess
import sys
import os

# Standard Piet colors
COLORS = {
    'light_red': (255, 192, 192),    'light_yellow': (255, 255, 192),
    'light_green': (192, 255, 192),  'light_cyan': (192, 255, 255),
    'light_blue': (192, 192, 255),   'light_magenta': (255, 192, 255),
    'red': (255, 0, 0),              'yellow': (255, 255, 0),
    'green': (0, 255, 0),            'cyan': (0, 255, 255),
    'blue': (0, 0, 255),             'magenta': (255, 0, 255),
    'dark_red': (192, 0, 0),         'dark_yellow': (192, 192, 0),
    'dark_green': (0, 192, 0),       'dark_cyan': (0, 192, 192),
    'dark_blue': (0, 0, 192),        'dark_magenta': (192, 0, 192),
    'white': (255, 255, 255),        'black': (0, 0, 0)
}

def create_frankzago_pattern(text, max_width=100):
    """Create image following frankzago_hello.png exact pattern"""
    
    print(f"🎯 Creating Piet program for: '{text}'")
    
    # Calculate total pixels needed
    total_pixels = sum(ord(c) for c in text) + len(text)  # ASCII values + outchar pixels
    height = max(30, (total_pixels // max_width) + 10)
    
    print(f"📐 Image size: {max_width}x{height}")
    
    # Create white background
    img = Image.new('RGB', (max_width, height), COLORS['white'])
    
    x, y = 0, 0
    
    # Pattern: red->dark_red for each character (push ASCII, then outchar)
    for i, char in enumerate(text):
        ascii_val = ord(char)
        print(f"  Character '{char}' (ASCII {ascii_val})")
        
        # Push block (size = ASCII value)
        push_color = COLORS['red']
        pixels_needed = ascii_val
        
        # Fill push block
        for _ in range(pixels_needed):
            if x >= max_width:
                x = 0
                y += 1
                if y >= height:
                    # Extend image if needed
                    new_img = Image.new('RGB', (max_width, height + 10), COLORS['white'])
                    new_img.paste(img, (0, 0))
                    img = new_img
                    height += 10
            
            img.putpixel((x, y), push_color)
            x += 1
        
        # Output block (1 pixel, creates outchar transition)
        outchar_color = COLORS['dark_red']
        if x >= max_width:
            x = 0
            y += 1
            if y >= height:
                new_img = Image.new('RGB', (max_width, height + 10), COLORS['white'])
                new_img.paste(img, (0, 0))
                img = new_img
                height += 10
        
        img.putpixel((x, y), outchar_color)
        x += 1
    
    return img

def test_minimal_example():
    """Test with minimal example first"""
    print("🧪 Testing minimal example: 'Hi'")
    
    img = create_frankzago_pattern("Hi", max_width=200)
    output_path = "minimal_hi.png"
    img.save(output_path)
    print(f"💾 Saved: {output_path}")
    
    # Test it
    try:
        result = subprocess.run(['../files/piet', output_path, '1'],
                              capture_output=True, text=True, timeout=10)
        
        output = result.stdout.strip()
        print(f"📝 Output: '{output}'")
        
        if output == "Hi":
            print("✅ SUCCESS! Minimal example works!")
            return True
        else:
            print(f"❌ Expected 'Hi', got '{output}'")
            return False
            
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

def encode_actual_file(source_file, max_chars=30):
    """Encode actual file content"""
    
    try:
        with open(source_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"❌ Error reading file: {e}")
        return None
    
    # Limit for testing
    if len(content) > max_chars:
        content = content[:max_chars]
        print(f"⚠️ Truncated to {max_chars} chars for testing")
    
    print(f"📄 Encoding content: '{content}'")
    
    # Add separator and Hello World
    full_content = content + "\n--- Hello World! ---\n"
    
    # Create image
    img = create_frankzago_pattern(full_content, max_width=300)
    
    # Save
    output_path = f"pattern_encoded_{os.path.basename(source_file)}.png"
    img.save(output_path)
    print(f"💾 Saved: {output_path}")
    
    return output_path

if __name__ == "__main__":
    print("🎯 PATTERN-BASED FILE ENCODER 🎯")
    print("Replicating frankzago_hello.png success pattern\n")
    
    # Test minimal example first
    if test_minimal_example():
        print("\n" + "="*50)
        
        # Test with file if provided
        if len(sys.argv) > 1:
            source_file = sys.argv[1]
            if os.path.exists(source_file):
                output_path = encode_actual_file(source_file, max_chars=20)
                
                if output_path:
                    print(f"\n🧪 Testing file encoding: {output_path}")
                    try:
                        result = subprocess.run(['../files/piet', output_path, '1'],
                                              capture_output=True, text=True, timeout=20)
                        
                        output = result.stdout
                        print(f"📝 File encoding output:")
                        print("=" * 30)
                        print(output[:200])
                        if len(output) > 200:
                            print("... (truncated)")
                        print("=" * 30)
                        
                        if "Hello World!" in output:
                            print("🎉 SUCCESS: File content + Hello World!")
                        else:
                            print("🔧 File content encoded, debugging Hello World part...")
                            
                    except Exception as e:
                        print(f"❌ File encoding test failed: {e}")
            else:
                print(f"❌ File not found: {source_file}")
        else:
            print("💡 Usage: python3 pattern_based_encoder.py <source_file>")
    else:
        print("🔧 Need to fix minimal example first")

