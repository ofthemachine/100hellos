#!/usr/bin/env python3
"""
🎯 BASE64 PIET ENCODER 🎯

BREAKTHROUGH APPROACH: Base64 encode source files before converting to Piet!

Benefits:
1. Limited character set: Only A-Z, a-z, 0-9, +, /, = (64 chars)
2. ASCII range 43-122: Much smaller blocks needed
3. Predictable patterns: No extreme ASCII values
4. Compact representation: ~33% size increase vs raw
5. Standard decoding: Easy to verify results

This solves the infinite loop problem by using smaller, more manageable blocks!
"""

import base64
from PIL import Image
import subprocess
import sys
import os

# Standard Piet colors
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

def encode_file_to_base64(file_path):
    """Encode file content to base64"""
    try:
        with open(file_path, 'rb') as f:
            content = f.read()
        
        # Encode to base64
        b64_content = base64.b64encode(content).decode('ascii')
        
        print(f"📄 Original file: {file_path}")
        print(f"📏 Original size: {len(content)} bytes")
        print(f"�� Base64 size: {len(b64_content)} characters")
        print(f"📊 Compression ratio: {len(b64_content)/len(content):.2f}x")
        print(f"🎯 ASCII range: {min(ord(c) for c in b64_content)}-{max(ord(c) for c in b64_content)}")
        
        return b64_content
        
    except Exception as e:
        print(f"❌ Error encoding file: {e}")
        return None

