# Lua Language Guide

## Version
Lua 5.4 (standard interpreter, non-interactive batch execution).

## Execution Context
- Your fragment executes inside a `main()` function; treat it like the body of that function.
- The interpreter launches once, runs `main()`, then exits. Globals persist only for that single run.
- Output must be explicit (`print`, `io.write`, `io.stderr:write`). Return values are ignored unless printed.

## Syntax + Semantics
```lua
local message = "Hello"
local list = {1, 2, 3}

local function greet(name)
  return string.format("Hi, %s", name)
end

for i, value in ipairs(list) do
  print(string.format("%02d: %s", i, greet(value)))
end

if message == "Hello" then
  print("Greeting")
end
```

## Fragment Guidelines
- Define helper functions before using them; fragments execute top-to-bottom exactly once.
- Prefer locals (`local data = {}`) to avoid leaking globals across runs.
- Standard libraries (`string`, `table`, `math`, `os`, `io`) are already loaded; just call them.
- External `require` calls only work if the module exists in the runtime environment—ship dependencies via overlay files when needed.
- Deterministic output (e.g., zero-padded indices, sorted iteration) makes downstream diffs stable.
- Avoid `os.execute` unless absolutely necessary; it introduces portability and security noise that isn't validated here.

## What You Can Build
- Text processing and templating pipelines.
- Table-driven reports or aggregations (JSON parsing possible once modules are provided).
- Simple DSL interpreters or evaluators leveraging functions as first-class values.
- Glue code coordinating other CLI tools via `os.execute` or `io.popen` when deterministic output is acceptable.

## What You Can Build
- Text processing pipelines (parsing, formatting, templating)
- Small DSL evaluators or interpreters
- Data munging scripts that read files placed via `/code-fragments`
- Glue code that orchestrates other CLI tools via `os.execute`
