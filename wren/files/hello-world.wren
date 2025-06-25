// In a world where every character is secretly a quantum particle...
class QuantumLetter {
  construct new(char, spin) {
    _char = char
    _spin = spin // Up or down, who knows until we observe it!
  }

  // Schrödinger's toString - collapses the quantum state
  toString { _spin ? _char : (_char.bytes[0] + 1).toString }
}

class QuantumMessage {
  construct new() {
    // Initialize our quantum letters in superposition
    _letters = [
      QuantumLetter.new("H", true),
      QuantumLetter.new("e", true),
      QuantumLetter.new("l", true),
      QuantumLetter.new("l", true),
      QuantumLetter.new("o", true),
      QuantumLetter.new(" ", true),
      QuantumLetter.new("W", true),
      QuantumLetter.new("o", true),
      QuantumLetter.new("r", true),
      QuantumLetter.new("l", true),
      QuantumLetter.new("d", true),
      QuantumLetter.new("!", true)
    ]
  }

  // Collapse the quantum superposition
  observe { _letters.map { |l| l.toString }.join("") }
}

// The quantum measurement that changes everything... or does it?
System.print(QuantumMessage.new().observe)