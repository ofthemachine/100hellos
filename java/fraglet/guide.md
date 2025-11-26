# Java Fraglet Guide (with Wordalytica)

## Language Version
Java 11 (OpenJDK)

## Execution Model
- Compiled via `javac`, runs via `java`
- Code is injected into `HelloWorld.java` main method
- wordalytica library is on classpath at `/lib/wordalytica.jar`
- 370K word dictionary available at `/lib/words.all`

## Wordalytica Word Pattern DSL

A fluent interface for discovering words matching patterns from a comprehensive English dictionary.

### Loading Words

Use the helper method to load the bundled dictionary:

```java
WordSet<?> words = HelloWorld.loadWords();  // Returns WordSet with 370K words
```

**Important**: Call `loadWords()` once and reuse the WordSet. Each call rebuilds the entire dictionary.

### Fluent Methods (All Chainable)

All methods return a new filtered WordSet view. You can chain multiple filters:

- `.longerThan(int n)` - Filter to words with length > n
- `.containing(String s)` - Filter to words containing substring s (anywhere)
- `.startingWith(String s)` - Filter to words starting with s
- `.endingWith(String s)` - Filter to words ending with s
- `.notEndingWith(String s)` - Filter to words NOT ending with s
- `.matching(String pattern)` - Pattern match with wildcards (see below)

### Pattern Matching with Wildcards

The `.matching()` method supports wildcard patterns:

- `_` (underscore) - matches any single character
- `?` (question mark) - matches any single character
- Pattern length must exactly match word length

**Examples:**
- `"c_t"` matches "cat", "cot", "cut", "cet", etc.
- `"a??e"` matches "able", "ache", "acre", etc.
- `"____"` matches any 4-letter word

### Terminal Operations

After chaining filters, use these to get results:

- `.count()` - Returns `int` count of matching words
- `.iterator()` - Returns `Iterator<String>` for iterating over matches

### Required Imports

```java
import com.wordalytica.wordset.WordSetFactory;
import com.wordalytica.wordset.core.WordSet;
import java.nio.file.*;
import java.util.*;
```

## Examples

### Basic Usage

```java
// Load the dictionary
WordSet<?> words = HelloWorld.loadWords();

// Count words ending in "tion"
int count = words.endingWith("tion").count();
System.out.println("Words ending in 'tion': " + count);

// Print all 5-letter words starting with "qu"
words.longerThan(4).startingWith("qu")
     .iterator().forEachRemaining(System.out::println);
```

### Pattern Matching

```java
WordSet<?> words = HelloWorld.loadWords();

// Find 4-letter words with "a" in second position
words.matching("_a__").iterator().forEachRemaining(System.out::println);
// Output: "able", "ache", "acre", "aged", etc.

// Find words matching pattern "c_t" (3 letters, starts with c, ends with t)
words.matching("c_t").iterator().forEachRemaining(System.out::println);
// Output: "cat", "cot", "cut", "cet", etc.
```

### Chaining Multiple Filters

```java
WordSet<?> words = HelloWorld.loadWords();

// Words starting with "pre", ending in "ing", longer than 7 characters
words.startingWith("pre")
     .endingWith("ing")
     .longerThan(7)
     .iterator().forEachRemaining(System.out::println);
// Output: "preparing", "preserving", "pretending", etc.

// Words containing "tion" but not ending with it
words.containing("tion")
     .notEndingWith("tion")
     .iterator().forEachRemaining(System.out::println);
```

### Word Puzzle Examples

```java
WordSet<?> words = HelloWorld.loadWords();

// Find all words that start and end with the same letter
// (requires custom logic, but you can filter by length first)
words.longerThan(3).iterator().forEachRemaining(word -> {
    if (word.charAt(0) == word.charAt(word.length() - 1)) {
        System.out.println(word);
    }
});

// Find words matching crossword pattern: _a_e_ (5 letters, a in 2nd, e in 4th)
words.matching("_a_e_").iterator().forEachRemaining(System.out::println);
```

### Counting and Statistics

```java
WordSet<?> words = HelloWorld.loadWords();

// Count words by ending
System.out.println("Words ending in 'ing': " + words.endingWith("ing").count());
System.out.println("Words ending in 'ed': " + words.endingWith("ed").count());
System.out.println("Words ending in 'ly': " + words.endingWith("ly").count());

// Count words of specific length
System.out.println("5-letter words: " + words.longerThan(4).matching("_____").count());
```

## Common Patterns

```java
// Load once, reuse
WordSet<?> words = HelloWorld.loadWords();

// Simple filter and print
words.endingWith("ing").iterator().forEachRemaining(System.out::println);

// Filter and count
int count = words.startingWith("un").longerThan(5).count();

// Pattern matching
words.matching("a__e").iterator().forEachRemaining(System.out::println);

// Complex chain
words.startingWith("pre")
     .containing("tion")
     .longerThan(8)
     .iterator().forEachRemaining(System.out::println);
```

## Caveats

- **All words are lowercase** - The dictionary is normalized to lowercase
- **Pattern length must match exactly** - `matching("c_t")` only matches 3-letter words
- **Load once, reuse** - `loadWords()` is expensive, call it once per program
- **Method chains create filtered views** - Each method returns a new WordSet, original is unchanged
- **Iterator consumes the set** - If you need to iterate multiple times, call the chain again
- **Wildcards are `_` and `?`** - Both work the same way in patterns
- **Case-sensitive matching** - All string matches are case-sensitive (but words are lowercase)

## Performance Tips

- Load the WordSet once at the start of your program
- Chain filters efficiently - more specific filters first can help
- Use `count()` when you only need the number, not the actual words
- The library uses caching internally for performance

