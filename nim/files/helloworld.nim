# BEGIN_FRAGLET
import std/strformat

proc getGreeting(): string =
  let part1 = "Hello"
  let part2 = "World"
  fmt"{part1} {part2}!"

echo getGreeting()
# END_FRAGLET