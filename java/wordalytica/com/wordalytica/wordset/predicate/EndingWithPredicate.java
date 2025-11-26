package com.wordalytica.wordset.predicate;

public class EndingWithPredicate extends AbstractPredicate {
    private final String value;

    public EndingWithPredicate(String value) {
        this.value = value;
    }

    @Override
    public boolean matches(String word) {
        return word.endsWith(this.value);
    }
}


