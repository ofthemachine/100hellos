#!/usr/bin/env python3
"""
🎯 FILE ENCODING PIET BUILDER 🎯

Create Piet programs that:
1. Output file content followed by "Hello World!"
2. Encode the actual source code from other programming languages
3. Create spectacular artistic tributes to each language

This makes each Piet image a complete digital artifact containing:
- Visual representation of the programming language
- The actual Hello World source code
- Functional Piet program execution
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

class FileEncodingPietBuilder:
    def __init__(self, width=200, height=100):
        self.width = width
        self.height = height
        self.img = Image.new('RGB', (width, height), COLORS['white'])
        self.current_x = 0
        self.current_y = 0
        self.color_cycle = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
        self.color_index = 0

    def get_next_color(self):
        """Get next color for block creation"""
        color = self.color_cycle[self.color_index]
        self.color_index = (self.color_index + 1) % len(self.color_cycle)
        return color

    def add_char_block(self, ascii_val):
        """Add a block that pushes ASCII value and outputs it"""
        color = self.get_next_color()
        
        # For large ASCII values, we need arithmetic construction
        if ascii_val > 100:
            # Break down large values: 101 = 10*10 + 1
            factor1 = 10
            factor2 = ascii_val // 10
            remainder = ascii_val % 10
            
            # Create blocks for factors
            self.add_value_block(factor1, color)
            self.add_value_block(factor2, self.get_next_color())
            self.add_operation_pixel('multiply')
            
            if remainder > 0:
                self.add_value_block(remainder, self.get_next_color())
                self.add_operation_pixel('add')
                
        else:
            # Direct mapping for smaller values
            self.add_value_block(ascii_val, color)
        
        # Output the character
        self.add_operation_pixel('outchar')

    def add_value_block(self, value, color):
        """Add a block of specific size (value)"""
        if value <= 0:
            return
            
        # Create connected block of 'value' pixels
        pixels_added = 0
        start_x, start_y = self.current_x, self.current_y
        
        # Fill in a rectangular pattern
        while pixels_added < value and self.current_y < self.height:
            if self.current_x >= self.width:
                self.current_x = 0
                self.current_y += 1
                if self.current_y >= self.height:
                    break
                    
            self.img.putpixel((self.current_x, self.current_y), COLORS[color])
            pixels_added += 1
            self.current_x += 1
            
            # Keep blocks connected horizontally when possible
            if pixels_added >= value:
                break

    def add_operation_pixel(self, operation):
        """Add single pixel for operation"""
        if operation == 'multiply':
            color = 'light_green'  # Hue change 1, Lightness change 2
        elif operation == 'add':
            color = 'yellow'       # Hue change 1, Lightness change 0  
        elif operation == 'outchar':
            color = 'dark_red'     # Hue change 5, Lightness change 2
        else:
            color = 'white'
            
        if self.current_x >= self.width:
            self.current_x = 0
            self.current_y += 1
            
        if self.current_y < self.height:
            self.img.putpixel((self.current_x, self.current_y), COLORS[color])
            self.current_x += 1

    def encode_file_content(self, file_path):
        """Encode entire file content into the Piet program"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except UnicodeDecodeError:
            # Handle binary files
            with open(file_path, 'rb') as f:
                content = f.read().decode('utf-8', errors='replace')
        
        print(f"📄 Encoding file: {file_path}")
        print(f"📏 Content length: {len(content)} characters")
        
        # Add file content
        for char in content:
            ascii_val = ord(char)
            print(f"   Adding '{char}' (ASCII {ascii_val})")
            self.add_char_block(ascii_val)
            
        # Add separator
        print("   Adding separator...")
        self.add_char_block(ord('\n'))
        self.add_char_block(ord('-'))
        for _ in range(10):
            self.add_char_block(ord('-'))
        self.add_char_block(ord('\n'))
        
        # Add "Hello World!"
        hello_world = "Hello World!\n"
        print("   Adding Hello World...")
        for char in hello_world:
            self.add_char_block(ord(char))

def create_file_encoding_demo(source_file):
    """Create demo Piet program that outputs file content + Hello World"""
    
    print("🎯 FILE ENCODING PIET DEMO 🎯")
    print(f"Encoding: {source_file}")
    
    # Determine image size based on file size
    try:
        file_size = os.path.getsize(source_file)
        # Rough estimate: need ~2-3 pixels per character for encoding
        estimated_pixels = file_size * 3 + 100  # Extra for "Hello World!" and operations
        
        # Calculate dimensions (roughly square)
        width = max(100, int((estimated_pixels * 1.5) ** 0.5))
        height = max(50, int(estimated_pixels / width) + 20)
        
        print(f"📐 Estimated image size: {width}x{height} pixels")
        
    except Exception as e:
        print(f"⚠️ Could not determine file size: {e}")
        width, height = 200, 100
    
    # Build the program
    builder = FileEncodingPietBuilder(width, height)
    builder.encode_file_content(source_file)
    
    # Save the image
    output_path = f"file_encoded_{os.path.basename(source_file)}.png"
    builder.img.save(output_path)
    print(f"💾 Saved as: {output_path}")
    
    return output_path

def test_encoded_program(image_path):
    """Test the encoded program"""
    print(f"\n🧪 Testing encoded program: {image_path}")
    
    try:
        result = subprocess.run(['../files/piet', image_path, '1'],
                              capture_output=True, text=True, timeout=30,
                              cwd='.')
        
        output = result.stdout
        print(f"📝 Program output ({len(output)} chars):")
        print("=" * 50)
        print(output[:500])  # First 500 chars
        if len(output) > 500:
            print(f"... (truncated, total {len(output)} characters)")
        print("=" * 50)
        
        if "Hello World!" in output:
            print("✅ SUCCESS: Contains 'Hello World!'")
            return True
        else:
            print("❌ No 'Hello World!' found in output")
            return False
            
    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 file_encoding_piet_builder.py <source_file>")
        sys.exit(1)
    
    source_file = sys.argv[1]
    
    if not os.path.exists(source_file):
        print(f"❌ File not found: {source_file}")
        sys.exit(1)
    
    # Create the encoded program
    output_path = create_file_encoding_demo(source_file)
    
    # Test it
    success = test_encoded_program(output_path)
    
    if success:
        print("\n🎉 SPECTACULAR SUCCESS! 🎉")
        print("Created Piet program that outputs file content + Hello World!")
    else:
        print("\n🔧 Work in progress - debugging needed!")

