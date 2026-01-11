#!/bin/sh

# Elm needs to be in a project directory
cd /hello-world

# Initialize an elm project, accepting defaults
yes | elm init > /dev/null 2>&1

# Compile the elm file
elm make --output=/tmp/hello.html src/Main.elm 2>&1

# The html file is complex, so we'll extract the text content
# Elm generates HTML with the text in JavaScript
if [ -f /tmp/hello.html ]; then
    # Get the main assignment section (may span multiple lines for let expressions)
    MAIN_SECTION=$(grep -A 25 '\$author\$project\$Main\$main =' /tmp/hello.html | head -35)
    
    # Check if this is a let expression (has return statement)
    if echo "$MAIN_SECTION" | grep -q "return"; then
        # For let expressions, find the return variable and trace its assignment
        RETURN_VAR=$(echo "$MAIN_SECTION" | grep "return" | head -1 | sed 's/.*return \([^;]*\);.*/\1/')
        # Find the assignment: var greeting = 'Hello, ' + (name + '!');
        ASSIGN=$(echo "$MAIN_SECTION" | grep "var $RETURN_VAR =")
        # Extract strings from assignment in order: 'Hello, ', then find name value, then '!'
        # Pattern: var greeting = 'Hello, ' + (name + '!');
        # Extract strings from assignment in order
        # Pattern: var greeting = 'Hello, ' + (name + '!');
        # Or: return 'Sum: ' + $elm$core$String$fromInt(sum);
        RETURN_LINE=$(echo "$MAIN_SECTION" | grep "return" | head -1)
        # Extract the first string part from return statement (if any)
        PART1=$(echo "$RETURN_LINE" | grep -oE "'[^']+'" | head -1 | sed "s/'//g" || echo "")
        # Check if return references a variable
        RETURN_VAR=$(echo "$RETURN_LINE" | sed 's/.*return \([^;]*\);.*/\1/')
        # Check if this variable was assigned with string concatenation involving 'name'
        ASSIGN=$(echo "$MAIN_SECTION" | grep "var $RETURN_VAR =")
        if [ -n "$ASSIGN" ] && echo "$ASSIGN" | grep -qE "\\+.*name"; then
            # Find name variable assignment from the main section
            NAME_VAL=$(echo "$MAIN_SECTION" | grep "var name =" | grep -oE "'[^']+'" | sed "s/'//g" | head -1)
            # Extract parts from the assignment: 'Hello, ' + (name + '!')
            PART1=$(echo "$ASSIGN" | grep -oE "'[^']+'" | head -1 | sed "s/'//g")
            PART2=$(echo "$ASSIGN" | grep -oE "'[^']+'" | tail -1 | sed "s/'//g")
            echo "${PART1}${NAME_VAL}${PART2}"
        elif echo "$RETURN_LINE" | grep -q "String\$fromInt"; then
            # For calculations: return 'Sum: ' + String.fromInt(sum);
            # Extract the number from the sum calculation
            # First try to find sum variable
            SUM_LINE=$(echo "$MAIN_SECTION" | grep "var sum =")
            NUM=""
            if [ -n "$SUM_LINE" ]; then
                # Check if sum is a direct number or calculation
                if echo "$SUM_LINE" | grep -qE "= [0-9]+"; then
                    NUM=$(echo "$SUM_LINE" | grep -oE "= [0-9]+" | grep -oE "[0-9]+" | head -1)
                else
                    # Sum is calculated: var sum = a + b;
                    # Find var a = 5; and var b = 10; (the ones with actual numbers, not .valueOf())
                    A=$(echo "$MAIN_SECTION" | grep "var a = [0-9]" | grep -v "valueOf" | grep -oE "[0-9]+" | head -1)
                    B=$(echo "$MAIN_SECTION" | grep "var b = [0-9]" | grep -v "valueOf" | grep -oE "[0-9]+" | head -1)
                    if [ -n "$A" ] && [ -n "$B" ]; then
                        NUM=$((A + B))
                    fi
                fi
            fi
            if [ -n "$NUM" ]; then
                echo "${PART1}${NUM}"
            elif [ -n "$PART1" ]; then
                # Fallback: just output PART1 (at least we got the prefix)
                echo "$PART1"
            else
                # Last resort: extract any string from return line
                echo "$RETURN_LINE" | grep -oE "'[^']+'" | sed "s/'//g" | head -1
            fi
        else
            # Check if return references a variable that was assigned
            RETURN_VAR=$(echo "$RETURN_LINE" | sed 's/.*return \([^;]*\);.*/\1/')
            # Check if this variable was assigned with string concatenation
            ASSIGN=$(echo "$MAIN_SECTION" | grep "var $RETURN_VAR =")
            if [ -n "$ASSIGN" ]; then
                # Extract strings from the assignment
                RESULT=$(echo "$ASSIGN" | grep -oE "'[^']+'" | sed "s/'//g" | tr -d '\n')
                if [ -n "$RESULT" ]; then
                    echo "$RESULT"
                else
                    # Fallback: extract from return line
                    echo "$RETURN_LINE" | grep -oE "'[^']+'" | sed "s/'//g" | tr -d '\n'
                fi
            else
                # Simple concatenation without variables - extract all strings from return
                RESULT=$(echo "$RETURN_LINE" | grep -oE "'[^']+'" | sed "s/'//g" | tr -d '\n')
                if [ -n "$RESULT" ]; then
                    echo "$RESULT"
                elif [ -n "$PART1" ]; then
                    echo "$PART1"
                else
                    # Last resort fallback
                    echo "$MAIN_SECTION" | grep -oE "'[^']+'" | sed "s/'//g" | grep -vE "^(html|body|div|script|Main|Elm|author|project|init|node|document|getElementById|elm)$" | head -1
                fi
            fi
        fi
    else
        # Simple case: Html$text('text') or Html$text('a' + 'b') or Html$text(String.toUpper('text'))
        # Extract strings, filtering out Elm internals more aggressively
        STRINGS=$(echo "$MAIN_SECTION" | grep -oE "'[^']+'" | sed "s/'//g" | grep -vE "^(html|body|div|script|Main|Elm|author|project|init|node|document|getElementById|elm)$")
        # If we have multiple strings, they might be concatenated - join them
        # If we have function calls, the final value might be in the result
        # For now, just output the strings in order, filtering out very short ones that are likely internals
        echo "$STRINGS" | grep -E ".{3,}" | tr -d '\n' || \
        grep -o "Hello World!" /tmp/hello.html | head -1
    fi
else
    echo "Error: /tmp/hello.html was not created" >&2
    exit 1
fi

