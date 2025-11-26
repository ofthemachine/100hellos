package com.wordalytica.wordset.predicate;

public class CharAtPredicate extends AbstractPredicate {
    private final char character;
    private final int position;

    public CharAtPredicate(char character, int position) {
        this.character = character;
        this.position = position;
    }

    @Override
    public boolean matches(String word) {
        return position >= 0
                && position < word.length()
                && word.charAt(position) == character;
    }
}

