package com.wordalytica.wordset.predicate;

public class StartingWithPredicate extends AbstractPredicate {
    private final String value;

    public StartingWithPredicate(String value) {
        this.value = value;
    }

    @Override
    public boolean matches(String word) {
        return word.startsWith(this.value);
    }
}
