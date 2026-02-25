# Esoteric / special-case languages (fraglet)

Languages that have a vein and optional fraglet support but are low-priority or constrained for stdin/args:

| Language      | Stdin/args notes |
|---------------|-------------------|
| unlambda      | No traditional stdin; execution model is purely functional. Stdin/args N/A. |
| whitespace    | Program is whitespace-only; input is possible but non-trivial. Low-priority. |
| zombie        | Esoteric; stdin/args may be possible but not documented. Low-priority. |
| lolcode       | CAN HAS STDIN; args possible. Feasible but low-priority. |
| emojicode     | Execution model may support I/O; feasibility TBD. Low-priority. |
| snobol4       | Pattern-based I/O; stdin/args possible. Low-priority. |
| nasm-x86_64   | Assembly; stdin/args require syscalls. Feasible but high effort. |

None of these are in `.rejected-languages`; they remain targets. Add to rejected only if we explicitly decide to drop support.
