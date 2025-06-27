package main

import (
	"fmt"
	"image"
	"image/gif"
	"image/jpeg"
	"image/png"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

// Piet colors - exact same as frank-zago C implementation
var pietColors = map[[3]uint8]int{
	{255, 192, 192}: 0,  // light red
	{255, 255, 192}: 1,  // light yellow
	{192, 255, 192}: 2,  // light green
	{192, 255, 255}: 3,  // light cyan
	{192, 192, 255}: 4,  // light blue
	{255, 192, 255}: 5,  // light magenta
	{255, 0, 0}:     6,  // red
	{255, 255, 0}:   7,  // yellow
	{0, 255, 0}:     8,  // green
	{0, 255, 255}:   9,  // cyan
	{0, 0, 255}:     10, // blue
	{255, 0, 255}:   11, // magenta
	{192, 0, 0}:     12, // dark red
	{192, 192, 0}:   13, // dark yellow
	{0, 192, 0}:     14, // dark green
	{0, 192, 192}:   15, // dark cyan
	{0, 0, 192}:     16, // dark blue
	{192, 0, 192}:   17, // dark magenta
	{255, 255, 255}: 18, // white
	{0, 0, 0}:       19, // black
}

const (
	WHITE   = 18
	BLACK   = 19
	INVALID = 20
)

var colorNames = []string{
	"light red", "light yellow", "light green", "light cyan", "light blue", "light magenta",
	"red", "yellow", "green", "cyan", "blue", "magenta",
	"dark red", "dark yellow", "dark green", "dark cyan", "dark blue", "dark magenta",
	"white", "black", "invalid",
}

// Commands based on hue and lightness changes - same as C implementation
var commands = [][]string{
	{"noop", "push", "pop"},
	{"add", "sub", "mult"},
	{"div", "mod", "not"},
	{"greater", "pointer", "switch"},
	{"dup", "roll", "innumber"},
	{"inchar", "outnumber", "outchar"},
}

type Codel struct {
	x, y  int
	color int
}

type PietInterpreter struct {
	program   [][]int // program storage as 2D array
	width     int
	height    int
	dp        int // direction pointer: 0=right, 1=down, 2=left, 3=up
	cc        int // codel chooser: -1=left, 1=right (matching C implementation)
	current   Codel
	edge      Codel
	blockSize int
	stack     []int
	debug     bool
	codelSize int // size of each codel in pixels
}

func NewPietInterpreter(img image.Image, codelSize int, debug bool) *PietInterpreter {
	bounds := img.Bounds()
	imgWidth := bounds.Dx()
	imgHeight := bounds.Dy()

	// Check if image dimensions are divisible by codel size
	if imgWidth%codelSize != 0 || imgHeight%codelSize != 0 {
		fmt.Fprintf(os.Stderr, "Image dimensions not divisible by codel size\n")
		return nil
	}

	width := imgWidth / codelSize
	height := imgHeight / codelSize

	// Create program storage
	program := make([][]int, height)
	for i := range program {
		program[i] = make([]int, width)
	}

	// Load program - sample pixel from each codel
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			// Sample from top-left corner of each codel
			r, g, b, _ := img.At(x*codelSize, y*codelSize).RGBA()
			rgb := [3]uint8{uint8(r >> 8), uint8(g >> 8), uint8(b >> 8)}

			if color, ok := pietColors[rgb]; ok {
				program[y][x] = color
			} else {
				program[y][x] = INVALID
			}
		}
	}

	return &PietInterpreter{
		program:   program,
		width:     width,
		height:    height,
		dp:        0,
		cc:        -1, // Start with left (-1) like C implementation
		current:   Codel{x: 0, y: 0},
		stack:     make([]int, 0),
		debug:     debug,
		codelSize: codelSize,
	}
}

func (p *PietInterpreter) debugf(format string, args ...interface{}) {
	if p.debug {
		fmt.Fprintf(os.Stderr, format, args...)
	}
}

