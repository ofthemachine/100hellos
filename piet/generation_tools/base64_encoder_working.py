#!/usr/bin/env python3
"""
BASE64 ENCODER - Using Successful Strategy

Now that we have the working "Hello World!" technique,
let's create a base64 encoder that can embed content in PNG files.
"""

from PIL import Image
import subprocess
import base64

def create_base64_hello_world():
    """Create a Piet program that outputs base64 encoded 'Hello World!' source"""

    print("🔐 BASE64 ENCODER - WORKING VERSION")
    print("Creating program that outputs base64 content")
    print("="*60)

    # Example: encode a simple Python hello world
    source_code = 'print("Hello World!")'
    b64_encoded = base64.b64encode(source_code.encode()).decode()

    print(f"📝 Original: {source_code}")
    print(f"🔐 Base64:   {b64_encoded}")
    print(f"📊 Length:   {len(b64_encoded)} characters")

    # Get ASCII values for base64 string
    ascii_values = [ord(c) for c in b64_encoded]
    print(f"📈 ASCII range: {min(ascii_values)} to {max(ascii_values)}")

    # Use our successful frankzago modification technique
    # But create blocks for base64 characters instead

    img = Image.new('RGB', (50, 40), (255, 255, 255))  # larger image

    # Standard Piet colors
    red = (255, 0, 0)
    dark_red = (192, 0, 0)

    x, y = 0, 0

    print(f"\n🔨 Creating blocks for each character:")

    for i, char in enumerate(b64_encoded):
        ascii_val = ord(char)
        print(f"  {i+1}: '{char}' = {ascii_val} pixels")

        # Create block of red pixels (size = ascii_val)
        placed = 0
        start_x, start_y = x, y

        for pixel in range(ascii_val):
            if x >= 50:  # wrap to next line
                x = 0
                y += 1
                if y >= 40:
                    print("❌ Out of space!")
                    return False

            img.putpixel((x, y), red)
            x += 1
            placed += 1

        # Add outchar pixel
        if x >= 50:
            x = 0
            y += 1
        img.putpixel((x, y), dark_red)
        x += 1

        # Small gap
        x += 1
        if x >= 50:
            x = 0
            y += 1

    # Add termination
    img.putpixel((x, y), (0, 0, 0))  # black

    # Save
    filename = 'BASE64_HELLO_WORLD_WORKING.png'
    img.save(filename)
    print(f"\n💾 Saved: {filename}")

    return filename, b64_encoded

def test_base64_program(filename, expected_b64):
    """Test the base64 program"""

    print(f"\n🧪 TESTING BASE64 PROGRAM")
    print("="*50)

    try:
        result = subprocess.run(['../files/piet', filename, '1'],
                              capture_output=True, text=True, timeout=15)

        output = result.stdout.strip()
        print(f"📋 Output length: {len(output)}")

        if len(output) > 100:
            print(f"📋 First 50 chars: '{output[:50]}...'")
            print(f"📋 Last 50 chars:  '...{output[-50:]}'")
        else:
            print(f"📋 Full output: '{output}'")

        if output == expected_b64:
            print("🎉 PERFECT! Base64 encoding successful!")

            # Try to decode it
            try:
                decoded = base64.b64decode(output).decode()
                print(f"🔓 Decoded: '{decoded}'")
                return True
            except Exception as e:
                print(f"🔧 Decode error: {e}")
                return False
        else:
            print(f"🔧 Expected: '{expected_b64}'")
            print(f"🔧 Got:      '{output[:100]}...' (showing first 100)")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Timeout - program hangs")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def create_minimal_test():
    """Create a minimal test with just a few base64 characters"""

    print(f"\n🧪 CREATING MINIMAL BASE64 TEST")
    print("="*50)

    # Encode just "Hi" to get a short base64 string
    source = "Hi"
    b64 = base64.b64encode(source.encode()).decode()
    print(f"📝 '{source}' → '{b64}' ({len(b64)} chars)")

    # Create minimal program
    img = Image.new('RGB', (30, 20), (255, 255, 255))
    x, y = 0, 0

    for char in b64:
        ascii_val = ord(char)
        print(f"  '{char}' = {ascii_val} pixels")

        # Create block
        for pixel in range(ascii_val):
            if x >= 30:
                x = 0
                y += 1
            img.putpixel((x, y), (255, 0, 0))  # red
            x += 1

        # outchar
        if x >= 30:
            x = 0
            y += 1
        img.putpixel((x, y), (192, 0, 0))  # dark_red
        x += 1

    # terminate
    img.putpixel((x, y), (0, 0, 0))  # black

    filename = 'MINIMAL_BASE64_TEST.png'
    img.save(filename)
    print(f"💾 Saved: {filename}")

    return filename, b64

if __name__ == "__main__":
    print("🚀 BASE64 ENCODER WITH SUCCESSFUL TECHNIQUE")
    print("Embedding content in PNG files")
    print()

    # Try minimal test first
    min_file, min_b64 = create_minimal_test()
    print(f"\n🧪 Testing minimal version...")

    min_result = test_base64_program(min_file, min_b64)

    if min_result:
        print("\n🎉 MINIMAL SUCCESS! Now trying full version...")

        # Try full version
        full_file, full_b64 = create_base64_hello_world()
        if full_file:
            full_result = test_base64_program(full_file, full_b64)

            if full_result:
                print("\n" + "="*60)
                print("🎉 BASE64 ENCODING SUCCESS!")
                print("✅ Source code embedded in PNG!")
                print("✅ Executable program outputs base64!")
                print("✅ Digital artifact complete!")
                print("🌟 BONUS CHALLENGE ACHIEVED!")
            else:
                print("\n🔧 Full version needs refinement...")
        else:
            print("❌ Could not create full version")
    else:
        print("\n🔧 Even minimal version needs work...")
        print("💡 The pixel connectivity is still challenging!")