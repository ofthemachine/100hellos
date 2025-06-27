#!/usr/bin/env python3
"""
🎯 PROPER HELLO WORLD BUILDER 🎯

Build "Hello World!" by understanding the REAL Piet mechanics:
1. Connected pixels of same color = block size = value pushed to stack
2. Color transitions between blocks = operations (mult, add, outchar, etc.)
3. Execution follows direction pointer through color regions

No cheating with embedded images - build it properly from the ground up!
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

class PietBuilder:
    def __init__(self, width=50, height=20):
        self.width = width
        self.height = height
        self.img = Image.new('RGB', (width, height), COLORS['white'])
        self.current_x = 0
        self.current_y = 0

    def add_block(self, color, size, direction='horizontal'):
        """Add a connected block of pixels of given color and size"""
        pixels = []

        if direction == 'horizontal':
            for i in range(size):
                x = self.current_x + i
                y = self.current_y
                if x < self.width and y < self.height:
                    self.img.putpixel((x, y), COLORS[color])
                    pixels.append((x, y))
            self.current_x += size
        elif direction == 'vertical':
            for i in range(size):
                x = self.current_x
                y = self.current_y + i
                if x < self.width and y < self.height:
                    self.img.putpixel((x, y), COLORS[color])
                    pixels.append((x, y))
            self.current_y += size

        return pixels

    def add_operation_pixel(self, color):
        """Add a single pixel for an operation"""
        if self.current_x < self.width and self.current_y < self.height:
            self.img.putpixel((self.current_x, self.current_y), COLORS[color])
            self.current_x += 1
            return (self.current_x - 1, self.current_y)
        return None

    def next_line(self):
        """Move to next line"""
        self.current_x = 0
        self.current_y += 2  # Leave space between lines

    def build_hello_world(self):
        """Build 'Hello World!' using proper Piet mechanics"""

        # Reset position
        self.current_x = 0
        self.current_y = 0

        # ASCII values needed:
        # H=72, e=101, l=108, o=111, space=32, W=87, o=111, r=114, l=108, d=100, !=33

        # H = 72 = 9 * 8 (like in hi.png)
        self.add_block('light_red', 9)      # Push 9
        self.add_block('light_yellow', 8)   # Push 8
        self.add_operation_pixel('red')     # Multiply (9*8=72)
        self.add_operation_pixel('dark_red') # Output H

        self.next_line()

        # e = 101 = 72 + 29 = 72 + (29)
        # We need to duplicate H (72) and add 29
        self.add_operation_pixel('light_cyan')  # Duplicate (assumes 72 still on stack from previous)
        self.add_block('yellow', 29)           # Push 29 (large block, will wrap)
        self.add_operation_pixel('green')      # Add (72+29=101)
        self.add_operation_pixel('dark_red')   # Output e

        self.next_line()

        # l = 108 = 101 + 7
        self.add_operation_pixel('light_cyan')  # Duplicate e (101)
        self.add_block('cyan', 7)              # Push 7
        self.add_operation_pixel('green')      # Add (101+7=108)
        self.add_operation_pixel('dark_red')   # Output l

        self.next_line()

        # l = 108 (duplicate previous)
        self.add_operation_pixel('light_cyan')  # Duplicate l (108)
        self.add_operation_pixel('dark_red')   # Output l

        self.next_line()

        # o = 111 = 108 + 3
        self.add_operation_pixel('light_cyan')  # Duplicate l (108)
        self.add_block('blue', 3)              # Push 3
        self.add_operation_pixel('green')      # Add (108+3=111)
        self.add_operation_pixel('dark_red')   # Output o

        self.next_line()

        # space = 32
        self.add_block('magenta', 32)          # Push 32 (will wrap to multiple lines)
        self.add_operation_pixel('dark_red')   # Output space

        self.next_line()

        # W = 87
        self.add_block('dark_green', 87)       # Push 87 directly
        self.add_operation_pixel('dark_red')   # Output W

        self.next_line()

        # o = 111 (reuse calculation or direct)
        self.add_block('dark_blue', 111)       # Push 111 directly
        self.add_operation_pixel('dark_red')   # Output o

        self.next_line()

        # r = 114 = 111 + 3
        self.add_operation_pixel('light_cyan')  # Duplicate o (111)
        self.add_block('light_magenta', 3)     # Push 3
        self.add_operation_pixel('green')      # Add (111+3=114)
        self.add_operation_pixel('dark_red')   # Output r

        self.next_line()

        # l = 108 (direct)
        self.add_block('dark_yellow', 108)     # Push 108 directly
        self.add_operation_pixel('dark_red')   # Output l

        self.next_line()

        # d = 100
        self.add_block('dark_cyan', 100)       # Push 100 directly
        self.add_operation_pixel('dark_red')   # Output d

        self.next_line()

        # ! = 33
        self.add_block('dark_magenta', 33)     # Push 33 directly
        self.add_operation_pixel('dark_red')   # Output !

        self.next_line()

        # newline = 10
        self.add_block('light_green', 10)      # Push 10
        self.add_operation_pixel('dark_red')   # Output newline

        # Program termination (no more valid transitions)
        self.add_operation_pixel('black')      # End program

        return self.img

def create_spectacular_hello_world():
    """Create proper Hello World with spectacular decorations"""

    print("🎯 Building proper 'Hello World!' from scratch...")

    # Build the core program
    builder = PietBuilder(width=80, height=40)  # Give enough space
    core_program = builder.build_hello_world()

    print(f"✅ Built core program: {core_program.width}x{core_program.height}")

    # Now add spectacular decorations using safe methodology
    barrier_thickness = 8
    canvas_width = ((core_program.width + barrier_thickness + 15) // 16) * 16
    canvas_height = ((core_program.height + barrier_thickness + 15) // 16) * 16

    # Create spectacular canvas
    spectacular = Image.new('RGB', (canvas_width, canvas_height), COLORS['white'])

    # Place core program at (0,0)
    spectacular.paste(core_program, (0, 0))

    # Add protective black barriers
    for x in range(core_program.width, min(canvas_width, core_program.width + barrier_thickness)):
        for y in range(canvas_height):
            spectacular.putpixel((x, y), COLORS['black'])

    for y in range(core_program.height, min(canvas_height, core_program.height + barrier_thickness)):
        for x in range(canvas_width):
            spectacular.putpixel((x, y), COLORS['black'])

    print("🖤 Added protective barriers")

    # Add spectacular decorations in safe areas
    decoration_start_x = core_program.width + barrier_thickness
    decoration_start_y = core_program.height + barrier_thickness

    add_spectacular_decorations(spectacular, decoration_start_x, decoration_start_y)

    # Save the result
    output_path = "proper_hello_world_spectacular.png"
    spectacular.save(output_path)
    print(f"💾 Saved as: {output_path}")

    return spectacular, output_path

def add_spectacular_decorations(img, start_x, start_y):
    """Add amazing decorations in safe areas"""

    # Rainbow celebration in right area
    if start_x < img.width:
        rainbow_colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
        for i, color_name in enumerate(rainbow_colors):
            stripe_x = start_x + i * 8
            if stripe_x < img.width:
                for x in range(stripe_x, min(img.width, stripe_x + 6)):
                    for y in range(min(img.height, start_y)):
                        img.putpixel((x, y), COLORS[color_name])

    # Fireworks in bottom area
    if start_y < img.height:
        import math
        # Create firework bursts
        for burst in range(2):
            center_x = start_x + 20 + burst * 30
            center_y = start_y + 15

            if center_x < img.width and center_y < img.height:
                firework_colors = ['light_red', 'light_yellow', 'light_green', 'light_blue']
                color = firework_colors[burst]

                for angle in range(0, 360, 30):
                    for radius in range(1, 12):
                        x = center_x + int(radius * math.cos(math.radians(angle)))
                        y = center_y + int(radius * math.sin(math.radians(angle)))
                        if start_x <= x < img.width and start_y <= y < img.height:
                            img.putpixel((x, y), COLORS[color])

    print("🎆 Added spectacular decorations")

def test_program(image_path):
    """Test the program"""
    try:
        result = subprocess.run(['./piet', image_path, '1'],
                              capture_output=True, text=True, timeout=10,
                              cwd='../files')

        output = result.stdout.strip()
        print(f"🧪 Program output: '{output}'")

        if "Hello World!" in output:
            print("🎉 SUCCESS! Perfect 'Hello World!' output!")
            return True
        else:
            print(f"⚠️ Output doesn't match expected 'Hello World!'")
            print(f"Return code: {result.returncode}")
            if result.stderr:
                print(f"Error: {result.stderr}")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Program timed out")
        return False
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

if __name__ == "__main__":
    print("🚀 Building PROPER Hello World from scratch! 🚀")
    print("Understanding real Piet mechanics - no shortcuts!")

    img, output_path = create_spectacular_hello_world()

    print("\n🧪 Testing our proper Hello World...")
    success = test_program(output_path)

    if success:
        print("\n🏆 SPECTACULAR SUCCESS! 🏆")
        print("We built a proper 'Hello World!' from scratch!")
    else:
        print("\n🔧 Need to debug the program mechanics...")
        print("Learning opportunity to understand Piet better!")