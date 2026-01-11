# Clojure Fraglet Guide

## Language Version
Clojure (running on Java 11)

## Execution Model
- Interpreted, runs on the JVM
- Code executes at the top level of the script
- Scripts are executed directly via the `clojure` command

## Key Characteristics
- Lisp dialect with functional programming focus
- Dynamic typing
- Case-sensitive
- Immutable data structures by default
- Parentheses-based syntax (S-expressions)
- Code is data (homoiconic)

## Fragment Authoring
Write valid Clojure expressions. Your fragment becomes the script body, so code runs directly. You can define functions, use expressions, and leverage Clojure's rich standard library.

## Available Libraries
Standard Clojure libraries are available:
- `clojure.core` - Core functions (map, filter, reduce, etc.)
- `clojure.string` - String manipulation
- `clojure.set` - Set operations
- `clojure.java.io` - I/O operations
- Java interop is available for accessing Java libraries

## Common Patterns
- Print: `(println "message")`
- Function definition: `(defn greet [name] (str "Hello, " name "!"))`
- Anonymous functions: `(fn [x] (* x 2))` or `#(* % 2)`
- Collections: `[1 2 3]` (vector), `'(1 2 3)` (list), `{:a 1 :b 2}` (map)
- Map operations: `(map inc [1 2 3])` → `(2 3 4)`
- Filter: `(filter even? [1 2 3 4])` → `(2 4)`
- Reduce: `(reduce + [1 2 3 4])` → `10`
- Threading: `(-> x f g h)` (thread-first), `(->> x f g h)` (thread-last)

## Examples
```clojure
; Simple output
(println "Hello, World!")

; Function definition
(defn greet [name]
  (str "Hello, " name "!"))

(println (greet "Alice"))

; List processing with threading
(->> [1 2 3 4 5]
     (map #(* % %))
     (reduce +)
     (println "Sum of squares:"))

; Map operations
(def numbers [1 2 3 4 5])
(def squared (map #(* % %) numbers))
(println "Squared:" squared)

; Filter and transform
(->> [1 2 3 4 5 6 7 8 9 10]
     (filter even?)
     (map #(* % %))
     (println "Even squares:"))

; Working with maps
(def person {:name "Alice" :age 30})
(println "Name:" (:name person))
(println "Age:" (:age person))

; String operations
(require '[clojure.string :as str])
(println (str/upper-case "hello world"))
(println (str/join ", " ["apple" "banana" "cherry"]))
```

## Caveats
- Clojure runs on the JVM, so startup time may be noticeable
- Functions are first-class values
- Use `def` for top-level bindings, `let` for local bindings
- Collections are immutable - operations return new collections
- Java interop is available but requires understanding of Java types
