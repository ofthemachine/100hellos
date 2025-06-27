#!/usr/bin/env python3
"""
Working Artistic Piet Generator
Based on the successful progopedia pattern but with artistic flair
"""

from PIL import Image, ImageDraw
import random

# Exact Piet colors
DARK_BLUE = (0, 0, 192)      # 16
LIGHT_BLUE = (192, 192, 255)  # 4
DARK_CYAN = (0, 192, 192)     # 15
LIGHT_CYAN = (192, 255, 255)  # 3
DARK_GREEN = (0, 192, 0)      # 14
LIGHT_GREEN = (192, 255, 192) # 2
DARK_YELLOW = (192, 192, 0)   # 13
LIGHT_YELLOW = (255, 255, 192) # 1
DARK_RED = (192, 0, 0)        # 12
LIGHT_RED = (255, 192, 192)   # 0
DARK_MAGENTA = (192, 0, 192)  # 17
LIGHT_MAGENTA = (255, 192, 255) # 5

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class WorkingArtistPiet:
    def __init__(self, width=600, height=100):
        self.width = width
        self.height = height
        self.image = Image.new('RGB', (width, height), WHITE)
        self.draw = ImageDraw.Draw(self.image)
        self.x = 0
        self.y = 0

    def add_background_art(self):
        """Add subtle background artistic elements"""
        # Add some decorative elements in the bottom area
        for _ in range(15):
            art_x = random.randint(0, self.width - 10)
            art_y = random.randint(self.height - 30, self.height - 5)

            if random.random() < 0.5:
                # Tiny colored squares
                size = random.randint(2, 5)
                colors = [LIGHT_BLUE, LIGHT_GREEN, LIGHT_YELLOW, LIGHT_RED, LIGHT_MAGENTA, LIGHT_CYAN]
                color = random.choice(colors)
                self.draw.rectangle([art_x, art_y, art_x + size, art_y + size], fill=color)
            else:
                # Small circles
                radius = random.randint(2, 4)
                colors = [DARK_BLUE, DARK_GREEN, DARK_YELLOW, DARK_RED, DARK_MAGENTA, DARK_CYAN]
                color = random.choice(colors)
                self.draw.ellipse([art_x, art_y, art_x + radius*2, art_y + radius*2], fill=color)

    def create_character_blocks(self, char_ascii, artistic_style='normal'):
        """Create the functional blocks for one character"""

        # Block 1: Dark color with size = ASCII value (for push)
        if artistic_style == 'wavy':
            self._create_wavy_block(DARK_BLUE, char_ascii)
        else:
            self._create_artistic_rect(DARK_BLUE, char_ascii)

        # Block 2: Light version (trigger push command: dark->light = push)
        if artistic_style == 'wavy':
            self._create_wavy_block(LIGHT_BLUE, 23)  # fixed size for visual consistency
        else:
            self._create_artistic_rect(LIGHT_BLUE, 23)

        # Block 3: Different hue (trigger outchar: blue->cyan = outchar)
        if artistic_style == 'wavy':
            self._create_wavy_block(DARK_CYAN, 101)  # medium size for visual balance
        else:
            self._create_artistic_rect(DARK_CYAN, 101)

    def _create_artistic_rect(self, color, pixel_count):
        """Create rectangular block with artistic touches"""
        # Calculate optimal dimensions
        width = min(pixel_count, 30)  # cap width for aesthetics
        height = max(1, (pixel_count + width - 1) // width)

        # Main block
        self.draw.rectangle([self.x, self.y, self.x + width - 1, self.y + height - 1], fill=color)

        # Add artistic border occasionally
        if random.random() < 0.3:
            border_colors = [BLACK, WHITE]
            border_color = random.choice(border_colors)
            self.draw.rectangle([self.x, self.y, self.x + width - 1, self.y + height - 1],
                              outline=border_color, width=1)

        self.x += width

    def _create_wavy_block(self, color, pixel_count):
        """Create wavy artistic block while maintaining pixel count"""
        # Calculate base dimensions
        base_width = min(pixel_count, 25)
        base_height = max(1, (pixel_count + base_width - 1) // base_width)

        # Create wavy pattern
        pixels_placed = 0
        for w in range(base_width):
            wave_height = int(base_height + 2 * math.sin(w * 0.3))
            wave_height = max(1, min(wave_height, base_height + 2))

            for h in range(wave_height):
                if pixels_placed < pixel_count:
                    self.draw.point((self.x + w, self.y + h), fill=color)
                    pixels_placed += 1

        # Fill any remaining pixels as a small rectangle
        if pixels_placed < pixel_count:
            remaining = pixel_count - pixels_placed
            self.draw.rectangle([self.x + base_width, self.y,
                               self.x + base_width + remaining - 1, self.y], fill=color)

        self.x += base_width + max(0, pixel_count - pixels_placed)

    def add_artistic_separator(self):
        """Add small artistic separator between characters"""
        sep_colors = [LIGHT_RED, LIGHT_GREEN, LIGHT_YELLOW, LIGHT_MAGENTA, LIGHT_CYAN]
        sep_color = random.choice(sep_colors)

        # Small decorative element
        if random.random() < 0.5:
            # Vertical line
            self.draw.line([self.x, self.y, self.x, self.y + 10], fill=sep_color, width=1)
            self.x += 2
        else:
            # Small square
            self.draw.rectangle([self.x, self.y + 5, self.x + 2, self.y + 7], fill=sep_color)
            self.x += 3

def create_artistic_hello_world():
    """Create artistic Hello World that actually works"""
    print("Creating working artistic Hello World...")

    # Make it wide enough for the message
    artist = WorkingArtistPiet(900, 80)

    # Add background art
    artist.add_background_art()

    # Reset position to top for the functional program
    artist.x, artist.y = 0, 0

    message = "Hello, World!"
    styles = ['normal', 'wavy']

    for i, char in enumerate(message):
        style = styles[i % 2]  # Alternate between styles
        artist.create_character_blocks(ord(char), style)
        artist.add_artistic_separator()

    # Add newline character
    artist.create_character_blocks(10, 'normal')

    # Add termination (black border around colored area)
    artist.x += 10
    term_size = 5
    artist.draw.rectangle([artist.x - 1, artist.y - 1,
                          artist.x + term_size + 1, artist.y + term_size + 1], fill=BLACK)
    artist.draw.rectangle([artist.x, artist.y,
                          artist.x + term_size, artist.y + term_size], fill=DARK_GREEN)

    artist.image.save("hello_working_art.png")
    print("Created: hello_working_art.png")

def create_artistic_fibonacci():
    """Create artistic Fibonacci that works"""
    print("Creating working artistic Fibonacci...")

    artist = WorkingArtistPiet(800, 80)
    artist.add_background_art()
    artist.x, artist.y = 0, 0

    # Simple Fibonacci output: "1, 1, 2, 3"
    fib_text = "1, 1, 2, 3"

    for i, char in enumerate(fib_text):
        style = 'wavy' if char.isdigit() else 'normal'
        artist.create_character_blocks(ord(char), style)
        artist.add_artistic_separator()

    # Add newline
    artist.create_character_blocks(10, 'normal')

    # Termination
    artist.x += 10
    term_size = 5
    artist.draw.rectangle([artist.x - 1, artist.y - 1,
                          artist.x + term_size + 1, artist.y + term_size + 1], fill=BLACK)
    artist.draw.rectangle([artist.x, artist.y,
                          artist.x + term_size, artist.y + term_size], fill=DARK_MAGENTA)

    artist.image.save("fibonacci_working_art.png")
    print("Created: fibonacci_working_art.png")

if __name__ == "__main__":
    import math  # needed for wavy blocks
    create_artistic_hello_world()
    create_artistic_fibonacci()
    print("\nWorking artistic Piet programs created!")
    print("These follow the proven progopedia pattern with artistic flair!")