#!/usr/bin/env python3
"""
🌟 SPECTACULAR HELLO WORLD GENERATOR 🌟

Build our own "Hello World!" Piet program from scratch and make it MAGNIFICENT!

Strategy:
1. Create minimal working "Hello World!" program at (0,0)
2. Add black barriers to contain execution
3. Add spectacular artistic elements in safe areas
4. Start simple, iterate to magnificence!
"""

from PIL import Image
import subprocess
import random
import math

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

def create_hello_world_program():
    """Create minimal Hello World program using proven patterns"""

    # ASCII values we need:
    # H=72, e=101, l=108, l=108, o=111, space=32, W=87, o=111, r=114, l=108, d=100, !=33, newline=10

    # Start with a simple approach - create the minimal program area
    program_width = 100  # Enough space for our commands
    program_height = 20  # Reasonable height

    # Create the program image
    program = Image.new('RGB', (program_width, program_height), COLORS['white'])

    # Build "Hello World!" step by step using blocks of pixels
    # We'll use the proven pattern: blocks of colored pixels = push numbers

    # H = 72 = 8 * 9
    add_number_block(program, 8, 1, 1, 'light_red')    # Push 8
    add_number_block(program, 9, 10, 1, 'light_yellow') # Push 9
    program.putpixel((20, 1), COLORS['light_green'])    # Multiply (8*9=72)
    program.putpixel((22, 1), COLORS['red'])            # Output H

    # e = 101 = 72 + 29, so we duplicate H and add 29
    program.putpixel((24, 1), COLORS['light_cyan'])     # Duplicate (H still on stack)
    add_number_block(program, 29, 26, 1, 'light_blue') # Push 29
    program.putpixel((36, 1), COLORS['cyan'])           # Add (72+29=101)
    program.putpixel((38, 1), COLORS['red'])            # Output e

    # l = 108 = 101 + 7
    program.putpixel((40, 1), COLORS['light_cyan'])     # Duplicate e
    add_number_block(program, 7, 42, 1, 'light_magenta') # Push 7
    program.putpixel((50, 1), COLORS['cyan'])           # Add (101+7=108)
    program.putpixel((52, 1), COLORS['red'])            # Output l
    program.putpixel((54, 1), COLORS['light_cyan'])     # Duplicate l for second l
    program.putpixel((56, 1), COLORS['red'])            # Output l

    # o = 111 = 108 + 3
    program.putpixel((58, 1), COLORS['light_cyan'])     # Duplicate l
    add_number_block(program, 3, 60, 1, 'dark_red')    # Push 3
    program.putpixel((64, 1), COLORS['cyan'])           # Add (108+3=111)
    program.putpixel((66, 1), COLORS['red'])            # Output o

    # Space = 32
    add_number_block(program, 32, 1, 3, 'dark_yellow') # Push 32
    program.putpixel((34, 3), COLORS['red'])            # Output space

    # W = 87 = 80 + 7
    add_number_block(program, 80, 1, 5, 'dark_green')  # Push 80
    add_number_block(program, 7, 14, 5, 'dark_cyan')   # Push 7
    program.putpixel((22, 5), COLORS['cyan'])           # Add (80+7=87)
    program.putpixel((24, 5), COLORS['red'])            # Output W

    # o = 111 (reuse previous pattern)
    program.putpixel((26, 5), COLORS['light_cyan'])     # Duplicate something and build 111 again
    add_number_block(program, 111, 28, 5, 'dark_blue') # Push 111 directly
    program.putpixel((50, 5), COLORS['red'])            # Output o

    # r = 114 = 111 + 3
    program.putpixel((52, 5), COLORS['light_cyan'])     # Duplicate o
    add_number_block(program, 3, 54, 5, 'dark_magenta') # Push 3
    program.putpixel((58, 5), COLORS['cyan'])           # Add (111+3=114)
    program.putpixel((60, 5), COLORS['red'])            # Output r

    # l = 108 (build again)
    add_number_block(program, 108, 1, 7, 'yellow')     # Push 108
    program.putpixel((20, 7), COLORS['red'])            # Output l

    # d = 100
    add_number_block(program, 100, 22, 7, 'green')     # Push 100
    program.putpixel((42, 7), COLORS['red'])            # Output d

    # ! = 33
    add_number_block(program, 33, 44, 7, 'blue')       # Push 33
    program.putpixel((56, 7), COLORS['red'])            # Output !

    # Newline = 10
    add_number_block(program, 10, 58, 7, 'magenta')    # Push 10
    program.putpixel((68, 7), COLORS['red'])            # Output newline

    # Terminator
    program.putpixel((70, 7), COLORS['black'])          # End program

    return program

