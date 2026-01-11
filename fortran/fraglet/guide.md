# Fortran Fraglet Guide

## Language Version
Fortran (GNU Fortran compiler, gfortran)

## Execution Model
- Compiled language using gfortran (GNU Fortran compiler)
- Code is compiled to a binary, then executed
- Standard Fortran execution model with `program` block

## Key Characteristics
- Statically typed
- Case-insensitive
- Column-based formatting (free-form in Fortran 90+)
- Requires explicit compilation step
- Uses gfortran compiler (GCC-based Fortran compiler)

## Fragment Authoring
Write valid Fortran statements. Your fragment becomes the program body. Your fragment will be compiled and executed.

## Available Modules
Standard Fortran modules are available:
- No explicit `use` statements required for basic I/O
- `print *` for formatted output
- Standard Fortran intrinsic functions

## Common Patterns
- Output: `print *, "message"`
- Variables: `integer :: x = 10`
- Arrays: `integer, dimension(10) :: arr`
- Loops: `do i = 1, 10 ... end do`
- Conditionals: `if (condition) then ... end if`
- Functions: `function name(x) result(y) ... end function`
- Subroutines: `subroutine name(x) ... end subroutine`

## Examples
```fortran
! Simple output
print *, "Hello from fragment!"

! Variables and calculations
integer :: a = 5
integer :: b = 10
print *, "Sum:", a + b

! Loops
integer :: i
do i = 1, 5
    print *, "Count:", i
end do

! Arrays
integer, dimension(5) :: numbers = [1, 2, 3, 4, 5]
integer :: sum = 0
integer :: i
do i = 1, 5
    sum = sum + numbers(i)
end do
print *, "Array sum:", sum
```

## Caveats
- Fragments must be valid Fortran code that compiles
- Fortran is case-insensitive
- Use `print *,` for output (the `*` means default formatting)
- Variables must be declared before use (or use implicit typing)
- The code is compiled fresh each time, so compilation errors will fail execution
- Fortran uses 1-based array indexing by default
- String concatenation uses `//` operator
- Integer division truncates (use `real` for floating-point division)
