# Implement Fraglet Support for {LANGUAGE}

## Context

You are implementing fraglet support for the **{LANGUAGE}** language container in the 100hellos project. Fraglets enable code fragment execution within language containers.

## Task

Implement complete fraglet support for {LANGUAGE} by:

1. Creating the `fraglet/` directory structure
2. Creating `fraglet/fraglet.yml` configuration
3. Creating `fraglet/guide.md` documentation
4. Modifying the hello-world source file to include injection markers
5. Updating the Dockerfile to use fraglet-entrypoint
6. Creating `fraglet/verify.sh` that tests all examples from guide.md
7. Ensuring the container runs correctly without a fraglet (default "Hello World!" output)
8. **Rebuilding the image and running verify.sh until it passes** (required for completion)

**Important**:
- Rebuild the image between steps using `make {LANGUAGE}` (especially after Dockerfile changes or file modifications)
- The implementation is **only complete** when `verify.sh` passes all tests
- If verify.sh fails, fix issues, rebuild, and test again until it passes

## Reference Guidance

Consult the gydnc guidance: `fraglet-enable-100hellos` for detailed implementation steps and patterns.

## Current Container Structure

The {LANGUAGE} container is located at `{LANGUAGE}/` and currently:
- Uses base image: `FROM 100hellos/000-base:local` (which includes fraglet-entrypoint)
- Has hello-world files in `files/` directory
- May need Dockerfile updates to copy fraglet directory and set entrypoint

## Implementation Requirements

### 1. fraglet.yml Configuration

Create `{LANGUAGE}/fraglet/fraglet.yml` with appropriate configuration:

- **fragletTempPath**: `/FRAGLET` (standard)
- **injection.codePath**: Path to the source file (e.g., `/hello-world/hello-world.{ext}`)
- **injection.match**: String to replace (single-line) OR `match_start`/`match_end` (multi-line)
- **execution.path**: Command to execute the code
- **execution.makeExecutable**: `true` if path is a script, `false` if it's a command
- **guide**: `/guide.md`

**Decision points:**
- For interpreted languages: `path: <interpreter> /hello-world/hello-world.<ext>`, `makeExecutable: false`
- For scripts with shebang: `path: /hello-world/hello-world.<ext>`, `makeExecutable: true`
- For compiled languages: `path: /hello-world/hello-world.sh` (wrapper), `makeExecutable: true`

### 2. guide.md Documentation

Create `{LANGUAGE}/fraglet/guide.md` with:

- Language version
- Execution model (interpreted, compiled, etc.)
- Key characteristics (syntax rules, typing, case sensitivity)
- Fragment authoring guidelines
- Available libraries/packages
- Common patterns
- Code examples
- Caveats and limitations

Reference existing guides (e.g., `python/fraglet/guide.md`, `ruby/fraglet/guide.md`) for structure.

### 3. Modify Hello World Source

Add injection markers to the hello-world source file:

**CRITICAL: Preserve existing file structure - DO NOT modify shebangs or code structure**

- **DO NOT change shebangs** - Keep the original shebang exactly as it is
  - If file has `#!/usr/bin/env ash`, keep it as `#!/usr/bin/env ash` (explicit is better)
  - If file has `#!/bin/sh`, keep it as `#!/bin/sh`
  - **Never change from explicit to implicit/default** - explicit shebangs are preferred
  - Shebangs are often specific to the container/environment (e.g., Alpine/busybox needs explicit paths)

- **DO NOT modify code structure** - Only add the minimal match marker needed
  - Preserve existing formatting, indentation, and code style
  - Do NOT reformat or "improve" the code
  - Do NOT add unnecessary comments

- **Only add match markers** where fragments should be injected

**For single-line replacement:**
- Add a unique match string (e.g., `Hello World`, `print("Hello World")`)
- Ensure the match string is exactly as it appears in the source

**For multi-line replacement:**
- Add `BEGIN_FRAGLET` and `END_FRAGLET` markers (with appropriate comment syntax)
- Use `match_start` and `match_end` in fraglet.yml

### 4. Update Dockerfile

