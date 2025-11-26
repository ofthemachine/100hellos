package com.wordalytica.wordset.predicate;

public class NegatedPredicate extends AbstractPredicate {
    private final Predicate predicate;

    public NegatedPredicate(Predicate predicate) {
        this.predicate = predicate;
    }

    @Override
    public boolean matches(String word) {
        return !predicate.matches(word);
    }

    @Override
    public String cacheKey() {
        if(null == predicate.cacheKey()) {
            return null;
        }
        return "not-" + predicate.cacheKey();
    }
}