def add_number_block(img, number, start_x, start_y, color):
    """Add a block of pixels to represent a number (limited to reasonable size)"""
    # For large numbers, we'll just use a representative block
    block_size = min(number, 20)  # Cap at 20 pixels for sanity

    for i in range(block_size):
        x = start_x + (i % 8)  # Wrap to next row after 8 pixels
        y = start_y + (i // 8)
        if x < img.width and y < img.height:
            img.putpixel((x, y), COLORS[color])

def create_spectacular_hello_world(canvas_width=320, canvas_height=240, spectacle_level=1):
    """Create spectacular Hello World with increasing levels of magnificence"""

    print(f"🌟 Creating SPECTACULAR Hello World! (Level {spectacle_level}) 🌟")

    # Step 1: Create the core program
    print("💻 Building custom Hello World program...")
    core_program = create_hello_world_program()
    print(f"✅ Created {core_program.width}x{core_program.height} core program")

    # Step 2: Create expanded canvas (must be divisible by codel size)
    canvas_width = ((canvas_width + 15) // 16) * 16
    canvas_height = ((canvas_height + 15) // 16) * 16

    spectacular = Image.new('RGB', (canvas_width, canvas_height), COLORS['white'])

    # Step 3: Place core program at (0,0)
    spectacular.paste(core_program, (0, 0))

    # Step 4: Add protective black barriers
    barrier_thickness = 8

    # Right barrier
    for x in range(core_program.width, min(canvas_width, core_program.width + barrier_thickness)):
        for y in range(canvas_height):
            spectacular.putpixel((x, y), COLORS['black'])

    # Bottom barrier
    for y in range(core_program.height, min(canvas_height, core_program.height + barrier_thickness)):
        for x in range(canvas_width):
            spectacular.putpixel((x, y), COLORS['black'])

    print("🖤 Added protective black barriers")

    # Step 5: Add spectacular decorations based on level
    decoration_start_x = core_program.width + barrier_thickness
    decoration_start_y = core_program.height + barrier_thickness

    if spectacle_level >= 1:
        add_rainbow_celebration(spectacular, decoration_start_x, decoration_start_y, canvas_width, canvas_height)

    if spectacle_level >= 2:
        add_fireworks_display(spectacular, decoration_start_x, decoration_start_y, canvas_width, canvas_height)

    if spectacle_level >= 3:
        add_fractal_beauty(spectacular, decoration_start_x, decoration_start_y, canvas_width, canvas_height)

    # Step 6: Save and test
    output_path = f"spectacular_hello_world_level_{spectacle_level}.png"
    spectacular.save(output_path)
    print(f"💾 Saved as: {output_path}")

    # Test it
    print("🧪 Testing spectacular Hello World...")
    success = test_program(output_path)

    return spectacular, success

def add_rainbow_celebration(img, start_x, start_y, width, height):
    """Add rainbow celebration patterns"""
    rainbow_colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']

    # Rainbow stripes in right area
    if start_x < width:
        stripe_width = (width - start_x) // len(rainbow_colors)
        for i, color in enumerate(rainbow_colors):
            stripe_x = start_x + i * stripe_width
            for x in range(stripe_x, min(width, stripe_x + stripe_width)):
                for y in range(min(height, start_y)):  # Only in safe area
                    img.putpixel((x, y), COLORS[color])

    print("🌈 Added rainbow celebration")

def add_fireworks_display(img, start_x, start_y, width, height):
    """Add fireworks in bottom area"""
    if start_y < height:
        # Create fireworks bursts
        for burst in range(5):
            center_x = start_x + random.randint(20, width - start_x - 20) if start_x + 40 < width else start_x + 10
            center_y = start_y + random.randint(20, height - start_y - 20) if start_y + 40 < height else start_y + 10

            firework_colors = ['light_red', 'light_yellow', 'light_green', 'light_cyan', 'light_blue', 'light_magenta']
            color = random.choice(firework_colors)

            # Create burst pattern
            for angle in range(0, 360, 30):
                for radius in range(1, 15):
                    x = center_x + int(radius * math.cos(math.radians(angle)))
                    y = center_y + int(radius * math.sin(math.radians(angle)))
                    if start_x <= x < width and start_y <= y < height:
                        img.putpixel((x, y), COLORS[color])

    print("🎆 Added fireworks display")

def add_fractal_beauty(img, start_x, start_y, width, height):
    """Add fractal patterns for maximum beauty"""
    # Simple Sierpinski-like pattern
    fractal_colors = ['dark_red', 'dark_green', 'dark_blue']

    if start_x < width and start_y < height:
        for x in range(start_x, width, 2):
            for y in range(start_y, height, 2):
                if (x ^ y) % 8 == 0:  # XOR pattern creates fractal-like effect
                    color = fractal_colors[(x + y) % len(fractal_colors)]
                    img.putpixel((x, y), COLORS[color])

    print("🔮 Added fractal beauty")

def test_program(image_path):
    """Test the program"""
    try:
        result = subprocess.run(['./piet', image_path, '1'],
                              capture_output=True, text=True, timeout=10,
                              cwd='../files')

        output = result.stdout.strip()
        if "Hello World!" in output:
            print(f"🎉 SUCCESS! Output: '{output}'")
            return True
        else:
            print(f"⚠️ Unexpected output: '{output}'")
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
    print("🚀 Starting Spectacular Hello World Creation! 🚀")
    print("Building from scratch for maximum control and beauty!")

    # Start with level 1 and iterate
    img, success = create_spectacular_hello_world(spectacle_level=1)

    if success:
        print("\n🏆 MAGNIFICENT SUCCESS! 🏆")
        print("Our custom Hello World program works!")
        print("Ready to increase spectacle level!")
    else:
        print("\n🔧 Need to debug the core program first...")
        print("Let's iterate and improve!")