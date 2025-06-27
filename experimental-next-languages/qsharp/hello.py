#!/usr/bin/env python3
"""
Q# Quantum Hello World - Bell State Demonstration
This demonstrates quantum programming by creating and measuring a Bell state
"""

import qsharp

# Define Q# quantum operations
bell_state_code = '''
    operation CreateBellState() : (Result, Result) {
        // Allocate two qubits
        use (q1, q2) = (Qubit(), Qubit());

        // Create Bell state: (|00⟩ + |11⟩) / √2
        H(q1);      // Put first qubit in superposition
        CNOT(q1, q2); // Entangle the qubits

        // Measure both qubits
        let result1 = M(q1);
        let result2 = M(q2);

        return (result1, result2);
    }
'''

def main():
    print("=== Q# Quantum Programming Hello World ===")
    print("Demonstrating quantum entanglement with Bell states")
    print()

    # Compile the Q# operation
    create_bell_state = qsharp.compile(bell_state_code)

    print("Running Bell state measurements (should show correlated results):")
    print("In a Bell state, both qubits always measure the same value!")
    print()

    # Run multiple measurements to show quantum behavior
    results = []
    for i in range(10):
        result = create_bell_state.simulate()
        results.append(result)
        print(f"Measurement {i+1}: Qubit1={result[0]}, Qubit2={result[1]} - {'✓ Correlated' if result[0] == result[1] else '✗ Not correlated'}")

    print()
    print("=== Quantum Programming Analysis ===")
    correlated = sum(1 for r in results if r[0] == r[1])
    print(f"Correlated measurements: {correlated}/10 ({correlated*10}%)")
    print("Perfect correlation demonstrates quantum entanglement!")
    print()
    print("Hello from the quantum realm! 🌌")

if __name__ == "__main__":
    main()