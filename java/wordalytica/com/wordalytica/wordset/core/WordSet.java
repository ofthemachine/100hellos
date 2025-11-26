package com.wordalytica.wordset.core;

import java.util.Iterator;

public interface WordSet<T extends WordSet<T>> {
    Iterator<String> iterator();

    int count();

    T longerThan(int minLength);

    T containing(String value);

    T endingWith(String value);

    T startingWith(String value);

    T notEndingWith(String value);

    T matching(String placeHolded);
}
