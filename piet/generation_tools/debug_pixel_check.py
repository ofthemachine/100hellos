#!/usr/bin/env python3
"""Debug tool to check pixel values in generated images"""

from PIL import Image
import sys

def check_program_pixels(image_path):
    """Check key pixels in the program"""
    
    img = Image.open(image_path)
    width, height = img.size
    
    print(f"🔍 Analyzing: {image_path} ({width}x{height})")
    print("=" * 50)
    
    # Check starting position and immediate area
    print("📍 Starting area (0,0) to (5,5):")
    for y in range(min(6, height)):
        row = ""
        for x in range(min(6, width)):
            pixel = img.getpixel((x, y))
            if pixel == (0, 0, 0):
                row += "B"  # Black
            elif pixel == (255, 255, 255):
                row += "."  # White
            elif pixel == (255, 0, 0):
                row += "R"  # Red
            elif pixel == (255, 255, 0):
                row += "Y"  # Yellow
            else:
                row += "?"  # Other
        print(f"  {y}: {row}")
    
    print()
    print("🎯 Key positions:")
    print(f"  (0,0): {img.getpixel((0,0))} {'← START POSITION' if img.getpixel((0,0)) != (0,0,0) else '← BLACK = IMMEDIATE TERMINATION!'}")
    print(f"  (1,0): {img.getpixel((1,0))}")
    print(f"  (0,1): {img.getpixel((0,1))}")
    print(f"  (1,1): {img.getpixel((1,1))}")
    
    # Find first non-black, non-white pixel
    print()
    print("🔍 Searching for first program block:")
    for y in range(min(10, height)):
        for x in range(min(50, width)):
            pixel = img.getpixel((x, y))
            if pixel != (0, 0, 0) and pixel != (255, 255, 255):
                print(f"  First colored pixel: ({x},{y}) = {pixel}")
                return
    
    print("  ❌ No colored pixels found in initial area!")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        check_program_pixels(sys.argv[1])
    else:
        print("Usage: python3 debug_pixel_check.py <image.png>")

