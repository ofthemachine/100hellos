package com.wordalytica.wordset;

import com.wordalytica.wordset.core.WordSet;
import com.wordalytica.wordset.v0.WordSetNoop;
import com.wordalytica.wordset.v1.WordSetV1;
import com.wordalytica.wordset.v2.WordSetV2;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;

public class WordSetFactory {
    private WordSetFactory() {
    }

    public static WordSet<?> buildNoop() {
        return new WordSetNoop();
    }

    public static WordSet<?> build(Object caller, String resource, Integer version) {
        InputStream inputStream = caller.getClass().getClassLoader().getResourceAsStream(resource);
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        Stream<String> words = reader.lines().map(s -> s.toLowerCase().trim());
        return build(words.iterator(), version);
    }

    public static WordSet<?> build(Iterator<String> words, Integer version) {
        switch(version) {
            case 0: return new WordSetNoop();
            case 1: return new WordSetV1(words);
            default: return new WordSetV2(words);
        }
    }

    public static WordSet<?> build(WordSet<?> source, Integer version) {
        return build(source.iterator(), version);
    }

    public static WordSet<?> build(List<String> words, Integer version) {
        return build(words.iterator(), version);
    }
}
