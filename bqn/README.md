# BQN - Big Picture Array Programming

BQN is a modern array programming language developed by Marshall Lochbaum, inspired by APL and J but designed with modern programming principles. This implementation uses CBQN, the C-based reference implementation.

## What makes BQN special?

🔢 **Array-first mindset**: Every value is an array, making it incredibly powerful for data manipulation
🧠 **Mathematical notation**: Uses special symbols that make code read almost like mathematical expressions
🏃 **Performance**: CBQN compiles to efficient native code
🎯 **Modern design**: Learns from decades of array language development while avoiding historical baggage

## The "Hello World!" magic

Our simple program `•Out "Hello World!"` demonstrates:
- `•Out` - A system function (indicated by the bullet `•`) for output
- String literals work just like in other languages
- No semicolons or verbose syntax needed!

## Fun BQN facts

- BQN uses over 30 special symbols, each precisely chosen for mathematical intuition
- A single line of BQN can often replace dozens of lines in traditional languages
- The language has both "tacit" (point-free) and explicit programming styles
- It's particularly beloved by mathematicians and data scientists

## Explore BQN further

Try these expressions to see BQN's array magic:
- `bqn -p "1+1"` - Basic arithmetic
- `bqn -p "+´1‿2‿3‿4‿5"` - Sum an array using fold
- `bqn -p "10↑{𝕩∾+´¯2↑𝕩}⍟9⟨0,1⟩"` - Generate first 10 Fibonacci numbers!

BQN proves that powerful doesn't have to mean complicated!