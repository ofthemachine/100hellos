# R Fragment Guide

## Runtime Snapshot
- R 4.x from Alpine `R` / `R-dev`
- Executed via `Rscript` with no wrappers—top-level R code runs as written

## Writing Fragments
- Paste plain R expressions, assignments, and function definitions; they run sequentially.
- Example:
  ```r
  set.seed(123)
  vals <- rnorm(5, mean = 10, sd = 2)
  cat("Values:", paste(round(vals, 2), collapse = ", "), "\n")
  ```
- Define helper functions before you call them; there is no second pass.
- Indentation is preserved from the injection point (no indentation by default), so keep your fragment’s indentation consistent.
- Use `cat()` / `print()` to emit output. Both stdout and stderr become the program output.

## Working Clean
- Make fragments idempotent—repeated runs should succeed without manual cleanup or hidden state.
- For reproducible randomness, call `set.seed()` before generating random data.
- Installing packages? Set a CRAN mirror (`options(repos = c(CRAN = "https://cloud.r-project.org"))`) and remember installs live only for the lifetime of the run; include setup each time or bake a custom image if you need persistent libraries.
