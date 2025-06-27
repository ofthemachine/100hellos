#!/usr/bin/env python3
"""
Piet Masterpiece Generator
Creates visually stunning Piet artwork that's also functional
"""

from PIL import Image, ImageDraw, ImageFont
import math
import random

# Exact Piet colors
PIET_COLORS = {
    'light_red': (255, 192, 192),
    'light_yellow': (255, 255, 192),
    'light_green': (192, 255, 192),
    'light_cyan': (192, 255, 255),
    'light_blue': (192, 192, 255),
    'light_magenta': (255, 192, 255),
    'red': (255, 0, 0),
    'yellow': (255, 255, 0),
    'green': (0, 255, 0),
    'cyan': (0, 255, 255),
    'blue': (0, 0, 255),
    'magenta': (255, 0, 255),
    'dark_red': (192, 0, 0),
    'dark_yellow': (192, 192, 0),
    'dark_green': (0, 192, 0),
    'dark_cyan': (0, 192, 192),
    'dark_blue': (0, 0, 192),
    'dark_magenta': (192, 0, 192),
}

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

class PietMasterpiece:
    def __init__(self, width=400, height=300):
        self.width = width
        self.height = height
        self.image = Image.new('RGB', (width, height), WHITE)
        self.draw = ImageDraw.Draw(self.image)

    def create_geometric_background(self):
        """Create beautiful geometric background patterns"""

        # Create radiating circles pattern
        center_x, center_y = self.width // 2, self.height // 2

        for radius in range(20, min(self.width, self.height) // 2, 30):
            # Alternate between light colors for background
            color_names = ['light_cyan', 'light_magenta', 'light_yellow', 'light_green']
            color = PIET_COLORS[color_names[radius // 30 % len(color_names)]]

            # Draw circle outline
            self.draw.ellipse([center_x - radius, center_y - radius,
                             center_x + radius, center_y + radius],
                            outline=color, width=2)

        # Add geometric patterns in corners
        self._add_corner_patterns()

        # Add flowing wave patterns
        self._add_wave_patterns()

    def _add_corner_patterns(self):
        """Add beautiful corner decorations"""
        corner_colors = ['dark_blue', 'dark_red', 'dark_green', 'dark_magenta']

        for i, color_name in enumerate(corner_colors):
            color = PIET_COLORS[color_name]

            # Calculate corner position
            corner_x = 20 if i % 2 == 0 else self.width - 40
            corner_y = 20 if i < 2 else self.height - 40

            # Create mandala-like pattern in corner
            for angle in range(0, 360, 30):
                x = corner_x + 15 * math.cos(math.radians(angle))
                y = corner_y + 15 * math.sin(math.radians(angle))

                self.draw.ellipse([x-2, y-2, x+2, y+2], fill=color)

    def _add_wave_patterns(self):
        """Add flowing wave patterns"""
        wave_colors = ['light_blue', 'light_green', 'light_magenta']

        for i, color_name in enumerate(wave_colors):
            color = PIET_COLORS[color_name]

            # Create horizontal waves
            y_base = 80 + i * 60
            for x in range(0, self.width, 3):
                y = y_base + 20 * math.sin(x * 0.02 + i * 2)
                if 0 <= y < self.height:
                    self.draw.point((x, int(y)), fill=color)

    def embed_functional_program(self):
        """Embed the working progopedia program artistically"""

        # Load the working program
        try:
            working_img = Image.open('progopedia-basic.png')
            prog_width, prog_height = working_img.size

            # Calculate position to center the program
            embed_x = (self.width - prog_width) // 2
            embed_y = (self.height - prog_height) // 2

            # Create artistic frame around the program
            frame_color = PIET_COLORS['dark_red']
            frame_size = 5

            # Draw ornate frame
            for thickness in range(frame_size):
                frame_left = embed_x - frame_size + thickness
                frame_top = embed_y - frame_size + thickness
                frame_right = embed_x + prog_width + frame_size - thickness
                frame_bottom = embed_y + prog_height + frame_size - thickness

                # Gradient effect on frame
                frame_intensity = 255 - (thickness * 30)
                current_frame_color = (
                    min(255, frame_color[0] + thickness * 10),
                    max(0, frame_color[1] - thickness * 5),
                    max(0, frame_color[2] - thickness * 5)
                )

                self.draw.rectangle([frame_left, frame_top, frame_right, frame_bottom],
                                 outline=current_frame_color, width=1)

            # Embed the working program
            self.image.paste(working_img, (embed_x, embed_y))

            # Add artistic highlights around the program
            self._add_program_highlights(embed_x, embed_y, prog_width, prog_height)

            return True

        except FileNotFoundError:
            print("Warning: progopedia-basic.png not found, creating standalone art")
            return False

    def _add_program_highlights(self, x, y, width, height):
        """Add sparkling highlights around the embedded program"""
        highlight_colors = ['yellow', 'cyan', 'magenta']

        # Add sparkles around the program
        for _ in range(30):
            # Random position around the program
            spark_x = x + random.randint(-20, width + 20)
            spark_y = y + random.randint(-20, height + 20)

            # Make sure sparkle doesn't overlap program
            if not (x <= spark_x <= x + width and y <= spark_y <= y + height):
                color = PIET_COLORS[random.choice(highlight_colors)]

                # Create star-like sparkle
                for angle in range(0, 360, 45):
                    dx = 3 * math.cos(math.radians(angle))
                    dy = 3 * math.sin(math.radians(angle))

                    end_x = spark_x + dx
                    end_y = spark_y + dy

                    if 0 <= end_x < self.width and 0 <= end_y < self.height:
                        self.draw.line([spark_x, spark_y, end_x, end_y], fill=color, width=1)

    def add_artistic_title(self):
        """Add beautiful title to the artwork"""
        title = "PIET MASTERPIECE"
        subtitle = "Art as Code"

        # Title in top area
        title_y = 15
        title_x = (self.width - len(title) * 8) // 2

        # Create title with artistic effect
        title_color = PIET_COLORS['dark_blue']
        shadow_color = PIET_COLORS['light_blue']

        # Shadow effect
        try:
            # Try to use a font if available, otherwise use default
            font = ImageFont.load_default()

            # Draw shadow
            self.draw.text((title_x + 1, title_y + 1), title, fill=shadow_color, font=font)
            # Draw main text
            self.draw.text((title_x, title_y), title, fill=title_color, font=font)

            # Subtitle
            subtitle_x = (self.width - len(subtitle) * 6) // 2
            self.draw.text((subtitle_x, title_y + 20), subtitle, fill=PIET_COLORS['dark_magenta'], font=font)

        except:
            # Fallback to basic text
            self.draw.text((title_x, title_y), title, fill=title_color)
            subtitle_x = (self.width - len(subtitle) * 6) // 2
            self.draw.text((subtitle_x, title_y + 15), subtitle, fill=PIET_COLORS['dark_magenta'])

    def save_masterpiece(self, filename):
        """Save the artistic masterpiece"""
        self.image.save(filename)
        print(f"🎨 Created Piet masterpiece: {filename}")

def create_hello_world_masterpiece():
    """Create the ultimate Hello World masterpiece"""
    print("🎨 Creating Piet Hello World Masterpiece...")

    masterpiece = PietMasterpiece(500, 350)

    # Build the masterpiece layer by layer
    print("  🌟 Adding geometric background...")
    masterpiece.create_geometric_background()

    print("  ✨ Adding artistic title...")
    masterpiece.add_artistic_title()

    print("  💎 Embedding functional program...")
    success = masterpiece.embed_functional_program()

    if success:
        print("  🎆 Functional Hello World embedded successfully!")
    else:
        print("  ⚠️  Created standalone artwork")

    masterpiece.save_masterpiece("hello_world_masterpiece.png")

def create_fibonacci_artwork():
    """Create a pure artistic Fibonacci representation"""
    print("🔢 Creating Fibonacci Art...")

    # Create Fibonacci spiral artwork
    img = Image.new('RGB', (400, 400), WHITE)
    draw = ImageDraw.Draw(img)

    # Fibonacci numbers for spiral
    fib = [1, 1, 2, 3, 5, 8, 13, 21, 34]

    # Create Fibonacci spiral with Piet colors
    colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta', 'dark_red', 'dark_green', 'dark_blue']

    center_x, center_y = 200, 200
    angle = 0
    radius = 10

    for i, num in enumerate(fib):
        color = PIET_COLORS[colors[i % len(colors)]]

        # Calculate position on spiral
        x = center_x + radius * math.cos(angle)
        y = center_y + radius * math.sin(angle)

        # Draw Fibonacci square
        size = num * 3
        draw.rectangle([x, y, x + size, y + size], fill=color, outline=BLACK)

        # Add number in center of square
        text_x, text_y = x + size//2, y + size//2
        draw.text((text_x, text_y), str(num), fill=WHITE)

        # Update for next iteration
        angle += math.pi / 2  # 90 degrees
        radius += num * 2

    # Add title
    draw.text((150, 20), "FIBONACCI SPIRAL", fill=PIET_COLORS['dark_blue'])
    draw.text((160, 35), "Mathematical Art", fill=PIET_COLORS['dark_magenta'])

    img.save("fibonacci_spiral_art.png")
    print("🌀 Created Fibonacci spiral artwork: fibonacci_spiral_art.png")

if __name__ == "__main__":
    print("🎨✨ Creating Piet Artistic Masterpieces ✨🎨")
    print("=" * 50)

    create_hello_world_masterpiece()
    create_fibonacci_artwork()

    print("\n🌟 Masterpieces Complete! 🌟")
    print("You now have:")
    print("  🎨 hello_world_masterpiece.png - Functional art that outputs 'Hello, World!'")
    print("  🔢 fibonacci_spiral_art.png - Beautiful Fibonacci spiral artwork")
    print("\nThese showcase Piet as both functional programming AND visual art!")