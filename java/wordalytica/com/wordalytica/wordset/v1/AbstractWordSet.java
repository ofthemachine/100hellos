package com.wordalytica.wordset.v1;

import com.wordalytica.wordset.core.WordSet;
import com.wordalytica.wordset.predicate.Predicate;
import com.wordalytica.wordset.predicate.PredicateBuilder;

public abstract class AbstractWordSet<T extends WordSet<T>> implements WordSet<T> {
    private PredicateBuilder predicateBuilder;

    public AbstractWordSet() {
        this.predicateBuilder = new PredicateBuilder();
    }

    protected Predicate predicate() {
        return predicate(false);
    }

    protected Predicate predicate(boolean reset) {
        Predicate predicate = this.predicateBuilder.build();
        PredicateBuilder builder = this.predicateBuilder;
        if(reset) {
            builder = new PredicateBuilder();
        }
        this.predicateBuilder = builder;
        return predicate;
    }

    @Override
    public T longerThan(int minLength) {
        this.predicateBuilder.longerThan(minLength);
        return (T)this;
    }

    @Override
    public T containing(String value) {
        this.predicateBuilder.containing(value);
        return (T)this;
    }

    @Override
    public T endingWith(String value) {
        this.predicateBuilder.endingWith(value);
        return (T)this;
    }

    @Override
    public T startingWith(String value) {
        this.predicateBuilder.startingWith(value);
        return (T)this;
    }

    @Override
    public T notEndingWith(String value) {
        this.predicateBuilder.notEndingWith(value);
        return (T)this;
    }

    @Override
    public T matching(String placeHolded) {
        this.predicateBuilder.matching(placeHolded);
        return (T)this;
    }
}
