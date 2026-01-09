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

**CRITICAL reminders**:
- **DO NOT change the base image** unless you verify it doesn't already have fraglet-entrypoint in its DAG
- **After Dockerfile changes, ALWAYS test that the image builds:** `make {LANGUAGE}` - if it fails, STOP and fix it
- Rebuild the image between steps using `make {LANGUAGE}` (especially after Dockerfile changes or file modifications)
- The implementation is **only complete** when:
  - ✅ The image builds successfully
  - ✅ `verify.sh` passes all tests
- If verify.sh fails, fix issues, rebuild, and test again until it passes

## Reference Guidance

Consult the gydnc guidance: `fraglet-enable-100hellos` for detailed implementation steps and patterns.

## Current Container Structure

The {LANGUAGE} container is located at `{LANGUAGE}/` and currently:
- Has a Dockerfile with a base image (check if it already has fraglet-entrypoint in its DAG)
- Has hello-world files in `files/` directory
- May need Dockerfile updates to copy fraglet directory and set entrypoint
- **IMPORTANT**: Check the existing Dockerfile's FROM line - if the base image chain already includes `000-base:local`, it already has fraglet-entrypoint and you should NOT change the FROM line

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

**CRITICAL: Choosing Injection Scope**

The injection scope determines what's possible. The guide.md and injection strategy work together to maximize the fraglet container's usefulness for:
- Teaching developers the language
- Demonstrating language capabilities
- Providing inspiration for other fraglet containers

**Core principle**: The injection scope should enable the most useful capabilities with reasonable simplicity.

**Step 1: Understand the language's scoping rules**
- Where can functions/methods be defined?
- Where can types/classes be defined?
- Does the language allow nested definitions (functions inside functions)?

**Step 2: Choose injection scope to maximize capability**

| Language Characteristic | Recommended Scope | Rationale |
|------------------------|-------------------|-----------|
| Allows nested definitions (Python, JavaScript, Lua, Ruby) | Single-line inside function | Simple AND capable - user can define functions inline |
| Doesn't allow nested definitions (C, Java, Ballerina) | Range-based at module/file level | Expand scope so user CAN define functions, types, etc. |
| Minimal structure (shell scripts, awk) | Range-based if functions are common patterns | Enable function definitions without complex boilerplate |

**Step 3: Design guide.md to showcase the scope's capabilities**
- Examples should demonstrate what the chosen injection scope enables
- Include function definitions if the scope supports them
- Show the language's idioms and patterns

**Single-line replacement** (`match: "string"`):
- Best when the injection point already allows all desired capabilities
- Use minimal unique match string (e.g., `"Hello World!"` not the whole line)
- Injected code works within the existing structure

**Range-based replacement** (`match_start`/`match_end`):
- Best when you need a LARGER scope to enable more capabilities
- Place markers to encompass a region where functions/types can be defined
- User's fragment replaces the entire region, giving them full control
- May require user to include some boilerplate (e.g., main() definition) - this is acceptable if it enables significantly more capability

**Example decision for a language like C:**
- Injecting inside main() → user can't define helper functions
- Range-based from after #includes to end of file → user CAN define functions, then call them from main()
- The extra boilerplate is worth it for the capability gain

### 4. Update Dockerfile

**CRITICAL: DO NOT change the base image unless absolutely necessary**

- **Check if the existing base image already has fraglet-entrypoint in its DAG:**
  - If the base image (or any image in its chain) already includes `fraglet-entrypoint`, **DO NOT change the FROM line**
  - Most intermediate base images (like `100hellos/100-java11:local`, `100hellos/080-java8:local`) already inherit fraglet-entrypoint from `000-base:local`
  - Only use `FROM 100hellos/000-base:local` if the language has no intermediate base image requirements
- **Preserve the existing FROM line** unless you're certain it doesn't have fraglet-entrypoint
- Add fraglet directory copy: `COPY --chown=human:human ./fraglet /`
- Set entrypoint: `ENTRYPOINT [ "/fraglet-entrypoint" ]`

**CRITICAL: After updating Dockerfile, you MUST test that the image builds:**
```bash
make {LANGUAGE}
```
- If the build fails, fix the Dockerfile and rebuild
- **DO NOT proceed until the image builds successfully**

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

**CRITICAL: verify.sh must pass AND image must build successfully before implementation is complete**

The implementation is NOT complete until both the image builds AND `verify.sh` runs successfully. You MUST test at each step:

1. **After updating Dockerfile, rebuild and verify it builds:**
   ```bash
   make {LANGUAGE}
   ```
   - **If the build fails, STOP and fix the Dockerfile**
   - **DO NOT proceed until the image builds successfully**
   - Common issues: wrong base image, missing dependencies, syntax errors

2. After creating/modifying files, rebuild the image:
   ```bash
   make {LANGUAGE}
   ```

3. After modifying hello-world source files, rebuild:
   ```bash
   make {LANGUAGE}
   ```

4. **After creating verify.sh, rebuild and test:**
   ```bash
   make {LANGUAGE}
   chmod +x {LANGUAGE}/fraglet/verify.sh
   {LANGUAGE}/fraglet/verify.sh
   ```
   - **If verify.sh fails, fix the issues and rebuild: `make {LANGUAGE}`**
   - **Repeat until verify.sh passes completely**
   - **DO NOT mark implementation as complete until verify.sh passes**

5. Verify detection:
   ```bash
   .utils/fraglet-status.sh enabled | grep {LANGUAGE}
   ```

**The implementation is only complete when:**
- ✅ The image builds successfully (`make {LANGUAGE}` completes without errors)
- ✅ verify.sh passes all tests
- ✅ Default execution works (no fraglet injection)
- ✅ All guide.md examples work via fraglet injection

## Notes

- Follow existing patterns from similar languages
- Ensure match strings are unique and won't conflict
- Document execution model clearly in guide.md
- Include practical examples in guide.md
