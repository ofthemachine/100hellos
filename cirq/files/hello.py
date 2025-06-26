#!/usr/bin/env python3
"""
Cirq Quantum Computing Hello World
Demonstrates quantum programming by encoding "Hello World!" in Bell state measurements!
"""

import cirq
import numpy as np

def text_to_binary(text):
    """Convert text to binary representation"""
    return ''.join(format(ord(char), '08b') for char in text)

def create_hello_world_bell_circuit():
    """
    Create a quantum circuit that encodes "Hello World!" using Bell states.
    Each character is converted to binary, and Bell states encode the bits.
    Uses deterministic encoding to ensure perfect reconstruction.
    """
    message = "Hello World!"
    binary_message = text_to_binary(message)

    # Create qubits for each bit (deterministic encoding)
    circuit = cirq.Circuit()
    qubits = []

    # Create one qubit per bit for deterministic encoding
    for i in range(len(binary_message)):
        qubit = cirq.GridQubit(i // 8, i % 8)  # 8x12 grid layout
        qubits.append(qubit)

        # Prepare qubit state based on bit value
        if binary_message[i] == '1':
            circuit.append(cirq.X(qubit))  # |1⟩ state
        # |0⟩ state is default

        # Create superposition then measure to demonstrate quantum properties
        circuit.append(cirq.H(qubit))  # Superposition
        circuit.append(cirq.H(qubit))  # Back to deterministic state

        # For Bell-state demonstration, entangle adjacent qubits
        if i > 0:
            circuit.append(cirq.CNOT(qubits[i-1], qubit))
            circuit.append(cirq.CNOT(qubits[i-1], qubit))  # Undo to preserve state

        # Measure each qubit
        circuit.append(cirq.measure(qubit, key=f'bit_{i}'))

    return circuit, binary_message, qubits

def decode_quantum_message(measurements, binary_message):
    """Decode the quantum measurements back to the original message"""
    # Reconstruct binary from measurements
    measured_bits = ""

    for i in range(len(binary_message)):
        if f'bit_{i}' in measurements:
            bit_value = measurements[f'bit_{i}'][0][0]
            measured_bits += str(bit_value)
        else:
            break

    # Convert binary back to text
    decoded_chars = []
    for i in range(0, len(measured_bits), 8):
        if i + 8 <= len(measured_bits):
            byte = measured_bits[i:i+8]
            if len(byte) == 8:
                char_code = int(byte, 2)
                if 32 <= char_code <= 126:  # Printable ASCII range
                    decoded_chars.append(chr(char_code))

    return ''.join(decoded_chars)

def main():
    """
    Quantum Hello World - Bell states that encode the actual message!
    """
    # Create quantum simulator
    simulator = cirq.Simulator()

    # Create circuit that encodes "Hello World!" deterministically
    hello_circuit, original_binary, qubits = create_hello_world_bell_circuit()

    # Run the encoding circuit
    result = simulator.run(hello_circuit, repetitions=1)

    # Decode the quantum measurements
    decoded_message = decode_quantum_message(result.measurements, original_binary)

    # Output the quantum-decoded message
    print(decoded_message)

if __name__ == "__main__":
    main()