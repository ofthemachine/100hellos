# Fennel

**Fennel** is a programming language that brings together the simplicity and elegance of Lisp with the ubiquity and performance of Lua. It's a Lisp that compiles to Lua, giving you the expressive power of parentheses with the practicality of one of the most embedded scripting languages in the world.

## What makes Fennel special?

🌙 **Lua's Little Lisp**: Fennel compiles down to readable Lua code, making it perfect for game development, embedded scripting, and anywhere Lua is used.

🚀 **Zero-cost abstractions**: All Fennel code compiles to efficient Lua with no runtime overhead.

🎯 **Gradual adoption**: You can use Fennel alongside existing Lua code, making migration painless.

⚡ **Macros that matter**: Real Lisp macros let you extend the language itself, not just write functions.

## Fun Facts

- Fennel was created by Phil Hagelberg (technomancy), who also created Leiningen for Clojure
- The name "Fennel" comes from the herb, continuing the botanical theme of many Lisp dialects
- It's used in the Lua ecosystem where people want Lisp's power but Lua's reach
- You can write entire game scripts in Fennel and compile them to vanilla Lua

Fennel proves that sometimes the best way forward is to go back to the elegant fundamentals of Lisp while embracing the practical world of modern runtime environments.

```fennel
;; Simple and beautiful
(print "Hello World!")
```