# Vala Fraglet Guide

## Language Version
Vala (latest from Alpine package repository)

## Execution Model
- Compiled language using `valac` (Vala compiler)
- Code is compiled to C, then to a binary, then executed
- Standard Vala execution model with `main()` function

## Key Characteristics
- Statically typed with type inference (`var` keyword)
- Object-oriented (classes, inheritance, interfaces)
- Garbage collected (automatic memory management)
- Properties (get/set accessors)
- Signals (event system)
- Delegates and closures (lambda expressions)
- Case-sensitive
- C-like syntax with modern features
- Compiles to C code, then to native binary

## Fragment Authoring
Write valid Vala code. Your fragment can define classes, functions, and the `main()` function. Your fragment will be compiled and executed.

## Available Libraries
The template includes the standard Vala runtime and GLib:
- `GLib` - Core library (strings, lists, hash tables, etc.)
- Standard output: `print()` and `stdout.printf()`
- String manipulation
- Collections: `Gee.ArrayList`, `Gee.HashMap`
- File I/O
- And more from GLib/GObject ecosystem

## Common Patterns
- Print: `print("%s\n", message)` or `stdout.printf("%s\n", message)`
- Variables: `int x = 10;` or `var x = 10;` (type inference)
- Functions: `int add(int a, int b) { return a + b; }`
- Classes: `class Person { public string name; public int age; }`
- Properties: `public string message { get; set; }`
- Methods: `public void greet() { print("%s\n", message); }`
- Signals: `public signal void greeted(string who);`
- Delegates: `delegate void Callback(string msg);`
- Closures: `(x) => { print("%d\n", x); }`
- Lists: `var list = new Gee.ArrayList<int>();`
- HashMaps: `var map = new Gee.HashMap<string, int>();`

## Examples
```vala
// Simple output
void main() {
    print("Hello from fragment!\n");
}

// Variables and calculations
void main() {
    int a = 5;
    int b = 10;
    print("Sum: %d\n", a + b);
}

// Functions
int add(int a, int b) {
    return a + b;
}

void main() {
    int result = add(5, 10);
    print("5 + 10 = %d\n", result);
}

// Classes and properties
class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
}

void main() {
    var calc = new Calculator();
    print("5 + 3 = %d\n", calc.add(5, 3));
}

// Properties
class Person {
    public string name { get; set; }
    public int age { get; set; }
    
    public Person(string name, int age) {
        this.name = name;
        this.age = age;
    }
}

void main() {
    var person = new Person("Alice", 30);
    print("%s is %d years old\n", person.name, person.age);
}

// Signals
class Greeter : Object {
    public signal void greeted(string who);
    
    public void greet(string name) {
        greeted(name);
    }
}

void main() {
    var greeter = new Greeter();
    greeter.greeted.connect((who) => {
        print("Hello, %s!\n", who);
    });
    greeter.greet("World");
}

// String operations
void main() {
    string s = "Hello";
    s += " World!";
    print("%s\n", s);
    print("Length: %zu\n", s.length);
}

// Arrays
void main() {
    int[] numbers = {1, 2, 3, 4, 5};
    int sum = 0;
    foreach (int num in numbers) {
        sum += num;
    }
    print("Sum: %d\n", sum);
}

// Closures and delegates
delegate void Callback(int x);

void main() {
    Callback cb = (x) => {
        print("Value: %d\n", x);
    };
    
    cb(42);
}
```

## Caveats
- Fragments must be valid Vala code that compiles
- Use `print()` or `stdout.printf()` for output (not `println`)
- String formatting uses C-style format specifiers: `%s` (string), `%d` (int), `%f` (float), `%zu` (size_t)
- Remember to include `\n` for newlines in print statements
- Classes that use signals must inherit from `Object`
- Properties use `{ get; set; }` syntax
- The code is compiled fresh each time, so compilation errors will fail execution
- Vala compiles to C, so some C limitations may apply
- Use `var` for type inference when the type is obvious
- Arrays are zero-indexed
- Use `foreach` for iteration over collections