func (p *PietInterpreter) inBounds(c Codel) bool {
	return c.x >= 0 && c.x < p.width && c.y >= 0 && c.y < p.height
}

func (p *PietInterpreter) getCodelColor(c *Codel) {
	if p.inBounds(*c) {
		c.color = p.program[c.y][c.x]
	} else {
		c.color = BLACK
	}
}

func (p *PietInterpreter) getNextCodelDP(c *Codel) bool {
	next := *c
	switch p.dp {
	case 0: // right
		next.x++
	case 1: // down
		next.y++
	case 2: // left
		next.x--
	case 3: // up
		next.y--
	}

	if p.inBounds(next) {
		*c = next
		return true
	}
	return false
}

// Get block info using flood fill like C implementation
// This modifies the program array by setting a fill bit (using negative values)
func (p *PietInterpreter) getBlockInfos(x, y int) {
	codel := Codel{x: x, y: y}

	if !p.inBounds(codel) {
		return
	}

	// Check if already processed (negative means filled)
	if p.program[y][x] < 0 || p.program[y][x] != p.current.color {
		return
	}

	// Is it a new edge?
	switch p.dp {
	case 0: // right
		if x > p.edge.x {
			p.edge = codel
		} else if x == p.edge.x {
			if (p.cc == -1 && y < p.edge.y) || (p.cc == 1 && y > p.edge.y) {
				p.edge = codel
			}
		}
	case 1: // down
		if y > p.edge.y {
			p.edge = codel
		} else if y == p.edge.y {
			if (p.cc == -1 && x > p.edge.x) || (p.cc == 1 && x < p.edge.x) {
				p.edge = codel
			}
		}
	case 2: // left
		if x < p.edge.x {
			p.edge = codel
		} else if x == p.edge.x {
			if (p.cc == -1 && y > p.edge.y) || (p.cc == 1 && y < p.edge.y) {
				p.edge = codel
			}
		}
	case 3: // up
		if y < p.edge.y {
			p.edge = codel
		} else if y == p.edge.y {
			if (p.cc == -1 && x < p.edge.x) || (p.cc == 1 && x > p.edge.x) {
				p.edge = codel
			}
		}
	}

	p.blockSize++

	// Mark as processed (use negative value)
	p.program[y][x] = -p.program[y][x] - 1

	// Recurse to neighbors
	p.getBlockInfos(x-1, y)
	p.getBlockInfos(x, y-1)
	p.getBlockInfos(x, y+1)
	p.getBlockInfos(x+1, y)
}

func (p *PietInterpreter) resetFillBits() {
	for y := 0; y < p.height; y++ {
		for x := 0; x < p.width; x++ {
			if p.program[y][x] < 0 {
				p.program[y][x] = -p.program[y][x] - 1
			}
		}
	}
}

func (p *PietInterpreter) getNextBlock() (Codel, bool) {
	var next Codel
	found := false

	// Try up to 9 attempts like C implementation
	for attempt := 0; attempt < 9; attempt++ {
		p.edge = p.current
		p.blockSize = 0

		p.getBlockInfos(p.current.x, p.current.y)
		p.resetFillBits()

		next = p.edge
		if p.getNextCodelDP(&next) {
			p.getCodelColor(&next)

			if next.color != BLACK && next.color != p.current.color {
				found = true
				break
			}
		}

		// Rotate cc or dp alternately like C implementation
		if attempt%2 == 1 {
			p.dp = (p.dp + 1) % 4
		} else {
			p.cc = -p.cc
		}
	}

	return next, found
}

// White block sliding like C implementation
func (p *PietInterpreter) slideWhite() (Codel, bool) {
	var next Codel
	found := false

	for {
		// Find edge in straight line
		next = p.current
		for {
			tempNext := next
			if p.getNextCodelDP(&tempNext) {
				p.getCodelColor(&tempNext)
				if tempNext.color == WHITE {
					p.current = tempNext
					next = tempNext
				} else {
					break
				}
			} else {
				break
			}
		}

		// Get next color block
		found = false
		for attempt := 0; attempt < 9; attempt++ {
			next = p.current
			if p.getNextCodelDP(&next) {
				p.getCodelColor(&next)

				if next.color != BLACK {
					found = true
					break
				}
			}

			// Rotate cc and dp
			p.cc = -p.cc
			p.dp = (p.dp + 1) % 4
		}

		if !found || next.color != WHITE {
			break
		}
	}

	return next, found
}

