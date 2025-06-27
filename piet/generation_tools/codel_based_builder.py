#!/usr/bin/env python3
"""
🎯 CODEL-BASED PIET BUILDER 🎯

Build Piet programs the RIGHT way - thinking in CODEL units, not pixels!

Key insight: Programs are logical grids of codels that get scaled to pixel blocks.
- hi.png: 10x10 logical codels, each codel = 16x16 pixels
- frankzago_hello.png: 30x29 logical codels, each codel = 1x1 pixel

Strategy: Build the logical codel layout, then scale to desired pixel size.
"""

from PIL import Image
import subprocess

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

class CodelBuilder:
    def __init__(self, logical_width=20, logical_height=10, codel_size=4):
        """
        Build Piet programs using logical codel units

        Args:
            logical_width: Width in codel units
            logical_height: Height in codel units
            codel_size: Pixels per codel (1 for fine detail, 4-16 for visible blocks)
        """
        self.logical_width = logical_width
        self.logical_height = logical_height
        self.codel_size = codel_size

        # Create logical grid (each cell is one codel)
        self.grid = [['white' for _ in range(logical_width)] for _ in range(logical_height)]

        self.cursor_x = 0
        self.cursor_y = 0

    def place_block(self, color, width, height=1):
        """Place a block of codels of the same color"""
        placed = []

        for dy in range(height):
            for dx in range(width):
                x = self.cursor_x + dx
                y = self.cursor_y + dy

                if 0 <= x < self.logical_width and 0 <= y < self.logical_height:
                    self.grid[y][x] = color
                    placed.append((x, y))

        self.cursor_x += width
        return placed

    def place_codel(self, color):
        """Place a single codel"""
        return self.place_block(color, 1, 1)

    def move_cursor(self, x, y):
        """Move cursor to specific position"""
        self.cursor_x = x
        self.cursor_y = y

    def next_line(self, indent=0):
        """Move to next line with optional indent"""
        self.cursor_x = indent
        self.cursor_y += 1

    def build_hello_world_pattern(self):
        """Build Hello World using the hi.png successful pattern"""

        # Based on hi.png structure but adapted for "Hello World!"
        # ASCII: H=72, e=101, l=108, l=108, o=111, space=32, W=87, o=111, r=114, l=108, d=100, !=33, newline=10

        print("🏗️ Building Hello World pattern...")

        # Line 0: H = 72 = 9 * 8
        self.move_cursor(0, 0)
        self.place_block('light_red', 9)     # Push 9 (9 codels)
        self.place_block('light_yellow', 8)  # Push 8 (8 codels)
        self.place_codel('red')              # Multiply operation (1 codel)
        self.place_codel('dark_red')         # Output character (1 codel)

        # Line 1: e = 101 = 72 + 29
        self.next_line()
        self.place_codel('light_cyan')       # Duplicate H from stack
        self.place_block('yellow', 29)       # Push 29 (will wrap, but that's OK)

        # Continue on next line for 29-block continuation and operations
        self.next_line(10)  # Indent to continue the 29-block
        self.place_block('yellow', 19)       # Continue 29-block (total 29)
        self.place_codel('green')            # Add operation
        self.place_codel('dark_red')         # Output e

        # Line 3: l = 108 = 101 + 7
        self.next_line()
        self.place_codel('light_cyan')       # Duplicate e
        self.place_block('cyan', 7)          # Push 7
        self.place_codel('green')            # Add
        self.place_codel('dark_red')         # Output l

        # Line 4: l (duplicate)
        self.next_line()
        self.place_codel('light_cyan')       # Duplicate l
        self.place_codel('dark_red')         # Output l

        # Line 5: o = 111 = 108 + 3
        self.next_line()
        self.place_codel('light_cyan')       # Duplicate l
        self.place_block('blue', 3)          # Push 3
        self.place_codel('green')            # Add
        self.place_codel('dark_red')         # Output o

        # Line 6: space = 32
        self.next_line()
        self.place_block('magenta', 32)      # Push 32 (large block)

        # Continue space block on next line
        self.next_line(10)
        self.place_block('magenta', 22)      # Continue 32-block (total 32)
        self.place_codel('dark_red')         # Output space

        # Line 8: W = 87
        self.next_line()
        self.place_block('dark_green', 87)   # Push 87 (very large block, will wrap)

        # Continue W block
        self.next_line(10)
        self.place_block('dark_green', 77)   # Continue (total 87)
        self.place_codel('dark_red')         # Output W

        print("✅ Built Hello World codel pattern")
        return self

    def render_to_image(self):
        """Convert logical codel grid to actual pixel image"""

        pixel_width = self.logical_width * self.codel_size
        pixel_height = self.logical_height * self.codel_size

        img = Image.new('RGB', (pixel_width, pixel_height), COLORS['white'])

        for logical_y in range(self.logical_height):
            for logical_x in range(self.logical_width):
                color_name = self.grid[logical_y][logical_x]
                color = COLORS[color_name]

                # Fill the entire codel block with this color
                for pixel_y in range(logical_y * self.codel_size, (logical_y + 1) * self.codel_size):
                    for pixel_x in range(logical_x * self.codel_size, (logical_x + 1) * self.codel_size):
                        if pixel_x < pixel_width and pixel_y < pixel_height:
                            img.putpixel((pixel_x, pixel_y), color)

        print(f"🖼️ Rendered to {pixel_width}x{pixel_height} image (codel_size={self.codel_size})")
        return img

    def print_ascii_grid(self):
        """Print ASCII representation of the logical grid"""

        print(f"\n📋 Logical grid ({self.logical_width}x{self.logical_height}):")

        color_chars = {
            'white': '.',
            'light_red': 'r', 'light_yellow': 'y', 'light_green': 'g', 'light_cyan': 'c',
            'light_blue': 'b', 'light_magenta': 'm',
            'red': 'R', 'yellow': 'Y', 'green': 'G', 'cyan': 'C', 'blue': 'B', 'magenta': 'M',
            'dark_red': '1', 'dark_yellow': '2', 'dark_green': '3', 'dark_cyan': '4',
            'dark_blue': '5', 'dark_magenta': '6',
            'black': '#'
        }

        for row in self.grid:
            line = ''.join(color_chars.get(cell, '?') for cell in row)
            print(f"  {line}")

        print("\n🔤 Legend: . = white, r/R = red variants, etc.")

