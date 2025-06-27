# Piet

Piet is a fascinating esoteric programming language where programs are works of art - literally! Named after the abstract painter Piet Mondrian, Piet programs are images that get executed by interpreting color transitions between adjacent regions.

## About Piet

Piet uses a stack-based execution model where the instruction pointer moves through colored regions (called "color blocks") in the image. Commands are determined by the change in hue and lightness between adjacent regions. The language includes:

- 20 distinct colors arranged in cycles of hue and lightness
- Stack-based operations (push, pop, arithmetic, etc.)
- I/O operations for reading and writing characters/numbers
- Flow control through direction changes and termination

What makes Piet special is that valid programs can be aesthetically pleasing abstract art. The challenge lies in creating programs that are both functional and visually appealing.

## The Hello World Program

Our Piet Hello World program is stored as `hello-world.gif` - a small 120×120 pixel image that outputs "Hello World" when executed. Each pixel's color and position is carefully chosen to generate the exact sequence of stack operations needed to produce the required output.

The execution follows a path through the image, with the interpreter moving from one color region to another, performing operations based on the color transitions it encounters.

## Implementation Details

This container uses `npiet` (version 1.3f), the most widely-used C implementation of a Piet interpreter. The interpreter can handle PNG, GIF, and PPM image formats and includes various options for codel size detection and color handling.

The interpreter is compiled from source during the Docker build process, ensuring compatibility with Alpine Linux's musl libc. This makes it lightweight and suitable for container environments.

## Exploring Piet Further

- Try modifying the image in a graphics editor and see how it affects the output
- Experiment with different codel sizes (pixel groupings)
- Create your own Piet programs using the color specification
- Explore more complex Piet programs that create intricate visual patterns while performing computations

Piet beautifully demonstrates that code and art don't have to be separate - they can be the same thing!