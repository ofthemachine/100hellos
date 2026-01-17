# Java Fraglet Guide

## Language Version
Java (OpenJDK)

## Execution Model
- Compiled language
- Requires explicit `main()` method
- Code runs inside `main(String[] args)`
- Can define classes, methods, and fields outside `main()`

## Key Characteristics
- Statically typed
- Case-sensitive
- Object-oriented programming
- Platform-independent (JVM)
- Rich standard library

## Fragment Authoring
Write valid Java code. Your fragment replaces the entire class body between `// BEGIN_FRAGLET` and `// END_FRAGLET`. You must include the `main()` method. You can also define helper methods, fields, and nested classes within your fragment.

## Available Libraries
- Java standard library (java.lang, java.util, java.io, etc.)
- No additional dependencies pre-installed

## Common Patterns
- Print: `System.out.println("message");`
- Variables: `int x = 5;` or `var x = 5;` (Java 10+)
- Arrays: `int[] arr = {1, 2, 3};`
- Lists: `List<Integer> list = Arrays.asList(1, 2, 3);`
- String concatenation: `"Hello " + name`
- Classes: `class MyClass { }`
- Methods: `public static int method() { return 0; }`

## Examples

```java
// Simple output
public static void main(String[] args) throws Exception {
    System.out.println("Hello, World!");
}
```

```java
// Variables and calculations
public static void main(String[] args) throws Exception {
    int a = 5;
    int b = 10;
    int sum = a + b;
    System.out.println("Sum: " + sum);
}
```

```java
// Arrays and loops
public static void main(String[] args) throws Exception {
    int[] numbers = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int num : numbers) {
        sum += num;
    }
    System.out.println("Array sum: " + sum);
}
```

```java
// Method definition
public static int add(int a, int b) {
    return a + b;
}

public static void main(String[] args) throws Exception {
    int result = add(5, 10);
    System.out.println("5 + 10 = " + result);
}
```

```java
// Nested class definition
public static void main(String[] args) throws Exception {
    class Calculator {
        public int multiply(int a, int b) {
            return a * b;
        }
    }
    
    Calculator calc = new Calculator();
    System.out.println("5 * 3 = " + calc.multiply(5, 3));
}
```

```java
// List operations
import java.util.*;

public static void main(String[] args) throws Exception {
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
    int sum = numbers.stream().mapToInt(Integer::intValue).sum();
    System.out.println("Sum: " + sum);
}
```

```java
// String operations
public static void main(String[] args) throws Exception {
    String greeting = "Hello";
    String name = "World";
    String message = greeting + ", " + name + "!";
    System.out.println(message);
}
```

```java
// Command-line arguments
public static void main(String[] args) throws Exception {
    if (args.length > 0) {
        System.out.println("First argument: " + args[0]);
    }
}
```

## Caveats
- Must include `public static void main(String[] args)` method
- Semicolons are required
- Case-sensitive
- Primitive types vs. wrapper classes (int vs Integer)
- Array indexing starts at 0
