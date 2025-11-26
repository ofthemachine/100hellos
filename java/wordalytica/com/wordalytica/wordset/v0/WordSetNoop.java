package com.wordalytica.wordset.v0;

import com.wordalytica.wordset.core.WordSet;

import java.util.Collections;
import java.util.Iterator;

// This class should serve as the lower bound for performance measure. We'll never beat
// the speed of this class.
public class WordSetNoop implements WordSet<WordSetNoop> {
    @Override
    public Iterator<String> iterator() {
        return Collections.emptyIterator();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public WordSetNoop longerThan(int minLength) {
        return this;
    }

    @Override
    public WordSetNoop containing(String value) {
        return this;
    }

    @Override
    public WordSetNoop endingWith(String value) {
        return this;
    }

    @Override
    public WordSetNoop startingWith(String value) {
        return this;
    }

    @Override
    public WordSetNoop notEndingWith(String value) {
        return this;
    }

    @Override
    public WordSetNoop matching(String placeHolded) {
        return this;
    }
}