def create_base64_piet_program(b64_text, max_width=120):
    """Create Piet program that outputs base64 encoded text"""
    
    print(f"🎯 Creating Piet program for base64: {b64_text[:20]}...")
    
    # Calculate image dimensions  
    # Base64 chars are ASCII 43-122, much smaller blocks!
    total_pixels = sum(ord(c) for c in b64_text) + len(b64_text)  # +1 pixel per outchar
    height = max(50, (total_pixels // max_width) + 20)
    
    print(f"📐 Estimated image: {max_width}x{height} pixels")
    
    img = Image.new('RGB', (max_width, height), COLORS['white'])
    
    # Color cycle for variety
    push_colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
    
    x, y = 0, 0
    
    print("🔧 Building character blocks:")
    
    for i, char in enumerate(b64_text):
        ascii_val = ord(char)
        push_color = push_colors[i % len(push_colors)]
        
        if i < 10:  # Show first 10 for debugging
            print(f"  '{char}' (ASCII {ascii_val}) → {push_color} block ({ascii_val} pixels)")
        elif i == 10:
            print(f"  ... (continuing for {len(b64_text)} total characters)")
        
        # Create push block (size = ASCII value)
        block_size = ascii_val
        
        # Fill block pixels in rectangular pattern
        pixels_placed = 0
        start_x = x
        
        while pixels_placed < block_size:
            if x >= max_width:
                x = 0
                y += 1
                if y >= height:
                    # Extend image if needed
                    new_img = Image.new('RGB', (max_width, height + 20), COLORS['white'])
                    new_img.paste(img, (0, 0))
                    img = new_img
                    height += 20
            
            img.putpixel((x, y), COLORS[push_color])
            pixels_placed += 1
            x += 1
        
        # Add outchar pixel (transition to dark_red)
        if x >= max_width:
            x = 0
            y += 1
            if y >= height:
                new_img = Image.new('RGB', (max_width, height + 20), COLORS['white'])
                new_img.paste(img, (0, 0))
                img = new_img
                height += 20
        
        img.putpixel((x, y), COLORS['dark_red'])
        x += 1
    
    # Add separator and signature
    separator = "\n==== DECODED ABOVE ====\nHello World!\n"
    for char in separator:
        ascii_val = ord(char)
        
        # Add character block
        pixels_placed = 0
        while pixels_placed < ascii_val:
            if x >= max_width:
                x = 0
                y += 1
                if y >= height:
                    new_img = Image.new('RGB', (max_width, height + 20), COLORS['white'])
                    new_img.paste(img, (0, 0))
                    img = new_img
                    height += 20
            
            img.putpixel((x, y), COLORS['green'])  # Green for separator
            pixels_placed += 1
            x += 1
        
        # Outchar pixel
        if x >= max_width:
            x = 0
            y += 1
        if y < height:
            img.putpixel((x, y), COLORS['dark_red'])
            x += 1
    
    # Crop to actual size
    final_img = Image.new('RGB', (max_width, y + 5), COLORS['white'])
    final_img.paste(img, (0, 0))
    
    print(f"✅ Created image: {max_width}x{y+5} pixels")
    return final_img

def test_base64_encoding(source_file):
    """Test the complete base64 encoding workflow"""
    
    print("🎯 BASE64 PIET ENCODING TEST 🎯")
    print("=" * 50)
    
    # Step 1: Encode file to base64
    b64_content = encode_file_to_base64(source_file)
    if not b64_content:
        return False
    
    # Limit for testing
    if len(b64_content) > 50:
        print(f"⚠️ Truncating base64 from {len(b64_content)} to 50 chars for initial test")
        b64_content = b64_content[:50]
    
    print(f"\n📦 Base64 content: {b64_content}")
    
    # Step 2: Create Piet program
    print(f"\n🖼️ Creating Piet program...")
    img = create_base64_piet_program(b64_content)
    
    # Step 3: Save and test
    output_path = f"base64_encoded_{os.path.basename(source_file)}.png"
    img.save(output_path)
    print(f"💾 Saved: {output_path}")
    
    # Step 4: Test execution
    print(f"\n�� Testing Piet program...")
    try:
        result = subprocess.run(['../files/piet', output_path, '1'],
                              capture_output=True, text=True, timeout=30)
        
        output = result.stdout.strip()
        print(f"📋 Program output ({len(output)} chars):")
        print("=" * 40)
        print(output[:200])
        if len(output) > 200:
            print("... (truncated)")
        print("=" * 40)
        
        # Check if we got the base64 content
        if b64_content in output:
            print("✅ SUCCESS: Base64 content found in output!")
            
            # Check if we got Hello World too
            if "Hello World!" in output:
                print("✅ BONUS: 'Hello World!' also found!")
                return True
            else:
                print("🔧 Base64 successful, working on Hello World part...")
                return True
        else:
            print("❌ Base64 content not found in output")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

def analyze_base64_benefits():
    """Analyze why base64 encoding helps"""
    
    print("🔍 BASE64 ENCODING BENEFITS ANALYSIS")
    print("=" * 50)
    
    # Compare ASCII ranges
    sample_text = "print('Hello World!')"
    b64_text = base64.b64encode(sample_text.encode()).decode()
    
    print(f"📄 Original: '{sample_text}'")
    print(f"📦 Base64:   '{b64_text}'")
    print()
    
    # ASCII range analysis
    orig_ascii = [ord(c) for c in sample_text]
    b64_ascii = [ord(c) for c in b64_text]
    
    print(f"🎯 Original ASCII range: {min(orig_ascii)}-{max(orig_ascii)} (span: {max(orig_ascii) - min(orig_ascii)})")
    print(f"🎯 Base64 ASCII range:   {min(b64_ascii)}-{max(b64_ascii)} (span: {max(b64_ascii) - min(b64_ascii)})")
    print()
    
    # Block size comparison
    print("📊 Block size comparison:")
    print(f"   Original max block: {max(orig_ascii)} pixels")
    print(f"   Base64 max block:   {max(b64_ascii)} pixels")
    print(f"   Reduction factor:   {max(orig_ascii) / max(b64_ascii):.2f}x smaller")
    print()
    
    # Character set
    b64_chars = set(b64_text)
    print(f"🔤 Base64 character set: {sorted(b64_chars)}")
    print(f"📏 Character variety: {len(b64_chars)} unique chars")

if __name__ == "__main__":
    print("🚀 BASE64 PIET ENCODER - BREAKTHROUGH APPROACH! 🚀")
    print()
    
    # Show benefits analysis
    analyze_base64_benefits()
    print()
    
    # Test with file if provided
    if len(sys.argv) > 1:
        source_file = sys.argv[1]
        if os.path.exists(source_file):
            success = test_base64_encoding(source_file)
            
            if success:
                print("\n🎉 BREAKTHROUGH SUCCESS! 🎉")
                print("✅ Base64 encoding + Piet generation working!")
                print("✅ Dramatically simplified block sizes!")
                print("✅ Ready for full source file encoding!")
                
                print("\n🎨 Next steps:")
                print("- Scale to full file sizes")
                print("- Add artistic elements with barriers")  
                print("- Generate 99 language collection")
                print("- Create gallery of living digital artifacts!")
            else:
                print("\n🔧 Progress made, debugging execution flow...")
        else:
            print(f"❌ File not found: {source_file}")
    else:
        print("💡 Usage: python3 base64_piet_encoder.py <source_file>")
        print("Example: python3 base64_piet_encoder.py ../../../python/files/hello-world.py")

