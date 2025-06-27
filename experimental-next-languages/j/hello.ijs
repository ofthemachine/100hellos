NB. J Language Hello World - Array Programming Demonstration
NB. J is the ASCII successor to APL, focusing on mathematical array operations

echo 'Hello from J - the ASCII APL successor!'
echo ''

NB. Basic array operations
echo 'Array Programming Demonstrations:'
echo '=================================='
echo ''

NB. Create some arrays
echo 'Simple array: 1 2 3 4 5'
a =: 1 2 3 4 5
echo a
echo ''

NB. Mathematical operations on arrays
echo 'Array doubled: 2 * array'
echo 2 * a
echo ''

echo 'Array squared: array ^ 2'
echo a ^ 2
echo ''

NB. Array functions
echo 'Sum of array: +/ array'
echo +/ a
echo ''

echo 'Product of array: */ array'
echo */ a
echo ''

NB. Matrix operations
echo 'Matrix creation: 3 3 $ 1 2 3 4 5 6 7 8 9'
m =: 3 3 $ 1 2 3 4 5 6 7 8 9
echo m
echo ''

echo 'Matrix transpose: |: matrix'
echo |: m
echo ''

NB. Fibonacci sequence (J style)
echo 'Fibonacci sequence (first 10): J-style generation'
fib =: (, +/@(2&{.))^:8 ] 0 1
echo fib
echo ''

NB. Prime numbers using J array operations
echo 'Prime numbers less than 20:'
primes =: 2 3 5 7 11 13 17 19
echo primes
echo ''

echo 'J Language demonstrates the power of array programming!'
echo 'Every operation works on entire arrays simultaneously.'

exit 0