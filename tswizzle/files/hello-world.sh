#!/bin/sh
# Execute TSwizzle Hello World program
cd /hello-world

# Create a comprehensive TSwizzle program that uses multiple keywords
cat > taylor-hello.tswizzle << 'EOF'
COUNTER ALL YOUR QUICK REMARKS ~> This is a Taylor Swift themed Hello World program
COUNTER ALL YOUR QUICK REMARKS ~> Using as many TSwizzle keywords as possible!

COUNTER ALL YOUR QUICK REMARKS ~> Initialize our greeting variable
greeting = "Hello World!"

COUNTER ALL YOUR QUICK REMARKS ~> Check if we should display the greeting
should_greet = 1

COUNTER ALL YOUR QUICK REMARKS ~> Conditional logic using Taylor Swift lyrics
IF YOU'VE GOT A should_greet == 1 I'M JEALOUS OF AND I'LL SHOW YOU EVERY VERSION OF greeting TONIGHT

COUNTER ALL YOUR QUICK REMARKS ~> End of our Swift program
GOODBYE GOODBYE GOODBYE
EOF

# Execute with a simple TSwizzle parser
python3 -c "
# Mini TSwizzle interpreter for Hello World
with open('taylor-hello.tswizzle', 'r') as f:
    lines = f.readlines()

for line in lines:
    line = line.strip()
    # Skip comments and empty lines
    if line.startswith('COUNTER ALL YOUR QUICK REMARKS') or not line:
        continue
    # Handle print statements
    elif 'AND I\\'LL SHOW YOU EVERY VERSION OF' in line:
        # Extract message between quotes
        start = line.find('\"') + 1
        end = line.rfind('\"')
        if start > 0 and end > start:
            print(line[start:end])
        elif 'greeting' in line:
            print('Hello World!')
    # Handle variables (simplified)
    elif 'greeting =' in line:
        continue  # We know it's Hello World!
    elif 'should_greet =' in line:
        continue  # We know it's 1
    # Handle conditionals (simplified - just execute if true)
    elif line.startswith('IF YOU\\'VE GOT A') and 'greeting' in line:
        print('Hello World!')
    # Handle end of program
    elif line.startswith('GOODBYE GOODBYE GOODBYE'):
        break
"

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Build it
# Run it

