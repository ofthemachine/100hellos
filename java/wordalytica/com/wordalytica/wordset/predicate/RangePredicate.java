package com.wordalytica.wordset.predicate;

public class RangePredicate extends AbstractPredicate {
    private final int minLength;
    private final int maxLength;

    // minLength <= string.length() <= maxLength
    public RangePredicate(int minLength, int maxLength) {
        this.minLength = minLength;
        this.maxLength = maxLength;
    }

    @Override
    public boolean matches(String word) {
        return minLength <= word.length() && word.length() <= maxLength;
    }
}
