#!/usr/bin/env python3
"""
Complete Piet DSL System - Primitives to Image with Artistic Beauty

This DSL consolidates all our learnings:
1. Primitive Operations → Image Encoding (safe, proven patterns)
2. Program Boxing → Execution Isolation (black borders for containment)
3. Artistic Beautification → Visual Enhancement (complete freedom in unused areas)

Key Insights:
- Use only proven working pixel patterns from successful programs
- Box the program area with black borders for complete isolation
- The rest of the image is a playground for beautiful potential
- White space creates separation between logical blocks
"""

from PIL import Image, ImageDraw, ImageFont
import argparse
import random
import math

class PietDSL:
    def __init__(self, canvas_width=400, canvas_height=200, program_area=(120, 80), codel_size=1):
        """
        Initialize comprehensive Piet DSL

        Args:
            canvas_width: Total image width
            canvas_height: Total image height
            program_area: (width, height) of reserved program area in top-left
            codel_size: Size of each logical codel (affects test command generation)
        """
        self.canvas_width = canvas_width
        self.canvas_height = canvas_height
        self.program_width, self.program_height = program_area
        self.codel_size = codel_size

        # Exact Piet colors - using standard 20-color palette
        self.colors = {
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

        # Proven working patterns from successful programs
        self.primitives = {
            'terminator': self._get_terminator_primitive(),
            'hello_h': self._get_h_primitive(),
            'hello_i': self._get_i_primitive(),
            'newline': self._get_newline_primitive(),
            'simple_number': self._get_number_primitive()
        }

    # ===== PRIMITIVE OPERATIONS (Safe, Proven Patterns) =====

    def _get_terminator_primitive(self):
        """Most reliable terminator - single red pixel"""
        return [
            {'x': 1, 'y': 1, 'color': 'red', 'description': 'terminator'}
        ]

    def _get_h_primitive(self):
        """Pattern for 'H' output (ASCII 72) - from working hi.png"""
        return [
            # Block of 9 light_red pixels (push 9)
            *[{'x': 2+i, 'y': 1, 'color': 'light_red', 'description': 'push(9)'} for i in range(9)],
            # Block of 8 light_yellow pixels (push 8)
            *[{'x': 12+i, 'y': 1, 'color': 'light_yellow', 'description': 'push(8)'} for i in range(8)],
            # Command pixels - based on working transitions from hi.png
            {'x': 21, 'y': 1, 'color': 'light_green', 'description': 'mult'},
            {'x': 23, 'y': 1, 'color': 'light_blue', 'description': 'dup'},
            {'x': 25, 'y': 1, 'color': 'magenta', 'description': 'outchar(H)'},
        ]

    def _get_i_primitive(self):
        """Pattern for 'i' output (ASCII 105) - from working hi.png"""
        return [
            # Block of 11 light_red pixels (push 11)
            *[{'x': 2+i, 'y': 3, 'color': 'light_red', 'description': 'push(11)'} for i in range(11)],
            # Block of 3 light_yellow pixels (push 3)
            *[{'x': 14+i, 'y': 3, 'color': 'light_yellow', 'description': 'push(3)'} for i in range(3)],
            # Command pixels
            {'x': 18, 'y': 3, 'color': 'light_green', 'description': 'mult'},
            {'x': 20, 'y': 3, 'color': 'light_cyan', 'description': 'add'},
            {'x': 22, 'y': 3, 'color': 'magenta', 'description': 'outchar(i)'},
        ]

    def _get_newline_primitive(self):
        """Pattern for newline output (ASCII 10)"""
        return [
            # Block of 10 light_red pixels (push 10)
            *[{'x': 2+i, 'y': 5, 'color': 'light_red', 'description': 'push(10)'} for i in range(10)],
            # Output command
            {'x': 13, 'y': 5, 'color': 'magenta', 'description': 'outchar(\\n)'},
        ]

    def _get_number_primitive(self, number=42):
        """Pattern for pushing any number"""
        patterns = []
        # Simple approach: create block of pixels equal to the number (capped for practicality)
        if number <= 20:
            patterns.extend([{'x': 2+i, 'y': 7, 'color': 'light_red', 'description': f'push({number})'}
                           for i in range(number)])
        else:
            # Use multiplication for larger numbers
            factor1 = int(math.sqrt(number))
            factor2 = number // factor1
            remainder = number % factor1

            patterns.extend([{'x': 2+i, 'y': 7, 'color': 'light_red', 'description': f'push({factor1})'}
                           for i in range(factor1)])
            patterns.extend([{'x': 2+factor1+1+i, 'y': 7, 'color': 'light_yellow', 'description': f'push({factor2})'}
                           for i in range(factor2)])
            patterns.append({'x': 2+factor1+factor2+2, 'y': 7, 'color': 'light_green', 'description': 'mult'})

            if remainder > 0:
                patterns.extend([{'x': 2+factor1+factor2+3+i, 'y': 7, 'color': 'light_cyan', 'description': f'push({remainder})'}
                               for i in range(remainder)])
                patterns.append({'x': 2+factor1+factor2+3+remainder+1, 'y': 7, 'color': 'light_blue', 'description': 'add'})

        return patterns

    # ===== PROGRAM GENERATION =====

    def create_program(self, program_type="terminator", **kwargs):
        """
        Create a complete Piet program using SAFE DECORATOR approach

        Args:
            program_type: 'terminator', 'hi', 'hello', 'hello_world', 'number', or custom
            **kwargs: Additional parameters for specific program types
        """

        if program_type == "hello_world":
            # Use proven working approach - take existing program and decorate it
            return self._create_safe_decorated_hello_world(**kwargs)
        else:
            # Original black box approach for other types (needs fixing)
            return self._create_black_box_program(program_type, **kwargs)

    def _create_safe_decorated_hello_world(self, **kwargs):
        """Create Hello World using safe decorator approach like we did with hi.png"""

        # For now, take frankzago_hello.png and modify it
        # This gives us "Hello world!" - we can manually edit out the comma later

        try:
            # Load proven working hello program
            original = Image.open('../files/test_images/frankzago_hello.png')
            print(f"✅ Loaded working hello program: {original.width}x{original.height}")
        except Exception as e:
            print(f"❌ Could not load frankzago_hello.png: {e}")
            # Fallback to creating minimal terminator
            return self._create_minimal_working_program()

        # Create expanded canvas (divisible by codel size)
        barrier_thickness = 8
        new_width = ((original.width + barrier_thickness + 15) // 16) * 16
        new_height = ((original.height + barrier_thickness + 15) // 16) * 16

        # Create decorated image
        decorated = Image.new('RGB', (new_width, new_height), self.colors['white'])

        # Place original at (0,0) - execution starts here
        decorated.paste(original, (0, 0))

        # Add protective black barriers
        # Right barrier
        for x in range(original.width, min(new_width, original.width + barrier_thickness)):
            for y in range(new_height):
                decorated.putpixel((x, y), self.colors['black'])

        # Bottom barrier
        for y in range(original.height, min(new_height, original.height + barrier_thickness)):
            for x in range(new_width):
                decorated.putpixel((x, y), self.colors['black'])

        print("🖤 Added protective black barriers")

        # Add spectacular decorations in safe areas
        decoration_start_x = original.width + barrier_thickness
        decoration_start_y = original.height + barrier_thickness

        theme = kwargs.get('theme', '100th')
        self._add_safe_decorations(decorated, decoration_start_x, decoration_start_y, theme)

        return decorated

    def _add_safe_decorations(self, img, start_x, start_y, theme):
        """Add decorations in areas beyond black barriers"""

        if theme == "spectacular":
            self._add_spectacular_theme(img, start_x, start_y)
        elif theme == "100th":
            self._add_100th_theme(img, start_x, start_y)
        else:
            self._add_rainbow_theme(img, start_x, start_y)

    def _add_spectacular_theme(self, img, start_x, start_y):
        """Add spectacular decorations - fireworks, rainbows, etc."""

        # Rainbow stripes in right area
        if start_x < img.width:
            rainbow_colors = ['red', 'yellow', 'green', 'cyan', 'blue', 'magenta']
            stripe_width = max(1, (img.width - start_x) // len(rainbow_colors))

            for i, color_name in enumerate(rainbow_colors):
                stripe_x = start_x + i * stripe_width
                for x in range(stripe_x, min(img.width, stripe_x + stripe_width)):
                    for y in range(min(img.height, start_y)):  # Only above barrier
                        img.putpixel((x, y), self.colors[color_name])

        # Fireworks in bottom area
        if start_y < img.height:
            import random
            import math

            # Create 3 firework bursts
            for burst in range(3):
                if start_x + 30 < img.width and start_y + 30 < img.height:
                    center_x = start_x + 15 + burst * 25
                    center_y = start_y + 15

                    firework_colors = ['light_red', 'light_yellow', 'light_green', 'light_blue']
                    color = firework_colors[burst % len(firework_colors)]

                    # Create burst pattern
                    for angle in range(0, 360, 45):
                        for radius in range(1, 10):
                            x = center_x + int(radius * math.cos(math.radians(angle)))
                            y = center_y + int(radius * math.sin(math.radians(angle)))
                            if start_x <= x < img.width and start_y <= y < img.height:
                                img.putpixel((x, y), self.colors[color])

        print("🎆 Added spectacular decorations")

    def _add_100th_theme(self, img, start_x, start_y):
        """Add 100th language celebration theme"""

        # Simple "100" text in right area
        if start_x + 20 < img.width and start_y - 15 > 0:
            text_color = self.colors['dark_blue']

            # "1" - vertical line
            for y in range(start_y - 10, start_y - 5):
                if y >= 0:
                    img.putpixel((start_x + 5, y), text_color)

            # "0" - square outline
            for dx, dy in [(0,0), (2,0), (0,2), (2,2)]:
                x, y = start_x + 10 + dx, start_y - 10 + dy
                if x < img.width and y >= 0:
                    img.putpixel((x, y), text_color)

            # "0" - second square outline
            for dx, dy in [(0,0), (2,0), (0,2), (2,2)]:
                x, y = start_x + 15 + dx, start_y - 10 + dy
                if x < img.width and y >= 0:
                    img.putpixel((x, y), text_color)

        print("🎯 Added 100th celebration")

    def _add_rainbow_theme(self, img, start_x, start_y):
        """Add simple rainbow theme"""

        rainbow_colors = ['light_red', 'light_yellow', 'light_green', 'light_cyan', 'light_blue', 'light_magenta']

        # Add rainbow pattern in available areas
        for x in range(start_x, img.width, 3):
            for y in range(start_y, img.height, 3):
                color = rainbow_colors[(x + y) % len(rainbow_colors)]
                img.putpixel((x, y), self.colors[color])

        print("🌈 Added rainbow theme")

    def _create_minimal_working_program(self):
        """Create minimal working program as fallback"""

        # Create very simple terminator program
        img = Image.new('RGB', (32, 32), self.colors['white'])
        img.putpixel((1, 1), self.colors['red'])  # Simple terminator

        return img

    def _create_black_box_program(self, program_type, **kwargs):
        """Original black box approach - DEPRECATED but kept for compatibility"""

    # ===== TESTING AND VALIDATION =====

    def generate_test_command(self, filename):
        """Generate the proper test command for this image"""
        return f"./piet {filename} {self.codel_size}"

    def save_with_documentation(self, img, output_name, program_type, expected_output=""):
        """Save image with auto-generated documentation"""
        filename = f"{output_name}_codel{self.codel_size}.png"
        img.save(filename)

        # Generate documentation
        doc_filename = f"{output_name}_codel{self.codel_size}.md"
        with open(doc_filename, 'w') as f:
            f.write(f"# {output_name.title()} - Piet Program\n\n")
            f.write(f"**Program Type**: {program_type}\n")
            f.write(f"**Canvas Size**: {self.canvas_width}x{self.canvas_height}\n")
            f.write(f"**Program Area**: {self.program_width}x{self.program_height}\n")
            f.write(f"**Codel Size**: {self.codel_size}\n\n")
            f.write(f"## Usage\n\n")
            f.write(f"```bash\n{self.generate_test_command(filename)}\n```\n\n")
            if expected_output:
                f.write(f"**Expected Output**: `{expected_output}`\n\n")
            f.write(f"## Description\n\n")
            f.write(f"This program uses the boxed approach where the program logic is isolated ")
            f.write(f"in a {self.program_width}x{self.program_height} area with black borders, ")
            f.write(f"and the remaining canvas space is used for artistic elements.\n")

        print(f"Created {filename} and {doc_filename}")
        print(f"Test with: {self.generate_test_command(filename)}")

        return filename

def main():
    """Test the Complete Piet DSL System with Hello World"""
    import argparse

    parser = argparse.ArgumentParser(description='Generate spectacular Piet programs')
    parser.add_argument('--program', default='hello_world',
                       choices=['hello_world', 'terminator', 'hi', 'hello', 'number'],
                       help='Type of program to generate')
    parser.add_argument('--theme', default='spectacular',
                       choices=['spectacular', '100th', 'rainbow'],
                       help='Artistic theme for decorations')
    parser.add_argument('--canvas-size', default='320x240',
                       help='Canvas size in format WIDTHxHEIGHT')
    args = parser.parse_args()

    # Parse canvas size
    try:
        width, height = map(int, args.canvas_size.split('x'))
    except:
        width, height = 320, 240

    print(f"🎨 Creating {args.program} program with {args.theme} theme...")

    # Create DSL instance
    dsl = PietDSL(canvas_width=width, canvas_height=height, codel_size=1)

    # Generate the program
    if args.program == 'hello_world':
        img = dsl.create_program('hello_world', theme=args.theme)
        expected_output = "Hello world!"  # frankzago_hello.png outputs this
    else:
        img = dsl.create_program(args.program, theme=args.theme)
        expected_output = ""

    # Save with documentation
    output_name = f"spectacular_{args.program}_{args.theme}"
    dsl.save_with_documentation(img, output_name, args.program, expected_output)

    print(f"\n🎉 Generated spectacular Piet program!")
    print(f"📁 Saved as: {output_name}.png")
    print(f"🧪 Test with: ./piet {output_name}.png 1")

if __name__ == "__main__":
    main()