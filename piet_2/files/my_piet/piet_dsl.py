#!/usr/bin/env python3

from PIL import Image
from dataclasses import dataclass
from typing import List, Tuple, Optional
import math

# Piet colors
COLORS = {
    0: (255, 192, 192),  # light red
    1: (255, 255, 192),  # light yellow
    2: (192, 255, 192),  # light green
    3: (192, 255, 255),  # light cyan
    4: (192, 192, 255),  # light blue
    5: (255, 192, 255),  # light magenta
    6: (255, 0, 0),      # red
    7: (255, 255, 0),    # yellow
    8: (0, 255, 0),      # green
    9: (0, 255, 255),    # cyan
    10: (0, 0, 255),     # blue
    11: (255, 0, 255),   # magenta
    12: (192, 0, 0),     # dark red
    13: (192, 192, 0),   # dark yellow
    14: (0, 192, 0),     # dark green
    15: (0, 192, 192),   # dark cyan
    16: (0, 0, 192),     # dark blue
    17: (192, 0, 192),   # dark magenta
    18: (255, 255, 255), # white
    19: (0, 0, 0),       # black
}

COLOR_NAMES = [
    "light_red", "light_yellow", "light_green", "light_cyan", "light_blue", "light_magenta",
    "red", "yellow", "green", "cyan", "blue", "magenta",
    "dark_red", "dark_yellow", "dark_green", "dark_cyan", "dark_blue", "dark_magenta",
    "white", "black"
]

# Command lookup table: [hue_change][lightness_change] = command
COMMANDS = [
    ["noop", "push", "pop"],
    ["add", "sub", "mult"],
    ["div", "mod", "not"],
    ["greater", "pointer", "switch"],
    ["dup", "roll", "innumber"],
    ["inchar", "outnumber", "outchar"],
]

@dataclass
class PietCommand:
    """A high-level Piet command"""
    command: str
    value: Optional[int] = None  # For push commands

@dataclass
class ColorTransition:
    """A color transition that creates a specific command"""
    from_color: int
    to_color: int
    command: str
    block_size: int

class PietDSL:
    """DSL for creating Piet programs"""

    def __init__(self):
        self.commands: List[PietCommand] = []

    def push(self, value: int):
        """Push a value onto the stack"""
        self.commands.append(PietCommand("push", value))
        return self

    def outchar(self):
        """Output character from stack"""
        self.commands.append(PietCommand("outchar"))
        return self

    def outnumber(self):
        """Output number from stack"""
        self.commands.append(PietCommand("outnumber"))
        return self

    def add(self):
        """Add top two stack values"""
        self.commands.append(PietCommand("add"))
        return self

    def dup(self):
        """Duplicate top stack value"""
        self.commands.append(PietCommand("dup"))
        return self

    def hello_world(self):
        """Add commands for Hello World!"""
        text = "Hello World!"
        for char in text:
            self.push(ord(char)).outchar()
        return self

