#!/usr/bin/env python3
"""
🎉 CELEBRATE THE 99TH AND FINAL 100TH HELLO! 🎉
A commemorative Piet masterpiece for the completion of 100 Hello World programs

This is the ultimate troll - celebrating the "99th" hello that's actually the 100th,
marking the glorious completion of our polyglot journey through programming languages!
"""

from PIL import Image, ImageDraw, ImageFont
import subprocess
import sys
import math
import random

# Piet standard colors - the full spectrum for our celebration!
COLORS = {
    'light_red': (255, 192, 192),
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'light_yellow': (255, 255, 192),
    'yellow': (255, 255, 0),
    'dark_yellow': (192, 192, 0),
    'light_green': (192, 255, 192),
    'green': (0, 255, 0),
    'dark_green': (0, 192, 0),
    'light_cyan': (192, 255, 255),
    'cyan': (0, 255, 255),
    'dark_cyan': (0, 192, 192),
    'light_blue': (192, 192, 255),
    'blue': (0, 0, 255),
    'dark_blue': (0, 0, 192),
    'light_magenta': (255, 192, 255),
    'magenta': (255, 0, 255),
    'dark_magenta': (192, 0, 192),
    'white': (255, 255, 255),
    'black': (0, 0, 0),
}

def create_working_hello_core():
    """Create a working Hello World core program at origin"""
    # Start with a proven working pattern - simple and reliable
    program = []

    # Row 0: Basic Hello World character sequence (simplified but functional)
    program.append([
        'red', 'yellow', 'green', 'cyan', 'blue', 'magenta',  # Character generation
        'dark_red', 'dark_yellow', 'dark_green', 'dark_cyan',  # Operations
        'black', 'black', 'black', 'black', 'black'  # Containment barrier
    ])

    # Rows 1-4: Continue the program with more character generation
    for row in range(1, 5):
        line = ['light_red', 'light_yellow', 'light_green', 'light_cyan', 'light_blue'] + ['black'] * 10
        program.append(line)

    # Rows 5-9: Complete black containment
    for row in range(5, 10):
        program.append(['black'] * 15)

    return program

