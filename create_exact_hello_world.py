#!/usr/bin/env python3
"""
EXACT HELLO WORLD! CREATOR

The viral breakthrough: Create a working Piet program that outputs exactly "Hello World!"

Strategy:
1. Take the working frankzago_hello.png (outputs "Hello world!")
2. Understand it outputs: H-e-l-l-o-space-w-o-r-l-d-!
3. Change the 'w' (ASCII 119) to 'W' (ASCII 87)
4. This means reducing one block by 32 pixels (119-87=32)

This will be VIRAL because:
- Beautiful visual art that IS a program
- Contains and executes source code
- Social media gold: "This image is actually a program!"
"""

from PIL import Image
import os

def analyze_working_program():
    """Analyze the working program to understand its structure"""

    print("🔍 ANALYZING WORKING PROGRAM")
    print("=" * 50)

    # Load working program
    working_img = Image.open('../files/test_images/frankzago_hello.png')
    width, height = working_img.size

    print(f"Dimensions: {width}x{height}")

    # Test current output
    print("\nCurrent output:")
    os.system("cd .. && timeout 3s files/piet files/test_images/frankzago_hello.png 1")

    return working_img

def create_hello_world_exact():
    """Create Hello World! with exact capitalization"""

    print("\n🎯 CREATING EXACT 'Hello World!' PROGRAM")
    print("=" * 50)

    # For now, let's copy the working program and test our modification approach
    working_img = Image.open('../files/test_images/frankzago_hello.png')

    # Create a copy to work with
    hello_world_img = working_img.copy()

    # The challenge: We need to modify the program to change 'w' to 'W'
    # This requires understanding the exact pixel blocks and their meanings

    # For now, save as a starting point
    hello_world_img.save('EXACT_HELLO_WORLD.png')

    print("Created EXACT_HELLO_WORLD.png")
    print("Testing output:")

    # Test the program
    os.system("timeout 3s ../files/piet EXACT_HELLO_WORLD.png 1")

def create_base64_version():
    """Create the viral base64 version that contains source code"""

    print("\n🌟 CREATING VIRAL BASE64 VERSION")
    print("=" * 50)

    import base64

    # The source code we want to embed
    source_code = 'print("Hello World!")'
    base64_encoded = base64.b64encode(source_code.encode()).decode()

    print(f"Source code: {source_code}")
    print(f"Base64 encoded: {base64_encoded}")
    print(f"Length: {len(base64_encoded)} characters")

    # This will be the viral breakthrough:
    # 1. Beautiful Piet image (visual art)
    # 2. Contains Python source code (data)
    # 3. When executed, outputs the base64 (functional)
    # 4. Decode the output to get the original source code
    # 5. Run that source code to get "Hello World!"

    print("\n🚀 VIRAL POTENTIAL:")
    print("Share on social media: 'This beautiful image IS a Python program!'")
    print("People download it, run it, get base64 output")
    print("They decode it, discover the source code")
    print("They run the source code, get Hello World!")
    print("Mind = blown! 🤯")

if __name__ == "__main__":
    print("🎉 VIRAL HELLO WORLD! CREATOR 🎉")
    print("Creating the image that will break the internet!")
    print()

    # Step 1: Analyze what works
    working_img = analyze_working_program()

    # Step 2: Create exact Hello World!
    create_hello_world_exact()

    # Step 3: Plan the viral base64 version
    create_base64_version()

    print("\n" + "=" * 50)
    print("🎯 MISSION: Create working 'Hello World!' image")
    print("🌟 VISION: Viral breakthrough combining art + code + execution")
    print("🚀 POTENTIAL: Social media phenomenon")