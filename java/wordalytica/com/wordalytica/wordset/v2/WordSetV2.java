package com.wordalytica.wordset.v2;

import com.wordalytica.wordset.core.WordSet;
import com.wordalytica.wordset.predicate.Predicate;
import com.wordalytica.wordset.predicate.PredicateBuilder;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

public class WordSetV2 implements WordSet<WordSetV2> {
    private final Integer CACHE_DEPTH = 1; // You better have a lot of memory to crank this value
    private HashSet<String> allWords;
    private PredicateBuilder predicateBuilder;
    private HashMap<String, WordSetV2> cache = new HashMap<>();
    private String charactersUsed = "";
    public WordSetV2(Iterator<String> words) {
        this(words, 0);
    }

    public WordSetV2(Iterator<String> words, int depth) {
        this.allWords = new HashSet<>();
        this.predicateBuilder = new PredicateBuilder();
        words.forEachRemaining(this.allWords::add);
        if(depth < CACHE_DEPTH) {
            populateCache(depth);
        }
    }

    private void populateCache(Integer currentDepth) {
        char[] alphabet = "abcdefghijklmnopqrstuvwxyz".toCharArray();
        for (char c : alphabet) {
            cache.put(
                    String.valueOf(c),
                    new WordSetV2(this.containing(String.valueOf(c)).iterator(false), currentDepth + 1));
        }
    }

    @Override
    public Iterator<String> iterator() {
        return iterator(true);
    }

    public Iterator<String> iterator(Boolean useCache) {
        return getFilteredWords(useCache).iterator();
    }

    @Override
    public int count() {
        return getFilteredWords(true).size();
    }

    @Override
    public WordSetV2 longerThan(int minLength) {
        this.predicateBuilder.longerThan(minLength);
        return this;
    }

    @Override
    public WordSetV2 containing(String value) {
        this.predicateBuilder.containing(value);
        this.charactersUsed += value;
        return this;
    }

    @Override
    public WordSetV2 endingWith(String value) {
        this.predicateBuilder.endingWith(value);
        this.charactersUsed += value;
        return this;
    }

    @Override
    public WordSetV2 startingWith(String value) {
        this.predicateBuilder.startingWith(value);
        this.charactersUsed += value;
        return this;
    }

    @Override
    public WordSetV2 notEndingWith(String value) {
        this.predicateBuilder.notEndingWith(value);
        return this;
    }

    @Override
    public WordSetV2 matching(String placeHolded) {
        this.predicateBuilder.matching(placeHolded);
        this.charactersUsed += placeHolded;
        return this;
    }

    protected Predicate predicate(boolean reset) {
        Predicate predicate = this.predicateBuilder.build();
        PredicateBuilder builder = this.predicateBuilder;
        if(reset) {
            builder = new PredicateBuilder();
            this.charactersUsed = "";
        }
        this.predicateBuilder = builder;
        return predicate;
    }

    private HashSet<String> getFilteredWords(Boolean useCache) {
        HashSet<String> filteredWords;
        if(!useCache) {
            filteredWords = new HashSet<>(this.allWords);
        }
        else {
            filteredWords = new HashSet<>(findReducedWordList(this.cache, this.charactersUsed));
        }
        Predicate predicate = this.predicate(true);
        filteredWords.removeIf((s) -> !predicate.matches(s));
        return filteredWords;
    }

    private HashSet<String> findReducedWordList(HashMap<String, WordSetV2> cache, String charactersUsed) {
        HashSet<Character> charSet = new HashSet<Character>();
        for (char c : charactersUsed.toCharArray()) {
            charSet.add(c);
        }
        // Remove placeholded values
        charSet.remove('_');
        charSet.remove('?');

        return findReducedWordList(cache, charSet, 0);
    }

    private HashSet<String> findReducedWordList(HashMap<String, WordSetV2> cache, HashSet<Character> charSet, int depth) {
        if(charSet.size() == 0 || depth >= this.CACHE_DEPTH) {
            return this.allWords;
        }

        Character nextChar = charSet.iterator().next();
        charSet.remove(nextChar);

        WordSetV2 cacheValue = cache.get(String.valueOf(nextChar));
        return cacheValue.findReducedWordList(cacheValue.cache, charSet, depth + 1);
    }
}

