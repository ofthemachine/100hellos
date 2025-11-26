package com.wordalytica.wordset.predicate;

import java.util.HashSet;

public class CompoundPredicate extends AbstractPredicate {

    private final HashSet<Predicate> predicateSet;

    public CompoundPredicate(Predicate predicate) {
        this.predicateSet = new HashSet<>();
        this.predicateSet.add(predicate);
    }

    public CompoundPredicate and(Predicate predicate) {
        predicateSet.add(predicate);
        return this;
    }

    @Override
    public boolean matches(String word) {
        for(Predicate p : predicateSet) {
            if(!p.matches(word)) {
                return false;
            }
        }
        return true;
    }
}
