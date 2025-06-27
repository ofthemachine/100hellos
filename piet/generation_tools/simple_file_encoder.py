#!/usr/bin/env python3
"""
🎯 SIMPLE FILE ENCODER FOR PIET 🎯

Based on the working frankzago_hello.png pattern:
- Direct ASCII mapping: block size = ASCII value
- Simple linear flow with reliable color transitions
- Proven to work from our analysis
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

class SimplePietEncoder:
    def __init__(self):
        self.blocks = []  # List of (color, size, operation) tuples
        
    def add_character(self, ascii_val):
        """Add character using the frankzago_hello.png pattern"""
        # Push ASCII value (direct block size mapping)
        push_color = self.get_push_color()
        self.blocks.append((push_color, ascii_val, 'push'))
        
        # Output character (transition to dark_red for outchar)
        self.blocks.append(('dark_red', 1, 'outchar'))
    
    def get_push_color(self):
        """Cycle through colors for push operations"""
        colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
        return colors[len(self.blocks) % len(colors)]
    
    def encode_text(self, text):
        """Encode text into Piet blocks"""
        for char in text:
            self.add_character(ord(char))
    
    def render_to_image(self, max_width=500):
        """Render blocks to Piet image using linear layout"""
        
        # Calculate image dimensions
        total_pixels = sum(block[1] for block in self.blocks)
        height = max(50, (total_pixels // max_width) + 20)
        
        img = Image.new('RGB', (max_width, height), COLORS['white'])
        
        x, y = 0, 0
        
        for color_name, size, operation in self.blocks:
            color = COLORS[color_name]
            
            # Fill pixels for this block
            pixels_placed = 0
            start_x = x
            
            # Create connected block horizontally, wrapping as needed
            while pixels_placed < size:
                if x >= max_width:
                    x = 0
                    y += 1
                    if y >= height:
                        # Extend image height if needed
                        new_img = Image.new('RGB', (max_width, height + 20), COLORS['white'])
                        new_img.paste(img, (0, 0))
                        img = new_img
                        height += 20
                
                img.putpixel((x, y), color)
                pixels_placed += 1
                x += 1
            
            print(f"  Block: {color_name} ({size} pixels) for {operation}")
        
        return img

def create_simple_file_encoding(source_file):
    """Create simple file encoding demo"""
    
    print("🎯 SIMPLE FILE ENCODING DEMO 🎯")
    print(f"Encoding: {source_file}")
    
    # Read file content
    try:
        with open(source_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"❌ Error reading file: {e}")
        return None
    
    # Limit content size for testing
    if len(content) > 50:
        content = content[:50] + "..."
        print(f"⚠️ Truncated to 50 chars for testing")
    
    print(f"📄 Content to encode: '{content}'")
    print(f"📏 Length: {len(content)} characters")
    
    # Create encoder
    encoder = SimplePietEncoder()
    
    # Encode file content
    encoder.encode_text(content)
    
    # Add separator
    encoder.encode_text("\n--- Hello World! ---\n")
    
    # Render to image
    print("🖼️ Rendering to image...")
    img = encoder.render_to_image()
    
    # Save
    output_path = f"simple_encoded_{os.path.basename(source_file)}.png"
    img.save(output_path)
    print(f"💾 Saved as: {output_path}")
    
    return output_path

def test_simple_program(image_path):
    """Test the program with debug output"""
    print(f"\n🧪 Testing: {image_path}")
    
    try:
        # Test with debug to see execution
        result = subprocess.run(['../files/piet', image_path, '1', '--debug'],
                              capture_output=True, text=True, timeout=15)
        
        output = result.stdout
        
        print("📋 Debug output:")
        print(output[:300])  # First 300 chars of debug
        if len(output) > 300:
            print("... (truncated)")
        
        # Look for actual program output in debug trace
        lines = output.split('\n')
        actual_output = ""
        for line in lines:
            if line.startswith("Output char:"):
                char_part = line.split("Output char: ")[1]
                if "(" in char_part:
                    char = char_part.split(" (")[0]
                    actual_output += char
        
        print(f"\n�� Extracted output: '{actual_output}'")
        
        return len(actual_output) > 0
        
    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 simple_file_encoder.py <source_file>")
        sys.exit(1)
    
    source_file = sys.argv[1]
    
    if not os.path.exists(source_file):
        print(f"❌ File not found: {source_file}")
        sys.exit(1)
    
    # Create the encoded program
    output_path = create_simple_file_encoding(source_file)
    
    if output_path:
        # Test it
        success = test_simple_program(output_path)
        
        if success:
            print("\n🎉 SUCCESS: Program executed and produced output!")
        else:
            print("\n🔧 Need to debug execution flow...")