func (p *PietInterpreter) push(val int) {
	p.stack = append(p.stack, val)
	p.debugf("Pushed %d, stack: %v\n", val, p.stack)
}

func (p *PietInterpreter) pop() int {
	if len(p.stack) == 0 {
		p.debugf("Pop from empty stack, returning 0\n")
		return 0
	}
	val := p.stack[len(p.stack)-1]
	p.stack = p.stack[:len(p.stack)-1]
	p.debugf("Popped %d, stack: %v\n", val, p.stack)
	return val
}

func (p *PietInterpreter) getOperation(next *Codel) string {
	// Calculate hue and lightness changes like C implementation
	currentHue := p.current.color % 6
	currentLight := p.current.color / 6
	nextHue := next.color % 6
	nextLight := next.color / 6

	var hue, lightness int

	if currentHue > nextHue {
		hue = 6 - currentHue + nextHue
	} else {
		hue = nextHue - currentHue
	}

	if currentLight > nextLight {
		lightness = 3 - currentLight + nextLight
	} else {
		lightness = nextLight - currentLight
	}

	if hue < len(commands) && lightness < len(commands[hue]) {
		return commands[hue][lightness]
	}

	return "noop"
}

func (p *PietInterpreter) executeCommand(cmd string) {
	p.debugf("Executing command: %s (block size: %d)\n", cmd, p.blockSize)

	switch cmd {
	case "push":
		p.push(p.blockSize)
	case "pop":
		if len(p.stack) > 0 {
			p.pop()
		}
	case "add":
		if len(p.stack) >= 2 {
			val1 := p.pop()
			val2 := p.pop()
			p.push(val2 + val1)
		}
	case "sub":
		if len(p.stack) >= 2 {
			val1 := p.pop()
			val2 := p.pop()
			p.push(val2 - val1)
		}
	case "mult":
		if len(p.stack) >= 2 {
			val1 := p.pop()
			val2 := p.pop()
			p.push(val2 * val1)
		}
	case "div":
		if len(p.stack) >= 2 {
			val1 := p.pop()
			val2 := p.pop()
			if val1 != 0 {
				p.push(val2 / val1)
			}
		}
	case "mod":
		if len(p.stack) >= 2 {
			val1 := p.pop()
			val2 := p.pop()
			if val1 != 0 {
				p.push(val2 % val1)
			}
		}
	case "not":
		if len(p.stack) >= 1 {
			val := p.pop()
			if val == 0 {
				p.push(1)
			} else {
				p.push(0)
			}
		}
	case "greater":
		if len(p.stack) >= 2 {
			val1 := p.pop()
			val2 := p.pop()
			if val2 > val1 {
				p.push(1)
			} else {
				p.push(0)
			}
		}
	case "pointer":
		if len(p.stack) >= 1 {
			val := p.pop()
			p.dp = (p.dp + val) % 4
			if p.dp < 0 {
				p.dp += 4
			}
			p.debugf("Direction pointer changed to %d\n", p.dp)
		}
	case "switch":
		if len(p.stack) >= 1 {
			val := p.pop()
			if val%2 == 1 {
				p.cc = -p.cc
			}
			p.debugf("Codel chooser changed to %d\n", p.cc)
		}
	case "dup":
		if len(p.stack) >= 1 {
			val := p.stack[len(p.stack)-1]
			p.push(val)
		}
	case "roll":
		if len(p.stack) >= 2 {
			rolls := p.pop()
			depth := p.pop()

			if depth < 0 || depth > len(p.stack) {
				return
			}

			if rolls > 0 {
				for i := 0; i < rolls; i++ {
					if depth > 0 {
						last := p.stack[len(p.stack)-1]
						for j := len(p.stack) - 1; j > len(p.stack)-depth; j-- {
							p.stack[j] = p.stack[j-1]
						}
						p.stack[len(p.stack)-depth] = last
					}
				}
			} else if rolls < 0 {
				rolls = -rolls
				for i := 0; i < rolls; i++ {
					if depth > 0 {
						last := p.stack[len(p.stack)-depth]
						for j := len(p.stack) - depth; j < len(p.stack)-1; j++ {
							p.stack[j] = p.stack[j+1]
						}
						p.stack[len(p.stack)-1] = last
					}
				}
			}
		}
	case "outchar":
		if len(p.stack) >= 1 {
			val := p.pop()
			fmt.Printf("%c", val)
			p.debugf("Output char: %c (%d)\n", val, val)
		}
	case "outnumber":
		if len(p.stack) >= 1 {
			val := p.pop()
			fmt.Printf("%d", val)
			p.debugf("Output number: %d\n", val)
		}
	case "inchar":
		var val int
		n, err := fmt.Scanf("%c", &val)
		if err != nil || n != 1 {
			fmt.Fprintf(os.Stderr, "user input error\n")
			os.Exit(1)
		}
		p.push(val)
	case "innumber":
		var val int
		n, err := fmt.Scanf("%d", &val)
		if err != nil || n != 1 {
			fmt.Fprintf(os.Stderr, "user input error\n")
			os.Exit(1)
		}
		p.push(val)
	}
}

