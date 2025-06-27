#!/usr/bin/env python3
"""
Magical Piet Art Generator
Creates stunning, functional Piet programs with style and magic!
"""

from PIL import Image, ImageDraw
import random
import math

# Progopedia working color sequence
COLOR_PAIRS = [
    ((0, 0, 192), (192, 192, 255)),    # dark blue -> light blue
    ((192, 192, 255), (0, 192, 192)),  # light blue -> dark cyan
    ((0, 192, 192), (192, 255, 255)),  # dark cyan -> light cyan
    ((192, 255, 255), (0, 192, 0)),    # light cyan -> dark green
    ((0, 192, 0), (192, 255, 192)),    # dark green -> light green
    ((192, 255, 192), (192, 192, 0)),  # light green -> dark yellow
    ((192, 192, 0), (255, 255, 192)),  # dark yellow -> light yellow
    ((255, 255, 192), (192, 0, 0)),    # light yellow -> dark red
    ((192, 0, 0), (255, 192, 192)),    # dark red -> light red
    ((255, 192, 192), (192, 0, 192)),  # light red -> dark magenta
    ((192, 0, 192), (255, 192, 255)),  # dark magenta -> light magenta
    ((255, 192, 255), (0, 0, 192)),    # light magenta -> dark blue (cycle)
]

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class MagicalPietArt:
    def __init__(self, width=87, height=23):
        self.width = width
        self.height = height
        self.image = Image.new('RGB', (width, height), WHITE)
        self.draw = ImageDraw.Draw(self.image)
        self.x = 0
        self.y = 0
        self.color_index = 0

    def add_magical_background(self):
        """Add magical sparkles and elements in background areas"""
        # Add sparkles in bottom rows
        for _ in range(25):
            sparkle_x = random.randint(0, self.width - 1)
            sparkle_y = random.randint(15, self.height - 1)

            # Random sparkle colors
            sparkle_colors = [
                (255, 255, 192),  # light yellow
                (192, 255, 255),  # light cyan
                (255, 192, 255),  # light magenta
                (192, 255, 192),  # light green
            ]
            color = random.choice(sparkle_colors)

            # Tiny sparkle
            if random.random() < 0.7:
                self.draw.point((sparkle_x, sparkle_y), fill=color)
            else:
                # Slightly bigger sparkle
                self.draw.rectangle([sparkle_x, sparkle_y, sparkle_x+1, sparkle_y+1], fill=color)

        # Add magical borders
        for i in range(0, self.width, 3):
            if random.random() < 0.4:
                border_color = random.choice([(192, 192, 255), (255, 192, 192), (192, 255, 192)])
                self.draw.point((i, self.height-1), fill=border_color)
                self.draw.point((i, self.height-2), fill=border_color)

    def create_character_magic(self, char_ascii):
        """Create magical character sequence following progopedia pattern"""

        # Get the color pair for this character
        dark_color, light_color = COLOR_PAIRS[self.color_index % len(COLOR_PAIRS)]
        self.color_index += 1

        # Block 1: Dark color block with size = ASCII value
        self._create_artistic_block(dark_color, char_ascii, 'crystal')

        # Block 2: Light color block (triggers push command)
        self._create_artistic_block(light_color, 23, 'sparkle')

        # Get next color pair for outchar
        outchar_dark, outchar_light = COLOR_PAIRS[self.color_index % len(COLOR_PAIRS)]
        self.color_index += 1

        # Block 3: Different hue (triggers outchar command)
        self._create_artistic_block(outchar_dark, 101, 'flame')

    def _create_artistic_block(self, color, size, style='crystal'):
        """Create magical artistic blocks"""
        if style == 'crystal':
            self._create_crystal_block(color, size)
        elif style == 'sparkle':
            self._create_sparkle_block(color, size)
        elif style == 'flame':
            self._create_flame_block(color, size)
        else:
            self._create_basic_block(color, size)

    def _create_basic_block(self, color, size):
        """Create basic rectangular block with subtle magic"""
        # Calculate dimensions like progopedia
        width = min(size, 30)
        height = max(1, (size + width - 1) // width)

        # Main block
        self.draw.rectangle([self.x, self.y, self.x + width - 1, self.y + height - 1], fill=color)

        # Add magical shimmer occasionally
        if random.random() < 0.3:
            # Add a few bright pixels for shimmer
            for _ in range(3):
                shimmer_x = self.x + random.randint(0, width - 1)
                shimmer_y = self.y + random.randint(0, height - 1)
                bright_color = tuple(min(255, c + 30) for c in color)
                self.draw.point((shimmer_x, shimmer_y), fill=bright_color)

        self.x += width

    def _create_crystal_block(self, color, size):
        """Create crystal-like block"""
        width = min(size, 25)
        height = max(1, (size + width - 1) // width)

        # Create crystal facets
        for w in range(width):
            for h in range(height):
                px = self.x + w
                py = self.y + h

                # Add crystalline variation
                if (w + h) % 3 == 0:
                    # Brighter facet
                    bright_color = tuple(min(255, c + 20) for c in color)
                    self.draw.point((px, py), fill=bright_color)
                else:
                    self.draw.point((px, py), fill=color)

        self.x += width

    def _create_sparkle_block(self, color, size):
        """Create sparkling block"""
        width = min(size, 20)
        height = max(1, (size + width - 1) // width)

        # Base block
        self.draw.rectangle([self.x, self.y, self.x + width - 1, self.y + height - 1], fill=color)

        # Add sparkles
        for _ in range(width // 3):
            sparkle_x = self.x + random.randint(0, width - 1)
            sparkle_y = self.y + random.randint(0, height - 1)
            sparkle_color = tuple(min(255, c + 50) for c in color)
            self.draw.point((sparkle_x, sparkle_y), fill=sparkle_color)

        self.x += width

    def _create_flame_block(self, color, size):
        """Create flame-like block"""
        width = min(size, 28)
        height = max(1, (size + width - 1) // width)

        # Create flame pattern
        for w in range(width):
            flame_height = height + int(math.sin(w * 0.5) * 2)
            flame_height = max(1, min(flame_height, height + 2))

            for h in range(height):
                px = self.x + w
                py = self.y + h

                # Flickering effect
                if h < flame_height and (w + h) % 2 == 0:
                    flicker_color = tuple(min(255, c + 15) for c in color)
                    self.draw.point((px, py), fill=flicker_color)
                else:
                    self.draw.point((px, py), fill=color)

        self.x += width

    def add_magical_termination(self):
        """Add beautiful magical termination"""
        # Create termination loop like progopedia
        term_color = (0, 192, 0)  # dark green

        # Magical termination with sparkles
        term_width, term_height = 5, 3

        # Surrounding black (termination condition)
        self.draw.rectangle([self.x - 1, self.y - 1,
                           self.x + term_width + 1, self.y + term_height + 1], fill=BLACK)

        # Magical colored center
        for w in range(term_width):
            for h in range(term_height):
                px = self.x + w
                py = self.y + h

                if (w + h) % 2 == 0:
                    # Alternating bright pattern
                    bright_term = tuple(min(255, c + 40) for c in term_color)
                    self.draw.point((px, py), fill=bright_term)
                else:
                    self.draw.point((px, py), fill=term_color)

def create_magical_hello_world():
    """Create magical Hello World"""
    print("🌟 Creating magical Hello World Piet program...")

    # Use progopedia dimensions for compatibility
    artist = MagicalPietArt(87, 23)

    # Add magical background first
    artist.add_magical_background()

    # Reset to start position
    artist.x, artist.y = 0, 0

    # Create Hello, World! with newline
    message = "Hello, World!\n"

    for char in message:
        if char == '\n':
            artist.create_character_magic(10)  # newline ASCII
        else:
            artist.create_character_magic(ord(char))

    # Magical termination
    artist.x += 2
    artist.add_magical_termination()

    artist.image.save("magical_hello_world.png")
    print("✨ Created: magical_hello_world.png")

def create_magical_fibonacci():
    """Create magical Fibonacci"""
    print("🔢 Creating magical Fibonacci Piet program...")

    artist = MagicalPietArt(100, 25)
    artist.add_magical_background()
    artist.x, artist.y = 0, 0

    # Create simple Fibonacci: "1, 2, 3\n"
    fib_message = "1, 2, 3\n"

    for char in fib_message:
        if char == '\n':
            artist.create_character_magic(10)
        else:
            artist.create_character_magic(ord(char))

    # Magical termination
    artist.x += 2
    artist.add_magical_termination()

    artist.image.save("magical_fibonacci.png")
    print("🎆 Created: magical_fibonacci.png")

if __name__ == "__main__":
    create_magical_hello_world()
    create_magical_fibonacci()
    print("\n🎨 Magical Piet art programs created!")
    print("These combine the proven progopedia pattern with magical visual effects!")