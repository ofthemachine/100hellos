package com.wordalytica.wordset.predicate;

public interface Predicate {
    boolean matches(String word);
    String cacheKey();
    Predicate negate();
}

abstract class AbstractPredicate implements Predicate {
    public abstract boolean matches(String word);

    @Override
    public String cacheKey() {
        return null;
    }

    @Override
    public Predicate negate() {
        return new NegatedPredicate(this);
    }
}