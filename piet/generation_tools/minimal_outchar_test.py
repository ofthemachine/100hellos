#!/usr/bin/env python3
"""
🎯 MINIMAL OUTCHAR TEST 🎯

Test every possible color transition to find which one produces outchar!
Create tiny programs to isolate the exact transition needed.
"""

from PIL import Image
import subprocess
import sys

COLORS = {
    'red': (255, 0, 0),
    'dark_red': (192, 0, 0),
    'yellow': (255, 255, 0), 
    'dark_yellow': (192, 192, 0),
    'green': (0, 255, 0),
    'dark_green': (0, 192, 0),
    'cyan': (0, 255, 255),
    'dark_cyan': (0, 192, 192),
    'blue': (0, 0, 255),
    'dark_blue': (0, 0, 192),
    'magenta': (255, 0, 255),
    'dark_magenta': (192, 0, 192),
    'white': (255, 255, 255),
    'black': (0, 0, 0)
}

def create_minimal_transition_test(color1, color2, push_value=72):
    """Create minimal test: push value → transition → terminate"""
    
    img = Image.new('RGB', (100, 20), COLORS['white'])
    
    # Block 1: Push value (size = push_value)
    for x in range(push_value):
        if x < 95:
            img.putpixel((x, 5), COLORS[color1])
    
    # Block 2: Transition pixel (should trigger operation)
    img.putpixel((push_value, 5), COLORS[color2])
    
    # Block 3: Terminate
    img.putpixel((push_value + 1, 5), COLORS['black'])
    
    return img

def test_transition(color1, color2, expected_operation):
    """Test a specific color transition"""
    
    print(f"🧪 Testing {color1} → {color2} (expecting {expected_operation})")
    
    img = create_minimal_transition_test(color1, color2, 72)  # ASCII 'H'
    
    filename = f"test_{color1}_to_{color2}.png"
    img.save(filename)
    
    try:
        result = subprocess.run(['../files/piet', '--debug', filename, '1'],
                              capture_output=True, text=True, timeout=5)
        
        debug_output = result.stderr
        program_output = result.stdout.strip()
        
        # Check what operation was executed
        if "outchar" in debug_output:
            print(f"  ✅ FOUND OUTCHAR! Output: '{program_output}'")
            if program_output and ord(program_output[0]) == 72:
                print(f"  🎉 PERFECT! Output 'H' (ASCII 72)")
                return True
        elif expected_operation in debug_output:
            print(f"  ✅ Found {expected_operation}")
        else:
            operations = []
            for line in debug_output.split('\n'):
                if "Executing command:" in line:
                    op = line.split("Executing command:")[1].strip().split()[0]
                    operations.append(op)
            print(f"  📋 Operations: {operations}")
        
        return False
        
    except subprocess.TimeoutExpired:
        print(f"  ❌ Timeout")
        return False
    except Exception as e:
        print(f"  ❌ Error: {e}")
        return False

def find_outchar_transition():
    """Test common transitions to find outchar"""
    
    print("🔍 SEARCHING FOR OUTCHAR TRANSITION 🔍")
    print("=" * 50)
    
    # Test the most promising transitions based on Piet spec
    test_cases = [
        ('red', 'yellow', 'outchar'),
        ('red', 'green', 'outchar'),
        ('red', 'cyan', 'outchar'),
        ('yellow', 'red', 'outchar'),
        ('yellow', 'green', 'outchar'),
        ('green', 'red', 'outchar'),
        ('green', 'yellow', 'outchar'),
        ('cyan', 'red', 'outchar'),
        ('blue', 'red', 'outchar'),
        ('magenta', 'red', 'outchar'),
    ]
    
    success_count = 0
    
    for color1, color2, expected in test_cases:
        if test_transition(color1, color2, expected):
            success_count += 1
            print(f"🎯 WINNER: {color1} → {color2} produces outchar!")
            
            # Test with different ASCII values
            print("🔬 Testing with different values:")
            for test_ascii, test_char in [(65, 'A'), (99, 'c'), (33, '!')]:
                img = create_minimal_transition_test(color1, color2, test_ascii)
                test_file = f"verify_{test_char}_{color1}_to_{color2}.png"
                img.save(test_file)
                
                try:
                    result = subprocess.run(['../files/piet', test_file, '1'],
                                          capture_output=True, text=True, timeout=3)
                    output = result.stdout.strip()
                    if output and ord(output[0]) == test_ascii:
                        print(f"  ✅ '{test_char}' (ASCII {test_ascii}) → '{output[0]}'")
                    else:
                        print(f"  ❌ '{test_char}' (ASCII {test_ascii}) → '{output}'")
                except:
                    print(f"  ❌ '{test_char}' failed")
            
            break
        print()
    
    if success_count == 0:
        print("❌ No working outchar transition found!")
        print("🔧 Need to analyze working programs more carefully...")
    
    return success_count > 0

if __name__ == "__main__":
    success = find_outchar_transition()
    
    if success:
        print("\n�� OUTCHAR TRANSITION DISCOVERED! 🏆")
        print("✅ Ready to implement full base64 encoding!")
    else:
        print("\n🔧 Continue analyzing working program patterns...")

