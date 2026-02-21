# Java Fraglet Guide

## Language Version
Java (OpenJDK)

## Execution Model
- Compiled language
- The **class must be named `Fraglet`**.
- You must define `public static void main(String[] args)`.

## Key Characteristics
- Statically typed
- Case-sensitive
- Object-oriented programming
- Platform-independent (JVM)
- Rich standard library

## Fragment Authoring
Write a **complete Java file**: one public class named **`Fraglet`**, with your code (imports, `main()`, and any helper methods or classes).

## Available Libraries
- Java standard library (java.lang, java.util, java.io, etc.)
- No additional dependencies pre-installed (default mode)

## Common Patterns
- Print: `System.out.println("message");`
- Variables: `int x = 5;` or `var x = 5;` (Java 10+)
- Arrays: `int[] arr = {1, 2, 3};`
- Lists: `List<Integer> list = Arrays.asList(1, 2, 3);`
- String concatenation: `"Hello " + name`
- Command-line args: `args[0]`, `args.length`, `String.join(" ", args)`

## Examples

```java
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

```java
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        int a = 5;
        int b = 10;
        int sum = a + b;
        System.out.println("Sum: " + sum);
    }
}
```

```java
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        int[] numbers = {1, 2, 3, 4, 5};
        int sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        System.out.println("Array sum: " + sum);
    }
}
```

```java
import java.util.*;

public class Fraglet {
    public static int add(int a, int b) {
        return a + b;
    }
    public static void main(String[] args) {
        int result = add(5, 10);
        System.out.println("5 + 10 = " + result);
    }
}
```

```java
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        class Calculator {
            public int multiply(int a, int b) {
                return a * b;
            }
        }
        Calculator calc = new Calculator();
        System.out.println("5 * 3 = " + calc.multiply(5, 3));
    }
}
```

```java
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        System.out.println("Args: " + String.join(" ", args));
    }
}
```

## Caveats
- **Class name must be `Fraglet`**.
- Must include `public static void main(String[] args)`.
- Semicolons are required.
- Case-sensitive.
- Primitive types vs. wrapper classes (int vs Integer).
- Array indexing starts at 0.