def create_proper_hello_world():
    """Create proper Hello World using codel-based approach"""

    print("🎯 Creating PROPER Hello World with codel-based approach!")

    # Build the logical program
    builder = CodelBuilder(logical_width=20, logical_height=15, codel_size=8)
    builder.build_hello_world_pattern()

    # Show the logical structure
    builder.print_ascii_grid()

    # Render to image
    core_img = builder.render_to_image()

    # Add spectacular decorations using safe barriers
    barrier_thickness = 16
    canvas_width = ((core_img.width + barrier_thickness + 15) // 16) * 16
    canvas_height = ((core_img.height + barrier_thickness + 15) // 16) * 16

    spectacular = Image.new('RGB', (canvas_width, canvas_height), COLORS['white'])
    spectacular.paste(core_img, (0, 0))

    # Add barriers
    for x in range(core_img.width, min(canvas_width, core_img.width + barrier_thickness)):
        for y in range(canvas_height):
            spectacular.putpixel((x, y), COLORS['black'])

    for y in range(core_img.height, min(canvas_height, core_img.height + barrier_thickness)):
        for x in range(canvas_width):
            spectacular.putpixel((x, y), COLORS['black'])

    # Add decorations
    add_celebration(spectacular, core_img.width + barrier_thickness, core_img.height + barrier_thickness)

    # Save
    output_path = "codel_based_hello_world.png"
    spectacular.save(output_path)
    print(f"💾 Saved as: {output_path}")

    return spectacular, output_path, builder.codel_size

def add_celebration(img, start_x, start_y):
    """Add celebration decorations"""

    # Rainbow stripes
    colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
    for i, color in enumerate(colors):
        stripe_x = start_x + i * 12
        if stripe_x < img.width:
            for x in range(stripe_x, min(img.width, stripe_x + 10)):
                for y in range(min(img.height, start_y)):
                    img.putpixel((x, y), COLORS[color])

    print("🎉 Added celebration decorations")

def test_program(image_path, codel_size):
    """Test the program"""
    try:
        result = subprocess.run(['./piet', image_path, str(codel_size)],
                              capture_output=True, text=True, timeout=10,
                              cwd='../files')

        output = result.stdout.strip()
        print(f"🧪 Program output: '{output}'")

        if "Hello World!" in output:
            print("🎉 SUCCESS! Perfect 'Hello World!' output!")
            return True
        else:
            print(f"⚠️ Output: '{output}' (expected 'Hello World!')")
            if result.stderr:
                print(f"Debug info: {result.stderr[:200]}...")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    print("🚀 CODEL-BASED HELLO WORLD BUILDER! 🚀")
    print("Building programs the RIGHT way - thinking in codel units!\n")

    img, output_path, codel_size = create_proper_hello_world()

    print(f"\n🧪 Testing with codel size {codel_size}...")
    success = test_program(output_path, codel_size)

    if success:
        print("\n🏆 BREAKTHROUGH SUCCESS! 🏆")
        print("We understand Piet properly now!")
    else:
        print("\n🔧 Close! Understanding codel structure better...")
        print("Ready to iterate and perfect the approach!")