# Objective-C Fraglet Guide

## Language Version
Objective-C (GCC compiler with GNUstep Base library)

## Execution Model
- Compiled language using GCC with Objective-C runtime
- Code is compiled to a binary, then executed
- Uses GNUstep Base library for Foundation framework support
- Standard Objective-C execution model with `main()` function

## Key Characteristics
- Object-oriented language (Smalltalk-style message passing)
- Dynamic typing with optional static type annotations
- Case-sensitive
- Uses square brackets for method calls: `[object method]`
- Requires explicit compilation step
- Uses GNUstep Base (open-source implementation of Cocoa/Foundation)

## Fragment Authoring
Write valid Objective-C code. Your fragment can define classes, interfaces, implementations, and the `main()` function. Import statements are already in place. Your fragment will be compiled and executed.

## Available Frameworks
The template includes:
- `Foundation/Foundation.h` - Core Foundation classes (NSString, NSArray, NSDictionary, etc.)
- `stdio.h` - Standard C I/O (printf, scanf)

## Common Patterns
- Print: `printf("message\n");` or `NSLog(@"message");`
- String literals: `@"Hello"` (Objective-C strings) or `"Hello"` (C strings)
- Class definition: `@interface ClassName : NSObject { } @end`
- Method definition: `- (returnType)methodName:(paramType)param;`
- Method implementation: `@implementation ClassName ... @end`
- Object creation: `[[ClassName alloc] init]` or `[ClassName new]`
- Message passing: `[object method:argument]`
- Variables: `int x = 10;` or `NSString *str = @"Hello";`
- Arrays: `NSArray *arr = @[@"a", @"b", @"c"];`
- Dictionaries: `NSDictionary *dict = @{@"key": @"value"};`

## Examples
```objc
// Simple output
int main(int argc, char *argv[]) {
    printf("Hello from fragment!\n");
    return 0;
}

// Using Foundation classes (note: avoid @"..." string literals in fragments)
#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSString *message = [NSString stringWithUTF8String:"Hello from Objective-C!"];
    printf("%s\n", [message UTF8String]);
    [pool drain];
    return 0;
}

// Simple class with method
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

// Variables and calculations
int main(int argc, char *argv[]) {
    int a = 5;
    int b = 10;
    printf("Sum: %d\n", a + b);
    return 0;
}

// Using NSArray (note: avoid @[...] array literals, use arrayWithObjects:)
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

// Class with multiple methods
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
```

## Caveats
- Fragments must be valid Objective-C code that compiles
- Remember to include `\n` in printf for newlines
- **IMPORTANT**: Objective-C string literals (`@"..."`) and array literals (`@[...]`) do not work in fragments due to GNUstep compilation limitations
  - Use `[NSString stringWithUTF8String:"C string"]` instead of `@"string"`
  - Use `[NSArray arrayWithObjects:obj1, obj2, ..., nil]` instead of `@[obj1, obj2, ...]`
  - Use `printf()` with `[NSString UTF8String]` instead of `NSLog()` with format strings
- Always create an `NSAutoreleasePool` when using Foundation classes to avoid memory warnings
- Use `printf("%d\n", value)` for C-style printing of primitives
- Variables, classes, and functions are scoped to the file
- The code is compiled fresh each time, so compilation errors will fail execution
- GNUstep Base may have some differences from Apple's Foundation in edge cases
- Memory management: GNUstep uses reference counting (similar to ARC), but be aware of retain/release patterns for complex code
