# PHP Fraglet Guide

## Language Version
PHP 8.x

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level within `<?php ... ?>` tags
- No explicit main function required

## Key Characteristics
- C-style syntax
- Dynamic typing
- Case-sensitive
- Indentation is preserved based on the injection point

## Fragment Authoring
Write normal PHP code between the provided tags; your fraglet becomes the script body. PHP tags are already in place, so just write the code you want to run (functions, classes, statements).

## Available Packages
Standard PHP library is available. No additional packages are pre-installed.

## Common Patterns
- Print: `echo "message";` or `print("message");`
- String interpolation: `"Total: $count"` or `"Total: {$count}"`
- Arrays: `[1, 2, 3]` or `array(1, 2, 3)`
- Functions: `function name() { }`
- Loops: `foreach ($array as $item) { }`
- Conditionals: `if ($condition) { }`

## Examples
```php
// Simple output
echo "Hello, World!";

// Function definition
function greet($name) {
    return "Hello, $name!";
}

echo greet("Alice");

// Array processing
$numbers = [1, 2, 3, 4, 5];
$squared = array_map(function($x) { return $x * $x; }, $numbers);
echo "Sum of squares: " . array_sum($squared);

// Class example (now possible with range-based injection)
class Calculator {
    public static function sum($numbers) {
        return array_sum($numbers);
    }
}

$numbers = [1, 2, 3, 4, 5];
echo "Sum: " . Calculator::sum($numbers);
```

## Caveats
- PHP requires semicolons at the end of statements
- Variables must be prefixed with `$`
- String concatenation uses `.` operator
- PHP tags are not needed in fragments (already in the file)

