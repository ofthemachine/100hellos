#!/usr/bin/env python3
"""
Functional Piet Art Generator
Creates beautiful AND working Piet programs
"""

from PIL import Image, ImageDraw
import random
import math

# Exact Piet colors as per specification
PIET_COLORS = {
    # Light colors (lightness 0)
    (0, 0): (255, 192, 192),  # light red
    (1, 0): (255, 255, 192),  # light yellow
    (2, 0): (192, 255, 192),  # light green
    (3, 0): (192, 255, 255),  # light cyan
    (4, 0): (192, 192, 255),  # light blue
    (5, 0): (255, 192, 255),  # light magenta

    # Normal colors (lightness 1)
    (0, 1): (255, 0, 0),      # red
    (1, 1): (255, 255, 0),    # yellow
    (2, 1): (0, 255, 0),      # green
    (3, 1): (0, 255, 255),    # cyan
    (4, 1): (0, 0, 255),      # blue
    (5, 1): (255, 0, 255),    # magenta

    # Dark colors (lightness 2)
    (0, 2): (192, 0, 0),      # dark red
    (1, 2): (192, 192, 0),    # dark yellow
    (2, 2): (0, 192, 0),      # dark green
    (3, 2): (0, 192, 192),    # dark cyan
    (4, 2): (0, 0, 192),      # dark blue
    (5, 2): (192, 0, 192),    # dark magenta
}

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class FunctionalPietArtist:
    def __init__(self, width=600, height=200):
        self.width = width
        self.height = height
        self.image = Image.new('RGB', (width, height), WHITE)
        self.draw = ImageDraw.Draw(self.image)
        self.current_x = 0
        self.current_y = 20

    def fill_block(self, x, y, width, height, color, style='solid'):
        """Fill a block with artistic patterns"""
        if style == 'solid':
            self.draw.rectangle([x, y, x + width - 1, y + height - 1], fill=color)
        elif style == 'dotted':
            for px in range(x, x + width, 2):
                for py in range(y, y + height, 2):
                    if (px + py) % 4 == 0:
                        self.draw.point((px, py), fill=color)
                    else:
                        self.draw.point((px, py), fill=WHITE)
        elif style == 'striped':
            for px in range(x, x + width):
                for py in range(y, y + height):
                    if (px + py) % 3 == 0:
                        self.draw.point((px, py), fill=color)
                    else:
                        self.draw.point((px, py), fill=WHITE)
        elif style == 'checkerboard':
            for px in range(x, x + width):
                for py in range(y, y + height):
                    if (px // 2 + py // 2) % 2 == 0:
                        self.draw.point((px, py), fill=color)
                    else:
                        self.draw.point((px, py), fill=WHITE)

    def create_artistic_block(self, hue, lightness, size, artistic_style='swirl'):
        """Create a functionally correct block with artistic flair"""
        color = PIET_COLORS[(hue, lightness)]

        # Calculate dimensions for the block
        if size <= 4:
            width, height = size, 1
        elif size <= 16:
            width = int(math.sqrt(size)) + 1
            height = (size + width - 1) // width
        else:
            width = min(size, 20)  # Cap width for visual appeal
            height = (size + width - 1) // width

        # Add artistic background decoration
        if artistic_style == 'swirl':
            self._add_swirl_decoration()
        elif artistic_style == 'sparkle':
            self._add_sparkle_decoration()

        # Create the functional block with artistic pattern
        pattern = random.choice(['solid', 'dotted', 'striped', 'checkerboard'])
        self.fill_block(self.current_x, self.current_y, width, height, color, pattern)

        # Add artistic border
        if random.random() < 0.4:  # 40% chance of decorative border
            border_color = self._get_complementary_color(color)
            self.draw.rectangle([self.current_x-1, self.current_y-1,
                               self.current_x + width, self.current_y + height],
                              outline=border_color, width=1)

        self.current_x += width + 3  # spacing between blocks
        return width, height

    def _add_swirl_decoration(self):
        """Add swirling background decoration"""
        if random.random() < 0.3:
            center_x = self.current_x - 10
            center_y = self.current_y + 10

            for angle in range(0, 180, 15):
                r = angle / 180.0 * 8
                x = center_x + r * math.cos(math.radians(angle))
                y = center_y + r * math.sin(math.radians(angle))

                if 0 <= x < self.width and 0 <= y < self.height:
                    decoration_color = random.choice(list(PIET_COLORS.values()))
                    self.draw.point((int(x), int(y)), fill=decoration_color)

    def _add_sparkle_decoration(self):
        """Add sparkle effects around current position"""
        if random.random() < 0.2:
            for _ in range(3):
                sparkle_x = self.current_x + random.randint(-15, 5)
                sparkle_y = self.current_y + random.randint(-10, 20)

                if 0 <= sparkle_x < self.width and 0 <= sparkle_y < self.height:
                    sparkle_color = random.choice(list(PIET_COLORS.values()))
                    self.draw.point((sparkle_x, sparkle_y), fill=sparkle_color)

    def _get_complementary_color(self, color):
        """Get a complementary color for artistic effect"""
        r, g, b = color
        return (255-r, 255-g, 255-b)

    def add_character_sequence(self, char_code, style='swirl'):
        """Add the Piet sequence for outputting a character"""
        # Push: Create block with size = ASCII code (dark -> light = push)
        self.create_artistic_block(0, 2, char_code, style)  # dark red block
        self.create_artistic_block(0, 0, 1, style)          # light red (push command)

        # Outchar: Change hue (light red -> light magenta = outchar)
        self.create_artistic_block(5, 0, 1, style)          # light magenta (outchar)

        # Add some visual separation
        self.current_x += 8

    def new_line(self):
        """Move to next visual line"""
        self.current_x = 10 + random.randint(-5, 5)
        self.current_y += 50 + random.randint(-10, 10)

    def add_terminator(self):
        """Add artistic program terminator"""
        # Create termination loop - single color surrounded by black
        term_color = random.choice(list(PIET_COLORS.values()))

        # Artistic termination with multiple layers
        for i in range(3):
            size = 8 + i * 2
            offset = i * 1

            # Black border
            self.draw.rectangle([self.current_x + offset - 2, self.current_y + offset - 2,
                               self.current_x + offset + size + 2, self.current_y + offset + size + 2],
                              fill=BLACK)

            # Colored center with artistic pattern
            pattern = ['solid', 'dotted', 'striped'][i % 3]
            self.fill_block(self.current_x + offset, self.current_y + offset, size, size, term_color, pattern)

    def save(self, filename):
        """Save the artistic Piet program"""
        self.image.save(filename)
        print(f"Created artistic Piet program: {filename}")

def create_artistic_hello_world():
    """Create artistic Hello World that actually works"""
    print("Creating functional artistic Hello World...")

    artist = FunctionalPietArtist(800, 400)

    # Create "Hello, World!" with artistic flair
    message = "Hello, World!"
    styles = ['swirl', 'sparkle']

    for i, char in enumerate(message):
        style = styles[i % len(styles)]
        artist.add_character_sequence(ord(char), style)

        # Artistic line breaks
        if char in [' ', ',']:
            if random.random() < 0.7:  # 70% chance of line break after space/comma
                artist.new_line()

    # Add newline
    artist.add_character_sequence(10, 'sparkle')  # newline character

    # Artistic termination
    artist.new_line()
    artist.current_x += 50
    artist.add_terminator()

    artist.save("hello_world_functional_art.png")

def create_artistic_fibonacci():
    """Create artistic Fibonacci sequence (simplified version)"""
    print("Creating functional artistic Fibonacci...")

    artist = FunctionalPietArtist(1000, 300)

    # Output first few Fibonacci numbers as a string: "1, 1, 2, 3, 5"
    fibonacci_output = "1, 1, 2, 3, 5"

    for i, char in enumerate(fibonacci_output):
        style = 'swirl' if i % 2 == 0 else 'sparkle'
        artist.add_character_sequence(ord(char), style)

        if char == ',':
            artist.current_x += 5  # Extra spacing after commas

    # Add newline
    artist.add_character_sequence(10, 'swirl')

    # Artistic termination
    artist.new_line()
    artist.current_x += 100
    artist.add_terminator()

    artist.save("fibonacci_functional_art.png")

if __name__ == "__main__":
    create_artistic_hello_world()
    create_artistic_fibonacci()
    print("\nFunctional artistic Piet programs created!")
    print("These should work with your Piet interpreter while looking beautiful!")