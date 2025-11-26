package com.wordalytica.wordset.v1;

import com.wordalytica.wordset.predicate.Predicate;

import java.util.HashSet;
import java.util.Iterator;

public class WordSetV1 extends AbstractWordSet {
    private HashSet<String> words;

    public WordSetV1(Iterator<String> words) {
        this.words = new HashSet<>();
        words.forEachRemaining(this.words::add);
    }

    @Override
    public Iterator<String> iterator() {
        return getFilteredWords().iterator();
    }

    @Override
    public int count() {
        return getFilteredWords().size();
    }

    private HashSet<String> getFilteredWords() {
        HashSet<String> filteredWords = new HashSet<>(words);
        Predicate predicate = this.predicate(true);
        filteredWords.removeIf((s) -> !predicate.matches(s));
        return filteredWords;
    }
}