func (p *PietInterpreter) Run() {
	// Initialize current position
	p.getCodelColor(&p.current)
	p.debugf("Starting interpreter at (%d,%d), program size: %dx%d\n",
		p.current.x, p.current.y, p.width, p.height)

	steps := 0
	maxSteps := 100000 // prevent infinite loops

	for steps < maxSteps {
		var next Codel
		found := false

		if p.current.color == WHITE {
			next, found = p.slideWhite()
			if found {
				p.current = next
			} else {
				break
			}
		}

		next, found = p.getNextBlock()
		if found {
			if next.color == WHITE {
				p.current = next
			} else {
				op := p.getOperation(&next)
				p.executeCommand(op)
				p.current = next
			}
		} else {
			break
		}

		steps++
	}

	p.debugf("Interpreter finished after %d steps\n", steps)
}

func loadImage(filename string) (image.Image, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	ext := strings.ToLower(filepath.Ext(filename))
	switch ext {
	case ".png":
		return png.Decode(file)
	case ".jpg", ".jpeg":
		return jpeg.Decode(file)
	case ".gif":
		return gif.Decode(file)
	default:
		// Try to decode as any supported format
		img, _, err := image.Decode(file)
		return img, err
	}
}

func main() {
	debug := false
	filename := ""
	codelSize := 1

	// Parse arguments like C implementation: piet <image> <codel_size>
	args := os.Args[1:]

	// Filter out debug flag
	filteredArgs := make([]string, 0)
	for _, arg := range args {
		if arg == "-d" || arg == "--debug" {
			debug = true
		} else {
			filteredArgs = append(filteredArgs, arg)
		}
	}

	if len(filteredArgs) != 2 {
		fmt.Fprintf(os.Stderr, "Usage: %s [-d|--debug] <image> <codel_size>\n", os.Args[0])
		os.Exit(1)
	}

	filename = filteredArgs[0]
	var err error
	codelSize, err = strconv.Atoi(filteredArgs[1])
	if err != nil || codelSize <= 0 {
		fmt.Fprintf(os.Stderr, "Invalid codel size: %s\n", filteredArgs[1])
		os.Exit(1)
	}

	img, err := loadImage(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error loading image: %v\n", err)
		os.Exit(1)
	}

	interpreter := NewPietInterpreter(img, codelSize, debug)
	if interpreter == nil {
		os.Exit(1)
	}

	interpreter.Run()
}