class PietTranspiler:
    """Transpiles DSL to Piet image"""

    def __init__(self, width: int = 200, height: int = 100):
        self.width = width
        self.height = height
        self.grid = [[18 for _ in range(width)] for _ in range(height)]  # Start with white
        self.program_area = {
            'start_x': 10,
            'start_y': 30,
            'end_x': width - 10,
            'end_y': height - 10
        }

    def find_color_transition(self, command: str, block_size: int) -> ColorTransition:
        """Find colors that create the desired command"""
        # Look up command in table
        for hue_change in range(6):
            for light_change in range(3):
                if COMMANDS[hue_change][light_change] == command:
                    # Find suitable colors with this hue/lightness change
                    # For simplicity, use common patterns
                    if command == "push":
                        return ColorTransition(1, 7, command, block_size)  # light_yellow -> yellow
                    elif command == "outchar":
                        return ColorTransition(7, 11, command, 1)  # yellow -> magenta
                    elif command == "add":
                        return ColorTransition(1, 6, command, 1)   # light_yellow -> red
                    elif command == "dup":
                        return ColorTransition(1, 12, command, 1)  # light_yellow -> dark_red

        # Default fallback
        return ColorTransition(1, 7, "noop", 1)

    def place_block(self, x: int, y: int, color: int, size: int) -> Tuple[int, int]:
        """Place a block of given color and size, return next position"""
        placed = 0
        current_x, current_y = x, y

        # Place blocks in a rectangular pattern
        block_width = min(size, self.program_area['end_x'] - x)
        block_height = max(1, size // block_width)

        for row in range(block_height):
            for col in range(block_width):
                if (current_x + col < self.program_area['end_x'] and
                    current_y + row < self.program_area['end_y'] and
                    placed < size):
                    self.grid[current_y + row][current_x + col] = color
                    placed += 1
                if placed >= size:
                    break
            if placed >= size:
                break

        # Return next position
        next_x = current_x + block_width + 1
        next_y = current_y

        # If we're getting too wide, move to next row
        if next_x > self.program_area['end_x'] - 20:
            next_x = self.program_area['start_x']
            next_y = current_y + block_height + 2

        return next_x, next_y

    def transpile(self, dsl: PietDSL) -> 'PietTranspiler':
        """Convert DSL commands to Piet image"""
        current_x = self.program_area['start_x']
        current_y = self.program_area['start_y']
        current_color = 18  # Start with white

        for cmd in dsl.commands:
            if cmd.command == "push":
                # Create push block
                transition = self.find_color_transition("push", cmd.value)
                current_x, current_y = self.place_block(current_x, current_y,
                                                       transition.from_color, cmd.value)
                current_color = transition.from_color

            elif cmd.command in ["outchar", "outnumber", "add", "dup"]:
                # Create command block
                transition = self.find_color_transition(cmd.command, 1)
                current_x, current_y = self.place_block(current_x, current_y,
                                                       transition.to_color, 1)
                current_color = transition.to_color

        return self

    def add_artistic_decoration(self, theme: str = "100th_language"):
        """Add artistic elements outside the program area"""
        if theme == "100th_language":
            self._add_100th_decoration()
        elif theme == "celebration":
            self._add_celebration_decoration()

    def _add_100th_decoration(self):
        """Add '100' decoration and celebratory elements"""
        # Draw "100" at the top
        # "1"
        for y in range(5, 20):
            self.grid[y][50] = 6  # red
        for x in range(48, 53):
            self.grid[5][x] = 6

        # First "0"
        for y in range(5, 20):
            self.grid[y][60] = 10  # blue
            self.grid[y][70] = 10
        for x in range(60, 71):
            self.grid[5][x] = 10
            self.grid[19][x] = 10

        # Second "0"
        for y in range(5, 20):
            self.grid[y][80] = 8   # green
            self.grid[y][90] = 8
        for x in range(80, 91):
            self.grid[5][x] = 8
            self.grid[19][x] = 8

        # Decorative border
        for x in range(self.width):
            self.grid[0][x] = 11   # magenta
            self.grid[self.height-1][x] = 11
        for y in range(self.height):
            self.grid[y][0] = 11
            self.grid[y][self.width-1] = 11

        # Stars between decoration and program
        for i in range(0, self.width, 15):
            for j in [22, 24, 26]:
                if i < self.width and j < self.height:
                    self.grid[j][i] = 7  # yellow stars

    def _add_celebration_decoration(self):
        """Add celebration-themed decoration"""
        # Rainbow border
        colors = [6, 7, 8, 9, 10, 11]  # Red through magenta
        for i, x in enumerate(range(0, self.width, 2)):
            if x < self.width:
                color = colors[i % len(colors)]
                self.grid[0][x] = color
                self.grid[self.height-1][x] = color

    def to_image(self) -> Image.Image:
        """Convert grid to PIL Image"""
        img = Image.new('RGB', (self.width, self.height))

        for y in range(self.height):
            for x in range(self.width):
                color = COLORS[self.grid[y][x]]
                img.putpixel((x, y), color)

        return img

def create_hello_world_100th():
    """Create a Hello World program for the 100th language"""
    dsl = PietDSL()
    dsl.hello_world()

    transpiler = PietTranspiler(width=250, height=100)
    transpiler.transpile(dsl)
    transpiler.add_artistic_decoration("100th_language")

    return transpiler.to_image()

def main():
    print("Creating Hello World with Piet DSL transpiler...")

    # Create the image
    img = create_hello_world_100th()

    # Save it
    img.save("dsl_100th_hello.png")
    print("Created dsl_100th_hello.png")

    # Create larger version for visibility
    img_large = img.resize((img.width * 3, img.height * 3), Image.NEAREST)
    img_large.save("dsl_100th_hello_large.png")
    print("Created dsl_100th_hello_large.png for visibility")

    # Also create a simple example to test the DSL
    simple_dsl = PietDSL()
    simple_dsl.push(72).outchar().push(105).outchar()  # "Hi"

    simple_transpiler = PietTranspiler(width=200, height=50)
    simple_transpiler.transpile(simple_dsl)
    simple_img = simple_transpiler.to_image()
    simple_img.save("dsl_simple_test.png")
    print("Created dsl_simple_test.png for testing")

if __name__ == "__main__":
    main()