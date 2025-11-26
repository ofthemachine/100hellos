package com.wordalytica.wordset.predicate;

public class MatchingPredicate extends AbstractPredicate {
    private final String placeHolded;

    public MatchingPredicate(String placeHolded) {
        this.placeHolded = placeHolded;
    }

    @Override
    public boolean matches(String string) {
        if(string.length() != placeHolded.length()) {
            return false;
        }
        for (int i = 0; i < string.length(); i++) {
            char placeholder = placeHolded.charAt(i);
            if('_' == placeholder || '?' == placeholder) {
                continue;
            }
            if(placeholder != string.charAt(i)) {
                return false;
            }
        }
        return true;
    }
}
