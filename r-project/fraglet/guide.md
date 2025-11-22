# R Fraglet Guide

## Language Version
R 4.x

## Execution Model
- Interpreted, runs via Rscript
- Top-level R code runs as written
- Code runs sequentially from top to bottom
- Indentation is preserved from the injection point (no indentation by default)

## Key Characteristics
- Vectorized operations
- Case-sensitive
- Functional programming support
- Use `cat()` / `print()` to emit output

## Fragment Authoring
Fragments should be valid R expressions, assignments, and function definitions. They run sequentially. Define helper functions before you call them.

## Available Packages
Standard R libraries are available. No additional packages are pre-installed. To install packages, set a CRAN mirror first:
```r
options(repos = c(CRAN = "https://cloud.r-project.org"))
install.packages("package_name")
```
Note: Installs live only for the lifetime of the run.

## Common Patterns
- Print: `print("message")` or `cat("message\n")`
- Assignment: `vals <- rnorm(5, mean = 10, sd = 2)`
- Functions: `function(x) x * 2`
- Vectors: `c(1, 2, 3)`
- Random: `set.seed(123); rnorm(5)`
- Vectorized operations: `x <- 1:10; x * 2`

## Examples
```r
# Simple output
print("Hello, World!")

# Function definition
greet <- function(name) {
  paste("Hello,", name, "!")
}

print(greet("Alice"))

# Vector processing
numbers <- 1:5
squared <- numbers^2
cat("Sum of squares:", sum(squared), "\n")
```

## Caveats
- Make fragments idempotent—repeated runs should succeed without manual cleanup
- For reproducible randomness, call `set.seed()` before generating random data
- Package installs are ephemeral—include setup logic in the fragment if needed
