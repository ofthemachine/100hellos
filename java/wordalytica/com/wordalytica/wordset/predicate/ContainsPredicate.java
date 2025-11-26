package com.wordalytica.wordset.predicate;

public class ContainsPredicate extends AbstractPredicate {
    private final String value;

    public ContainsPredicate(String value) {
        this.value = value;
    }

    @Override
    public boolean matches(String word) {
        return word.contains(this.value);
    }
}
