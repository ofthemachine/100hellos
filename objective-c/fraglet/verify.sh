#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/objective-c:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
int main(int argc, char *argv[]) {
    printf("Hello from fragment!\n");
    return 0;
}
EOF

# Example 2: Using Foundation classes (avoiding string literals due to GNUstep limitations)
verify_fraglet "Hello from Objective-C!" <<'EOF'
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSString *message = [NSString stringWithUTF8String:"Hello from Objective-C!"];
    printf("%s\n", [message UTF8String]);
    [pool drain];
    return 0;
}
EOF

# Example 3: Simple class with method
verify_fraglet "Hello, World!" <<'EOF'
#import <Foundation/Foundation.h>

@interface Greeter : NSObject
- (void)greet:(NSString *)name;
@end

@implementation Greeter
- (void)greet:(NSString *)name {
    printf("Hello, %s!\n", [name UTF8String]);
}
@end

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    Greeter *greeter = [Greeter new];
    NSString *world = [NSString stringWithUTF8String:"World"];
    [greeter greet:world];
    [pool drain];
    return 0;
}
EOF

# Example 4: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
int main(int argc, char *argv[]) {
    int a = 5;
    int b = 10;
    printf("Sum: %d\n", a + b);
    return 0;
}
EOF

# Example 5: Using NSArray
verify_fraglet "Array sum:" <<'EOF'
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSNumber *n1 = [NSNumber numberWithInt:1];
    NSNumber *n2 = [NSNumber numberWithInt:2];
    NSNumber *n3 = [NSNumber numberWithInt:3];
    NSNumber *n4 = [NSNumber numberWithInt:4];
    NSNumber *n5 = [NSNumber numberWithInt:5];
    NSArray *numbers = [NSArray arrayWithObjects:n1, n2, n3, n4, n5, nil];
    int sum = 0;
    for (NSNumber *num in numbers) {
        sum += [num intValue];
    }
    printf("Array sum: %d\n", sum);
    [pool drain];
    return 0;
}
EOF

# Example 6: Class with multiple methods
verify_fraglet "5 + 3 = 8" <<'EOF'
#import <Foundation/Foundation.h>

@interface Calculator : NSObject
- (int)add:(int)a to:(int)b;
- (int)multiply:(int)a by:(int)b;
@end

@implementation Calculator
- (int)add:(int)a to:(int)b {
    return a + b;
}
- (int)multiply:(int)a by:(int)b {
    return a * b;
}
@end

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    Calculator *calc = [Calculator new];
    int result = [calc add:5 to:3];
    printf("5 + 3 = %d\n", result);
    result = [calc multiply:4 by:7];
    printf("4 * 7 = %d\n", result);
    [pool drain];
    return 0;
}
EOF

echo "✓ All tests passed"
