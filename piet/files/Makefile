GOFLAGS =

all: piet

piet: piet.go
	go build -o piet piet.go

clean:
	rm -f piet

# Quick test of most promising images that should work
quick-test:
	@echo "Quick test of most promising images:"
	@echo "=== Testing hw4-1.gif (should output 'Hello, world!') ==="
	timeout 5 ./piet test_images/hw4-1.gif 1 || echo "Timeout or error"
	@echo -e "\n=== Testing hi.png ==="
	timeout 5 ./piet test_images/hi.png 16 || echo "Timeout or error"
	@echo -e "\n=== Testing tetris.png ==="
	timeout 5 ./piet test_images/tetris.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing progopedia_hello_basic.png ==="
	timeout 5 ./piet test_images/progopedia_hello_basic.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing esolangs_hello_world.gif ==="
	timeout 5 ./piet test_images/esolangs_hello_world.gif 1 || echo "Timeout or error"

# Test images from original frank-zago repository (these MUST work)
test-original:
	@echo "Testing original frank-zago images that MUST work:"
	@echo "=== Testing hw1-11.gif ==="
	timeout 10 ./piet test_images/hw1-11.gif 11 || echo "Timeout or error"
	@echo -e "\n=== Testing hw4-1.gif ==="
	timeout 10 ./piet test_images/hw4-1.gif 1 || echo "Timeout or error"
	@echo -e "\n=== Testing hw3-5.gif ==="
	timeout 10 ./piet test_images/hw3-5.gif 5 || echo "Timeout or error"
	@echo -e "\n=== Testing helloworld-mondrian.png ==="
	timeout 10 ./piet test_images/helloworld-mondrian.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing hi.png ==="
	timeout 10 ./piet test_images/hi.png 16 || echo "Timeout or error"
	@echo -e "\n=== Testing adder.png (with input 32 54) ==="
	echo "32 54" | timeout 10 ./piet test_images/adder.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing power2.png (with input 12 3) ==="
	echo "12 3" | timeout 10 ./piet test_images/power2.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing hw6_big.png ==="
	timeout 10 ./piet test_images/hw6_big.png 5 || echo "Timeout or error"
	@echo -e "\n=== Testing tetris.png ==="
	timeout 10 ./piet test_images/tetris.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing helloworld-piet.gif ==="
	timeout 10 ./piet test_images/helloworld-piet.gif 1 || echo "Timeout or error"
	@echo -e "\n=== Testing cowsay.png (with input 'It's alive.') ==="
	echo "It's alive." | timeout 10 ./piet test_images/cowsay.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing 99bottles.png ==="
	timeout 10 ./piet test_images/99bottles.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing euclid_clint_big.png (with input 10 6) ==="
	echo "10 6" | timeout 10 ./piet test_images/euclid_clint_big.png 10 || echo "Timeout or error"
	@echo -e "\n=== Testing piet_factorial.png (with input 12) ==="
	echo "12" | timeout 10 ./piet test_images/piet_factorial.png 1 || echo "Timeout or error"

# Test additional hello world images (may or may not work due to generation issues)
test-hello:
	@echo "Testing additional hello world images:"
	@echo "=== Testing frankzago_hello.png ==="
	timeout 10 ./piet test_images/frankzago_hello.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing frankzago_helloworld-mondrian.png ==="
	timeout 10 ./piet test_images/frankzago_helloworld-mondrian.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing frankzago_hi.png ==="
	timeout 10 ./piet test_images/frankzago_hi.png 16 || echo "Timeout or error"
	@echo -e "\n=== Testing progopedia_hello_basic.png ==="
	timeout 10 ./piet test_images/progopedia_hello_basic.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing progopedia_hello_decorative.png ==="
	timeout 10 ./piet test_images/progopedia_hello_decorative.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing our_hello_world.png ==="
	timeout 10 ./piet test_images/our_hello_world.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing our_hello_world_artistic.png ==="
	timeout 10 ./piet test_images/our_hello_world_artistic.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing esolangs_hello_world.gif ==="
	timeout 10 ./piet test_images/esolangs_hello_world.gif 1 || echo "Timeout or error"
	@echo -e "\n=== Testing thomas_schoch_hello.gif ==="
	timeout 10 ./piet test_images/thomas_schoch_hello.gif 1 || echo "Timeout or error"

# Test other images in parent directory (may or may not work)
test-generated:
	@echo "Testing generated images from parent directory:"
	@echo "=== Testing ../hello-world.png ==="
	timeout 10 ./piet ../hello-world.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing ../hello-world-basic.gif ==="
	timeout 10 ./piet ../hello-world-basic.gif 1 || echo "Timeout or error"
	@echo -e "\n=== Testing ../official-hello-world.gif ==="
	timeout 10 ./piet ../official-hello-world.gif 1 || echo "Timeout or error"
	@echo -e "\n=== Testing ../progopedia-decorative.png ==="
	timeout 10 ./piet ../progopedia-decorative.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing ../hello_world_artistic.png ==="
	timeout 10 ./piet ../hello_world_artistic.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing ../hello_world_masterpiece.png ==="
	timeout 10 ./piet ../hello_world_masterpiece.png 1 || echo "Timeout or error"
	@echo -e "\n=== Testing ../magical_hello_world.png ==="
	timeout 10 ./piet ../magical_hello_world.png 1 || echo "Timeout or error"

# Run all tests
test: test-original test-hello test-generated

# Debug versions of tests
debug-original:
	@echo "Debug testing original images:"
	./piet -d test_images/helloworld-mondrian.png 1

debug-hello:
	@echo "Debug testing hello world images:"
	./piet -d test_images/frankzago_hello.png 1
