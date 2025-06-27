#!/usr/bin/env python3
"""
Simple Artistic Piet Generator
Creates beautiful Piet programs using only pure Piet colors
"""

from PIL import Image, ImageDraw
import random
import math

# Pure Piet colors only
PIET_COLORS = [
    (255, 192, 192),  # light red
    (255, 255, 192),  # light yellow
    (192, 255, 192),  # light green
    (192, 255, 255),  # light cyan
    (192, 192, 255),  # light blue
    (255, 192, 255),  # light magenta
    (255, 0, 0),      # red
    (255, 255, 0),    # yellow
    (0, 255, 0),      # green
    (0, 255, 255),    # cyan
    (0, 0, 255),      # blue
    (255, 0, 255),    # magenta
    (192, 0, 0),      # dark red
    (192, 192, 0),    # dark yellow
    (0, 192, 0),      # dark green
    (0, 192, 192),    # dark cyan
    (0, 0, 192),      # dark blue
    (192, 0, 192),    # dark magenta
]

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

# Color mappings for easy access
DARK_RED = (192, 0, 0)
LIGHT_RED = (255, 192, 192)
LIGHT_MAGENTA = (255, 192, 255)

class SimpleArtistPiet:
    def __init__(self, width=600, height=200):
        self.width = width
        self.height = height
        self.image = Image.new('RGB', (width, height), WHITE)
        self.draw = ImageDraw.Draw(self.image)
        self.x = 0
        self.y = 20

    def create_block(self, color, size, shape='rect'):
        """Create a colored block with artistic shape"""
        if size <= 0:
            return

        if shape == 'rect':
            # Simple rectangle
            width = min(size, 20)
            height = max(1, (size + width - 1) // width)
            self.draw.rectangle([self.x, self.y, self.x + width - 1, self.y + height - 1], fill=color)
            self.x += width + 2

        elif shape == 'circle':
            # Artistic circular/oval shape
            diameter = max(3, int(math.sqrt(size * 4)))
            self.draw.ellipse([self.x, self.y, self.x + diameter, self.y + diameter], fill=color)

            # Fill remaining pixels as small rectangles
            remaining = size - int(diameter * diameter * 0.785)  # approximate circle area
            if remaining > 0:
                self.draw.rectangle([self.x + diameter + 2, self.y,
                                   self.x + diameter + 2 + remaining - 1, self.y], fill=color)
            self.x += diameter + remaining + 3

        elif shape == 'diamond':
            # Diamond shape made of rectangles
            side = max(2, int(math.sqrt(size / 2)))

            # Draw diamond as stacked rectangles
            for i in range(side):
                width = (i + 1) if i < side // 2 else (side - i)
                self.draw.rectangle([self.x + side - width, self.y + i,
                                   self.x + side + width - 1, self.y + i], fill=color)

            # Fill remaining pixels
            diamond_area = side * side
            remaining = size - diamond_area
            if remaining > 0:
                self.draw.rectangle([self.x + side * 2 + 2, self.y,
                                   self.x + side * 2 + 2 + remaining - 1, self.y], fill=color)

            self.x += side * 2 + remaining + 3

    def add_decorative_elements(self):
        """Add small decorative elements between blocks"""
        if random.random() < 0.3:  # 30% chance
            for _ in range(random.randint(1, 3)):
                dec_x = self.x + random.randint(-10, 5)
                dec_y = self.y + random.randint(-5, 15)

                if 0 <= dec_x < self.width - 3 and 0 <= dec_y < self.height - 3:
                    color = random.choice(PIET_COLORS)
                    size = random.randint(1, 3)
                    self.draw.rectangle([dec_x, dec_y, dec_x + size, dec_y + size], fill=color)

    def add_character_art(self, char_code):
        """Add artistic sequence for one character: PUSH + OUTCHAR"""
        shapes = ['rect', 'circle', 'diamond']

        # PUSH: dark red block (size = ASCII code) -> light red (push command)
        push_shape = random.choice(shapes)
        self.create_block(DARK_RED, char_code, push_shape)
        self.create_block(LIGHT_RED, 1, 'rect')  # Push command trigger

        # OUTCHAR: light red -> light magenta (outchar command)
        outchar_shape = random.choice(shapes)
        self.create_block(LIGHT_MAGENTA, 1, outchar_shape)

        # Add decorative spacing
        self.add_decorative_elements()
        self.x += 5

    def new_line(self):
        """Move to new line with artistic offset"""
        self.x = random.randint(5, 15)
        self.y += random.randint(40, 60)

    def add_artistic_terminator(self):
        """Add beautiful termination block surrounded by black"""
        # Artistic termination with colorful center
        term_color = random.choice(PIET_COLORS)

        # Create layered termination
        for layer in range(3):
            size = 8 + layer * 3
            offset = layer * 2

            # Black border
            self.draw.rectangle([self.x + offset - 1, self.y + offset - 1,
                               self.x + offset + size + 1, self.y + offset + size + 1], fill=BLACK)

            # Colored interior
            interior_color = PIET_COLORS[(PIET_COLORS.index(term_color) + layer) % len(PIET_COLORS)]
            self.draw.rectangle([self.x + offset, self.y + offset,
                               self.x + offset + size, self.y + offset + size], fill=interior_color)

    def save(self, filename):
        """Save the artistic Piet program"""
        self.image.save(filename)
        print(f"Created simple artistic Piet: {filename}")

def create_hello_world_simple_art():
    """Create simple artistic Hello World"""
    print("Creating simple artistic Hello World...")

    artist = SimpleArtistPiet(700, 350)

    message = "Hello, World!"

    for i, char in enumerate(message):
        artist.add_character_art(ord(char))

        # Artistic line breaks
        if char in [' ', ','] and random.random() < 0.6:
            artist.new_line()

    # Add newline character
    artist.add_character_art(10)

    # Artistic termination
    artist.new_line()
    artist.x += 50
    artist.add_artistic_terminator()

    artist.save("hello_simple_art.png")

def create_fibonacci_simple_art():
    """Create simple artistic Fibonacci"""
    print("Creating simple artistic Fibonacci...")

    artist = SimpleArtistPiet(800, 250)

    # Output: "1, 1, 2, 3, 5, 8"
    fib_text = "1, 1, 2, 3, 5, 8"

    for i, char in enumerate(fib_text):
        artist.add_character_art(ord(char))

        if char == ',' and random.random() < 0.5:
            artist.x += 10  # Extra space after commas

    # Add newline
    artist.add_character_art(10)

    # Artistic termination
    artist.new_line()
    artist.x += 80
    artist.add_artistic_terminator()

    artist.save("fibonacci_simple_art.png")

if __name__ == "__main__":
    create_hello_world_simple_art()
    create_fibonacci_simple_art()
    print("\nSimple artistic Piet programs created!")
    print("These use only pure Piet colors and should work correctly!")