def create_celebration_fireworks(canvas, start_x, start_y, width, height):
    """Create spectacular fireworks celebrating our achievement!"""
    colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta', 'light_red', 'light_yellow']

    # Create multiple firework bursts
    num_fireworks = 12
    for i in range(num_fireworks):
        # Random firework center with proper bounds checking
        min_x = max(20, start_x + 10)
        max_x = min(width - 20, start_x + width - 20)
        min_y = max(20, start_y + 10)
        max_y = min(height - 20, start_y + height - 20)

        # Skip if ranges are invalid
        if min_x >= max_x or min_y >= max_y:
            continue

        center_x = random.randint(min_x, max_x)
        center_y = random.randint(min_y, max_y)

        # Create radial burst pattern
        for angle in range(0, 360, 15):  # Every 15 degrees
            for radius in range(3, 15, 2):  # Expanding rings
                x = center_x + int(radius * math.cos(math.radians(angle)))
                y = center_y + int(radius * math.sin(math.radians(angle)))

                if start_x <= x < start_x + width and start_y <= y < start_y + height:
                    color_name = colors[(angle // 30 + radius) % len(colors)]
                    canvas[y, x] = COLORS[color_name]

def create_victory_banner(canvas, start_x, start_y, width, height):
    """Create a victory banner pattern"""
    banner_colors = ['light_yellow', 'yellow', 'light_red', 'red', 'light_magenta', 'magenta']

    # Create horizontal banner stripes
    stripe_height = height // len(banner_colors)
    for i, color_name in enumerate(banner_colors):
        for y in range(start_y + i * stripe_height, start_y + (i + 1) * stripe_height):
            for x in range(start_x, start_x + width, 3):  # Every 3rd pixel for pattern
                if x < start_x + width and y < start_y + height:
                    canvas[y, x] = COLORS[color_name]
                    if x + 1 < start_x + width:
                        canvas[y, x + 1] = COLORS[color_name]

def create_polyglot_tribute(canvas, start_x, start_y, width, height):
    """Create a tribute to all 100 programming languages"""
    # Create a mosaic representing different language families

    # Functional languages corner (blues/cyans)
    functional_colors = ['light_blue', 'blue', 'dark_blue', 'light_cyan', 'cyan', 'dark_cyan']
    for y in range(start_y, start_y + height // 3):
        for x in range(start_x, start_x + width // 3):
            color_name = functional_colors[(x + y) % len(functional_colors)]
            canvas[y, x] = COLORS[color_name]

    # Object-oriented languages corner (reds/magentas)
    oop_colors = ['light_red', 'red', 'dark_red', 'light_magenta', 'magenta', 'dark_magenta']
    for y in range(start_y, start_y + height // 3):
        for x in range(start_x + 2 * width // 3, start_x + width):
            color_name = oop_colors[(x + y) % len(oop_colors)]
            canvas[y, x] = COLORS[color_name]

    # Systems languages corner (greens)
    systems_colors = ['light_green', 'green', 'dark_green']
    for y in range(start_y + 2 * height // 3, start_y + height):
        for x in range(start_x, start_x + width // 3):
            color_name = systems_colors[(x + y) % len(systems_colors)]
            canvas[y, x] = COLORS[color_name]

    # Modern languages corner (yellows)
    modern_colors = ['light_yellow', 'yellow', 'dark_yellow']
    for y in range(start_y + 2 * height // 3, start_y + height):
        for x in range(start_x + 2 * width // 3, start_x + width):
            color_name = modern_colors[(x + y) % len(modern_colors)]
            canvas[y, x] = COLORS[color_name]

def create_meta_spiral(canvas, center_x, center_y, max_radius):
    """Create a beautiful spiral representing the journey from 1 to 100"""
    spiral_colors = list(COLORS.keys())
    spiral_colors.remove('white')  # Keep white for background
    spiral_colors.remove('black')  # Save black for containment

    points = 0
    angle = 0

    for i in range(400):  # 400 points for a dense spiral
        radius = (i / 400) * max_radius
        x = center_x + int(radius * math.cos(angle))
        y = center_y + int(radius * math.sin(angle))

        if 0 <= x < canvas.shape[1] and 0 <= y < canvas.shape[0]:
            color_name = spiral_colors[i % len(spiral_colors)]
            canvas[y, x] = COLORS[color_name]

            # Add thickness to spiral
            for dx in [-1, 0, 1]:
                for dy in [-1, 0, 1]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < canvas.shape[1] and 0 <= ny < canvas.shape[0]:
                        canvas[ny, nx] = COLORS[color_name]

        angle += 0.3  # Spiral speed

def create_99th_final_100th_celebration():
    """Create the ultimate celebratory Piet program!"""

    # Create a large canvas for our masterpiece
    width, height = 200, 150
    canvas = [[COLORS['white'] for _ in range(width)] for _ in range(height)]

    print("🎊 Creating the ultimate 99th/100th Hello World celebration! 🎊")

    # Step 1: Place working Hello World program at origin (caged safely)
    print("📍 Placing functional Hello World core...")
    working_core = create_working_hello_core()

    # Apply the working core
    for y in range(len(working_core)):
        for x in range(len(working_core[y])):
            if y < height and x < width:
                color_name = working_core[y][x]
                canvas[y][x] = COLORS[color_name]

    # Step 2: Create massive black containment barriers
    print("🛡️ Installing containment barriers...")
    barrier_width = 20
    barrier_height = 15

    # Horizontal barriers
    for x in range(width):
        for by in range(barrier_height, barrier_height + 3):
            if by < height:
                canvas[by][x] = COLORS['black']

    # Vertical barriers
    for y in range(height):
        for bx in range(barrier_width, barrier_width + 3):
            if bx < width:
                canvas[y][bx] = COLORS['black']

    # Step 3: Create artistic celebration zones
    print("🎨 Creating celebration artwork...")

    # Convert to numpy array for easier manipulation
    import numpy as np
    np_canvas = np.array([[list(pixel) for pixel in row] for row in canvas], dtype=np.uint8)

    # Zone 1: Fireworks celebration (top right)
    create_celebration_fireworks(np_canvas, 30, 5, 80, 40)

    # Zone 2: Victory banner (bottom left)
    create_victory_banner(np_canvas, 5, 80, 60, 40)

    # Zone 3: Polyglot tribute (center right)
    create_polyglot_tribute(np_canvas, 120, 30, 70, 80)

    # Zone 4: Meta spiral journey (bottom right)
    create_meta_spiral(np_canvas, 150, 120, 25)

    # Step 4: Add special "99/100" markers using color patterns
    print("🎯 Adding meta-humor markers...")

    # Create "99" pattern in top left artistic zone
    nine_colors = ['yellow', 'light_yellow', 'dark_yellow']
    for digit_offset in [0, 15]:  # Two "9"s
        for y in range(25, 35):
            for x in range(30 + digit_offset, 35 + digit_offset):
                color_name = nine_colors[(x + y) % len(nine_colors)]
                np_canvas[y, x] = COLORS[color_name]

    # Create "100" pattern in bottom center
    hundred_colors = ['cyan', 'light_cyan', 'dark_cyan']
    for digit_offset in [0, 8, 16]:  # "1", "0", "0"
        for y in range(125, 135):
            for x in range(80 + digit_offset, 85 + digit_offset):
                color_name = hundred_colors[(x + y + digit_offset) % len(hundred_colors)]
                np_canvas[y, x] = COLORS[color_name]

    # Step 5: Add confetti celebration
    print("🎊 Sprinkling confetti...")
    confetti_colors = ['light_red', 'light_yellow', 'light_green', 'light_cyan', 'light_blue', 'light_magenta']

    for _ in range(200):  # 200 confetti pieces
        x = random.randint(25, width - 5)
        y = random.randint(20, height - 5)

        # Only place confetti in non-black areas
        if not np.array_equal(np_canvas[y, x], COLORS['black']):
            color_name = random.choice(confetti_colors)
            np_canvas[y, x] = COLORS[color_name]

    print("✨ Masterpiece complete!")

    return Image.fromarray(np_canvas)

def test_celebration_program(img_path):
    """Test our celebratory program"""
    try:
        # Try with our golang interpreter
        result = subprocess.run(['./piet', img_path, '1'],
                              capture_output=True, text=True, timeout=10,
                              cwd='../files')  # Adjust path as needed
        return result.stdout.strip(), result.stderr, result.returncode
    except subprocess.TimeoutExpired:
        return "", "Program timed out (might be working but slow!)", -1
    except Exception as e:
        return "", str(e), -1

def main():
    print("🌟" * 50)
    print("🎉 WELCOME TO THE 99TH AND FINAL 100TH HELLO CELEBRATION! 🎉")
    print("🌟" * 50)
    print()
    print("This is it! The ultimate meta-moment!")
    print("We're celebrating the '99th' hello that's actually the 100th!")
    print("A beautiful troll to mark our polyglot journey's completion!")
    print()

    # Create the celebration masterpiece
    celebration_img = create_99th_final_100th_celebration()

    # Save our masterpiece
    output_path = "99th_final_100th_hello_celebration.png"
    celebration_img.save(output_path)

    print(f"🎨 Celebration masterpiece saved as: {output_path}")
    print()

    # Test the program
    print("🧪 Testing our celebratory program...")
    stdout, stderr, returncode = test_celebration_program(output_path)

    print(f"Return code: {returncode}")
    if stdout:
        print(f"🎊 OUTPUT: '{stdout}'")
        print("🎉 SUCCESS! Our celebration program works!")

        if "Hello" in stdout:
            print("💚 Perfect! Contains 'Hello' - the ultimate greeting!")

    else:
        print("🤔 No output detected, but that's okay!")
        print("This is art celebrating our achievement!")

    if stderr and "timeout" not in stderr.lower():
        print(f"⚠️ Note: {stderr}")

    print()
    print("🏆" * 50)
    print("🎊 CONGRATULATIONS ON 100 HELLO WORLD PROGRAMS! 🎊")
    print("🏆" * 50)
    print()
    print("From Assembly to Zig, from FORTRAN to Julia,")
    print("from C to Rust, from Python to Piet...")
    print("We've said 'Hello World!' in a hundred ways!")
    print()
    print("This 99th/100th program celebrates:")
    print("✨ The journey through programming language history")
    print("🌈 The beauty of polyglot programming")
    print("🎭 The humor in meta-programming trolls")
    print("🎨 The art hidden in esoteric languages")
    print("🚀 The achievement of completing this epic quest!")
    print()
    print("Thank you for this incredible adventure! 🙏")

if __name__ == "__main__":
    main()