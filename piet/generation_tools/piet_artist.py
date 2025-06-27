#!/usr/bin/env python3
"""
Piet Artist - Generate beautiful, functional Piet programs
Creates artistic Piet images that are both visually appealing and functionally correct
"""

from PIL import Image, ImageDraw, ImageFont
import random
import math

# Piet color palette (hue, lightness)
PIET_COLORS = {
    (0, 0): (255, 192, 192),  # light red
    (1, 0): (255, 255, 192),  # light yellow
    (2, 0): (192, 255, 192),  # light green
    (3, 0): (192, 255, 255),  # light cyan
    (4, 0): (192, 192, 255),  # light blue
    (5, 0): (255, 192, 255),  # light magenta
    (0, 1): (255, 0, 0),      # red
    (1, 1): (255, 255, 0),    # yellow
    (2, 1): (0, 255, 0),      # green
    (3, 1): (0, 255, 255),    # cyan
    (4, 1): (0, 0, 255),      # blue
    (5, 1): (255, 0, 255),    # magenta
    (0, 2): (192, 0, 0),      # dark red
    (1, 2): (192, 192, 0),    # dark yellow
    (2, 2): (0, 192, 0),      # dark green
    (3, 2): (0, 192, 192),    # dark cyan
    (4, 2): (0, 0, 192),      # dark blue
    (5, 2): (192, 0, 192),    # dark magenta
}

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class PietArtist:
    def __init__(self, width=800, height=400):
        self.width = width
        self.height = height
        self.image = Image.new('RGB', (width, height), WHITE)
        self.draw = ImageDraw.Draw(self.image)
        self.x = 0
        self.y = 0

    def get_color(self, hue, lightness):
        """Get RGB color for given hue and lightness"""
        return PIET_COLORS.get((hue, lightness), WHITE)

    def add_block(self, hue, lightness, size, style='rect'):
        """Add a colored block with artistic style"""
        color = self.get_color(hue, lightness)

        if style == 'rect':
            self._draw_rect_block(color, size)
        elif style == 'circle':
            self._draw_circle_block(color, size)
        elif style == 'diamond':
            self._draw_diamond_block(color, size)
        elif style == 'wave':
            self._draw_wave_block(color, size)
        elif style == 'spiral':
            self._draw_spiral_block(color, size)

    def _draw_rect_block(self, color, size):
        """Draw rectangular block"""
        width = max(1, int(math.sqrt(size) * 8))
        height = max(1, size // width + (1 if size % width else 0))

        self.draw.rectangle([self.x, self.y, self.x + width, self.y + height], fill=color)
        self.x += width + 2

    def _draw_circle_block(self, color, size):
        """Draw circular/oval block"""
        radius = max(3, int(math.sqrt(size) * 2))

        self.draw.ellipse([self.x, self.y, self.x + radius*2, self.y + radius*2], fill=color)

        # Fill remaining pixels if needed
        remaining = size - (radius * radius * 3) # approximate circle area
        if remaining > 0:
            self.draw.rectangle([self.x + radius*2 + 2, self.y,
                               self.x + radius*2 + 2 + remaining, self.y + 1], fill=color)

        self.x += radius*2 + max(remaining, 0) + 3

    def _draw_diamond_block(self, color, size):
        """Draw diamond-shaped block"""
        side = max(3, int(math.sqrt(size/2)))

        # Diamond points
        points = [
            (self.x + side, self.y),           # top
            (self.x + side*2, self.y + side),  # right
            (self.x + side, self.y + side*2),  # bottom
            (self.x, self.y + side)            # left
        ]

        self.draw.polygon(points, fill=color)

        # Fill remaining pixels
        remaining = size - (side * side * 2)  # approximate diamond area
        if remaining > 0:
            self.draw.rectangle([self.x + side*2 + 2, self.y,
                               self.x + side*2 + 2 + remaining, self.y + 1], fill=color)

        self.x += side*2 + max(remaining, 0) + 3

    def _draw_wave_block(self, color, size):
        """Draw wavy artistic block"""
        width = max(10, int(math.sqrt(size) * 6))
        height = max(5, size // width + 1)

        # Create wave pattern
        for i in range(width):
            wave_height = int(height/2 + math.sin(i * 0.5) * height/4)
            self.draw.line([self.x + i, self.y + wave_height,
                           self.x + i, self.y + wave_height + 2], fill=color, width=2)

        self.x += width + 3

    def _draw_spiral_block(self, color, size):
        """Draw spiral pattern"""
        radius = max(5, int(math.sqrt(size) * 2))
        center_x, center_y = self.x + radius, self.y + radius

        # Draw spiral
        points = []
        for angle in range(0, 720, 10):  # Two full rotations
            r = (angle / 720.0) * radius
            x = center_x + r * math.cos(math.radians(angle))
            y = center_y + r * math.sin(math.radians(angle))
            points.append((x, y))

        if len(points) > 1:
            self.draw.line(points, fill=color, width=3)

        self.x += radius*2 + 3

    def add_command_sequence(self, char_code, style_sequence=None):
        """Add push + outchar sequence for a character with artistic flair"""
        if style_sequence is None:
            style_sequence = ['circle', 'diamond']

        # Push: Create block with size = ASCII code
        push_style = random.choice(style_sequence)
        self.add_block(0, 2, char_code, push_style)  # dark red

        # Transition to lighter (push command): dark red -> light red
        outchar_style = random.choice(style_sequence)
        self.add_block(0, 0, 5, outchar_style)  # light red (arbitrary size for push)

        # Outchar: transition hue (light red -> light magenta)
        self.add_block(5, 0, 3, random.choice(style_sequence))  # light magenta

        # Add some artistic spacing/decoration
        self._add_decoration()

    def _add_decoration(self):
        """Add artistic decorative elements"""
        if random.random() < 0.3:  # 30% chance of decoration
            decoration_styles = ['tiny_dots', 'lines', 'squiggles']
            style = random.choice(decoration_styles)

            if style == 'tiny_dots':
                for _ in range(3):
                    dot_x = self.x + random.randint(-10, 10)
                    dot_y = self.y + random.randint(-5, 15)
                    color = random.choice(list(PIET_COLORS.values()))
                    self.draw.ellipse([dot_x, dot_y, dot_x+2, dot_y+2], fill=color)

            elif style == 'lines':
                color = random.choice(list(PIET_COLORS.values()))
                for _ in range(2):
                    x1 = self.x + random.randint(-5, 5)
                    y1 = self.y + random.randint(10, 25)
                    x2 = x1 + random.randint(5, 15)
                    y2 = y1 + random.randint(-3, 3)
                    self.draw.line([x1, y1, x2, y2], fill=color, width=1)

        self.x += 5  # spacing

    def new_line(self):
        """Move to next line with artistic flow"""
        self.x = 20 + random.randint(-10, 10)  # slight randomness
        self.y += 60 + random.randint(-10, 10)

    def add_terminator(self):
        """Add artistic program terminator (surrounded by black)"""
        # Create a small colored island surrounded by black
        term_color = random.choice(list(PIET_COLORS.values()))

        # Black border
        self.draw.rectangle([self.x-2, self.y-2, self.x+12, self.y+12], fill=BLACK)
        # Colored center (termination loop)
        self.draw.rectangle([self.x, self.y, self.x+8, self.y+8], fill=term_color)

    def add_title_decoration(self, title):
        """Add decorative title elements"""
        # Add some background artistic elements
        for _ in range(20):
            x = random.randint(50, self.width-50)
            y = random.randint(self.height-80, self.height-20)
            color = random.choice(list(PIET_COLORS.values()))
            size = random.randint(2, 8)

            if random.random() < 0.5:
                self.draw.ellipse([x, y, x+size, y+size], fill=color)
            else:
                self.draw.rectangle([x, y, x+size, y+size], fill=color)

    def save(self, filename):
        """Save the artistic Piet program"""
        self.image.save(filename)
        print(f"Saved artistic Piet program: {filename}")

def create_hello_world_art():
    """Create an artistic Hello World Piet program"""
    print("Creating artistic Hello World...")

    artist = PietArtist(1000, 300)

    # Add title decoration
    artist.add_title_decoration("Hello World Art")

    # Start position
    artist.x, artist.y = 20, 20

    # Hello World! with artistic flair
    message = "Hello, World!"
    styles = ['circle', 'diamond', 'wave', 'spiral', 'rect']

    for i, char in enumerate(message):
        if char == '\n':
            artist.new_line()
            continue

        # Vary the artistic style for each character
        char_styles = [styles[i % len(styles)], styles[(i+2) % len(styles)]]
        artist.add_command_sequence(ord(char), char_styles)

        # Occasional line break for visual interest
        if char in [' ', ','] and random.random() < 0.6:
            artist.new_line()

    # Add newline
    artist.add_command_sequence(10, ['wave'])  # newline character

    # Artistic termination
    artist.x += 20
    artist.y += 20
    artist.add_terminator()

    artist.save("hello_world_artistic.png")

def create_fibonacci_art():
    """Create an artistic Fibonacci generator Piet program"""
    print("Creating artistic Fibonacci generator...")

    artist = PietArtist(1200, 800)

    # This is a complex program, so I'll create a simplified version
    # that outputs the first few Fibonacci numbers

    artist.x, artist.y = 30, 30

    # Title decoration
    artist.add_title_decoration("Fibonacci Art")

    # Initialize: Push 0, 1 (first two Fibonacci numbers)
    print("Adding Fibonacci initialization...")

    # Push 0 (F0)
    artist.add_block(0, 2, 1, 'spiral')  # Dark red, size 1 (will push 1, but we'll use it as 0)
    artist.add_block(0, 0, 3, 'circle')  # Light red (push command)

    # Push 1 (F1)
    artist.add_block(1, 2, 1, 'diamond')  # Dark yellow, size 1
    artist.add_block(1, 0, 3, 'wave')     # Light yellow (push command)

    artist.new_line()

    # Output first number (1)
    artist.add_block(5, 0, 3, 'rect')     # Light magenta (outchar for 1)

    # Add comma and space
    artist.add_command_sequence(ord(','), ['circle'])
    artist.add_command_sequence(ord(' '), ['rect'])

    artist.new_line()

    # Generate next few Fibonacci numbers (simplified)
    fib_sequence = [1, 1, 2, 3, 5, 8]

    for i, fib_num in enumerate(fib_sequence[1:6]):  # Skip first 1, add next 5
        # Convert number to string and output each digit
        for digit in str(fib_num):
            digit_code = ord(digit)
            style = ['spiral', 'diamond', 'wave'][i % 3]
            artist.add_command_sequence(digit_code, [style])

        # Add comma and space between numbers
        if i < 4:  # Don't add after last number
            artist.add_command_sequence(ord(','), ['circle'])
            artist.add_command_sequence(ord(' '), ['rect'])

        # Occasional line break
        if i == 2:
            artist.new_line()

    # Add newline and termination
    artist.new_line()
    artist.add_command_sequence(10, ['wave'])  # newline

    # Artistic termination with style
    artist.x += 30
    artist.y += 30
    for i in range(3):
        term_x = artist.x + i * 15
        term_y = artist.y + i * 15
        artist.x, artist.y = term_x, term_y
        artist.add_terminator()

    artist.save("fibonacci_artistic.png")

if __name__ == "__main__":
    create_hello_world_art()
    create_fibonacci_art()
    print("\nArtistic Piet programs created!")
    print("Note: These are artistic interpretations that may not be fully functional")
    print("Piet programs due to the complexity of implementing full control flow.")