Ensure the Dockerfile:
- Uses `FROM 100hellos/000-base:local` (provides fraglet-entrypoint)
- Copies fraglet directory: `COPY --chown=human:human ./fraglet /`
- Sets entrypoint: `ENTRYPOINT [ "/fraglet-entrypoint" ]`

**After updating Dockerfile, rebuild the image:**
```bash
make {LANGUAGE}
```

### 5. Handle Working Directory

**IMPORTANT**: When fraglet-entrypoint runs, the working directory may change. Ensure execution scripts (like `hello-world.sh`) explicitly change to the correct directory if needed:

```bash
#!/usr/bin/env sh
cd /hello-world
# ... rest of execution commands
```

This ensures scripts work correctly both with and without fraglet-entrypoint.

### 6. Create verify.sh

Create `{LANGUAGE}/fraglet/verify.sh` that:

1. **Tests default execution** (no fraglet):
   - Runs the container without providing a fraglet
   - Verifies it outputs "Hello World!" (and any other expected output)
   - Example: `docker run --rm <image> | grep -q "Hello World!"`

2. **Tests all examples from guide.md**:
   - Test each example from the "Examples" section of guide.md
   - Simple smoke tests: verify it compiles/runs and produces expected output
   - Single-line assertions are sufficient (not comprehensive validation)

**Recommended structure** (simple and readable):
```bash
#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/{LANGUAGE}:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
Put_Line ("Hello from fragment!");
EOF

# Example 2: Variables
verify_fraglet "Sum:" <<'EOF'
declare
  A : Integer := 5;
  B : Integer := 10;
begin
  Put_Line ("Sum: " & Integer'Image (A + B));
end;
EOF

# ... continue for all examples from guide.md

echo "✓ All tests passed"
```

**Key points:**
- Use heredoc with "-" placeholder: `fragletc --image "$IMAGE" - <<'EOF' ... EOF`
- Helper function makes tests readable and concise
- Single-line assertions are fine (smoke tests, not comprehensive)
- Priority: test all guide.md examples, not deep output validation
- Some languages may need syntax adjustments (e.g., Ada declare blocks)

**After creating verify.sh, rebuild and test:**
```bash
make {LANGUAGE}
chmod +x {LANGUAGE}/fraglet/verify.sh
{LANGUAGE}/fraglet/verify.sh
```

If verify.sh fails, fix issues, rebuild (`make {LANGUAGE}`), and test again. Repeat until it passes.

## Reference Examples

- **Simple interpreted**: `python/`, `ruby/`, `lua/` - Direct execution
- **With wrapper script**: `prolog/`, `lisp/` - Wrapper handles REPL
- **Compiled**: `the-c-programming-language/`, `nasm-x86_64/` - Compile then execute
- **Multi-line injection**: `awk/`, `snobol4/` - Uses match_start/match_end

## Special Considerations

- **Compiled languages**: May need wrapper script that compiles then executes
- **REPL-based languages**: May need wrapper script to feed code to interpreter
- **Unique execution models**: Consult existing examples (e.g., `brainfuck/`)

## Verification

**CRITICAL: verify.sh must pass before implementation is complete**

The implementation is NOT complete until `verify.sh` runs successfully. You may need to rebuild the image between steps:

1. After creating/modifying files, rebuild the image:
   ```bash
   make {LANGUAGE}
   ```

2. After updating Dockerfile, rebuild:
   ```bash
   make {LANGUAGE}
   ```

3. After modifying hello-world source files, rebuild:
   ```bash
   make {LANGUAGE}
   ```

4. **Run verify.sh and ensure it passes** (this is required):
   ```bash
   chmod +x {LANGUAGE}/fraglet/verify.sh
   {LANGUAGE}/fraglet/verify.sh
   ```
   - If verify.sh fails, fix the issues and rebuild: `make {LANGUAGE}`
   - Repeat until verify.sh passes completely

5. Verify detection:
   ```bash
   .utils/fraglet-status.sh enabled | grep {LANGUAGE}
   ```

**The implementation is only complete when verify.sh passes all tests.**

## Notes

- Follow existing patterns from similar languages
- Ensure match strings are unique and won't conflict
- Document execution model clearly in guide.md
- Include practical examples in guide.md
