#!/bin/sh

echo "=== MiniZinc Constraint Programming Hello World ==="
echo "Solving N-Queens problem using constraint satisfaction..."
echo

# Run MiniZinc with Gecode solver
minizinc --solver gecode /hello.mzn

echo
echo "=== Constraint Programming Demo Complete ==="