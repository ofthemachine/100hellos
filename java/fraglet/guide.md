# Java Fraglet Guide

Your code runs inside `main()`. Imports are handled—just write statements.

## Load Words

```java
WordSet<?> words = HelloWorld.loadWords();
```

Call once and reuse. All words are lowercase.

## Fluent Methods (Chainable)

| Method | Description |
|--------|-------------|
| `.matching("c_t")` | Pattern with `_` or `?` wildcards; fixes length |
| `.containing("s")` | Has substring |
| `.notContaining("xyz")` | Excludes all chars in string |
| `.startingWith("s")` | Prefix match |
| `.endingWith("s")` | Suffix match |
| `.notEndingWith("s")` | Excludes suffix |
| `.longerThan(n)` | Length > n |
| `.withCharAt('a', 2)` | Letter at position (0-indexed) |
| `.withoutCharAt('a', 2)` | Letter NOT at position |

## Terminal Operations

| Method | Returns |
|--------|---------|
| `.count()` | `int` — number of matches |
| `.iterator()` | `Iterator<String>` — iterate results |

## Wordle Constraints

| Clue | Method |
|------|--------|
| Gray `x` | `.notContaining("x")` |
| Green `a` at slot 2 | `.withCharAt('a', 1)` |
| Yellow `l` not slot 4 | `.containing("l").withoutCharAt('l', 3)` |

```java
WordSet<?> words = HelloWorld.loadWords();

// 5-letter, ends 'd', has 'a' (not slot 0), has 'l' (not slot 2), no x/z/q
words.matching("____d")
     .containing("a").withoutCharAt('a', 0)
     .containing("l").withoutCharAt('l', 2)
     .notContaining("xzq")
     .iterator().forEachRemaining(System.out::println);
```

## Crossword Patterns

```java
// 5 letters, 'a' in slot 2, 'e' in slot 4
words.matching("_a_e_").iterator().forEachRemaining(System.out::println);
```

## Scrabble Scoring

```java
int score = HelloWorld.wordScore("quartz");  // 24
System.out.println(score);

// Find highest-scoring 5-letter words containing 'q'
words.matching("_____").containing("q")
     .iterator().forEachRemaining(w ->
         System.out.println(w + " = " + HelloWorld.wordScore(w)));
```

## Quick Reference

```java
WordSet<?> words = HelloWorld.loadWords();

// Count
int n = words.endingWith("ing").count();

// Print all
words.startingWith("un").iterator().forEachRemaining(System.out::println);

// Chain
words.matching("_____")
     .containing("a")
     .notContaining("eiou")
     .iterator().forEachRemaining(System.out::println);
```

## Notes

- Positions are 0-indexed
- `matching()` sets word length implicitly
- Words are lowercase; matches are case-sensitive
