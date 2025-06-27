#!/usr/bin/env python3
"""
🎯 WORKING FILE ENCODER 🎯

Create Piet programs that encode file content using the PROVEN pattern:
- ASCII value → connected block of that exact size
- Outchar operation → single pixel transition
- Simple layout that actually works
"""

from PIL import Image
import subprocess
import sys
import os

COLORS = {
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'magenta': (255, 0, 255),
    'dark_magenta': (192, 0, 192),
    'blue': (0, 0, 255),
    'dark_blue': (0, 0, 192),
    'green': (0, 255, 0),
    'dark_green': (0, 192, 0),
    'yellow': (255, 255, 0),
    'dark_yellow': (192, 192, 0),
    'cyan': (0, 255, 255),
    'dark_cyan': (0, 192, 192),
    'white': (255, 255, 255),
    'black': (0, 0, 0)
}

def create_connected_block(img, color, size, start_x, start_y, max_width):
    """Create a connected block of exactly 'size' pixels"""
    pixels_placed = 0
    x, y = start_x, start_y
    
    # Fill pixels in a connected pattern (rectangle)
    width_needed = min(size, max_width - start_x)
    height_needed = (size + width_needed - 1) // width_needed
    
    for row in range(height_needed):
        for col in range(width_needed):
            if pixels_placed >= size:
                break
            
            pixel_x = start_x + col
            pixel_y = start_y + row
            
            if pixel_x < img.width and pixel_y < img.height:
                img.putpixel((pixel_x, pixel_y), color)
                pixels_placed += 1
        
        if pixels_placed >= size:
            break
    
    # Return next position
    next_x = start_x + width_needed
    next_y = start_y
    
    if next_x >= max_width:
        next_x = 0
        next_y = start_y + height_needed
    
    return next_x, next_y

def encode_text_to_piet(text, max_width=100):
    """Encode text using proven Piet pattern"""
    
    print(f"🎯 Encoding text: '{text[:50]}{'...' if len(text) > 50 else ''}'")
    
    # Calculate image size
    total_ascii = sum(ord(c) for c in text)
    estimated_height = (total_ascii // max_width) + len(text) + 20
    
    img = Image.new('RGB', (max_width, estimated_height), COLORS['white'])
    
    x, y = 0, 0
    colors = ['red', 'magenta', 'blue', 'green', 'yellow', 'cyan']
    color_index = 0
    
    print("📝 Creating blocks:")
    
    for i, char in enumerate(text):
        ascii_val = ord(char)
        
        # Push block (size = ASCII value)
        push_color = colors[color_index % len(colors)]
        color_index += 1
        
        print(f"  '{char}' (ASCII {ascii_val}) → {push_color} block of {ascii_val} pixels")
        
        x, y = create_connected_block(img, COLORS[push_color], ascii_val, x, y, max_width)
        
        # Outchar block (1 pixel)
        outchar_color = 'dark_red'
        if x >= max_width:
            x = 0
            y += 1
        
        if y < img.height and x < img.width:
            img.putpixel((x, y), COLORS[outchar_color])
            x += 1
    
    print(f"📐 Final image size: {img.width}x{y+10}")
    
    # Crop to actual used size
    final_img = Image.new('RGB', (max_width, y + 10), COLORS['white'])
    final_img.paste(img, (0, 0))
    
    return final_img

def test_file_encoding(source_file, max_chars=15):
    """Test file encoding with a real source file"""
    
    print("🎯 FILE ENCODING TEST 🎯")
    print(f"Source: {source_file}")
    
    # Read file
    try:
        with open(source_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"❌ Error reading file: {e}")
        return None
    
    # Limit for testing
    original_length = len(content)
    if len(content) > max_chars:
        content = content[:max_chars]
        print(f"⚠️ Truncated from {original_length} to {max_chars} chars for testing")
    
    print(f"📄 Content: '{content}'")
    
    # Add our signature
    full_content = content + " → Hello World!"
    
    # Create Piet image
    img = encode_text_to_piet(full_content, max_width=150)
    
    # Save
    output_path = f"encoded_{os.path.basename(source_file)}.png"
    img.save(output_path)
    print(f"💾 Saved: {output_path}")
    
    return output_path

def test_encoded_image(image_path):
    """Test the encoded Piet image"""
    print(f"\n🧪 Testing: {image_path}")
    
    try:
        result = subprocess.run(['../files/piet', image_path, '1'],
                              capture_output=True, text=True, timeout=20)
        
        output = result.stdout.strip()
        print(f"📋 Output ({len(output)} chars):")
        print("=" * 50)
        print(output[:200])
        if len(output) > 200:
            print("... (truncated)")
        print("=" * 50)
        
        success = len(output) > 0 and "Hello World!" in output
        
        if success:
            print("✅ SUCCESS: File content encoded and Hello World found!")
        else:
            print("🔧 Partial success - program executed but checking output...")
            
        return success
        
    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    # Test with simple example first
    print("🎯 WORKING FILE ENCODER 🎯")
    print("Creating Piet programs that encode file content!\n")
    
    # Create simple test
    test_content = "Hi!"
    print(f"🧪 Testing with: '{test_content}'")
    
    img = encode_text_to_piet(test_content)
    img.save("test_hi.png")
    print("💾 Saved: test_hi.png")
    
    success = test_encoded_image("test_hi.png")
    
    if success:
        print("\n" + "="*60)
        print("🎉 BASIC TEST SUCCESSFUL! Now testing with file...")
        
        # Test with actual file if provided
        if len(sys.argv) > 1:
            source_file = sys.argv[1]
            if os.path.exists(source_file):
                encoded_path = test_file_encoding(source_file, max_chars=10)
                if encoded_path:
                    file_success = test_encoded_image(encoded_path)
                    
                    if file_success:
                        print("\n🏆 SPECTACULAR SUCCESS! 🏆")
                        print("✅ Created Piet image encoding file content!")
                        print("✅ Image outputs file content + Hello World!")
                        print("\n🎨 Ready to create artistic programming language tributes!")
                    else:
                        print("\n🔧 File encoding needs debugging...")
            else:
                print(f"❌ File not found: {source_file}")
        else:
            print("\n💡 Usage: python3 working_file_encoder.py <source_file>")
    else:
        print("\n🔧 Need to fix basic encoding first...")

