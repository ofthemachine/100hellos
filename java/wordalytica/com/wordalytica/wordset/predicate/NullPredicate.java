package com.wordalytica.wordset.predicate;

public class NullPredicate extends AbstractPredicate {
    @Override
    public boolean matches(String word) {
        return true;
    }
}
