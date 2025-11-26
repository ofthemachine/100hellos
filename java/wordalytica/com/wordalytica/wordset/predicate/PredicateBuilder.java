package com.wordalytica.wordset.predicate;

public class PredicateBuilder {
    private CompoundPredicate predicate;

    public PredicateBuilder() {
        this.predicate = new CompoundPredicate(new NullPredicate());
    }

    public PredicateBuilder longerThan(int minLength) {
        this.predicate.and(new RangePredicate(minLength + 1, Integer.MAX_VALUE));
        return this;
    }

    public PredicateBuilder containing(String value) {
        this.predicate.and(new ContainsPredicate(value));
        return this;
    }

    public PredicateBuilder endingWith(String value) {
        this.predicate.and(new EndingWithPredicate(value));
        return this;
    }

    public PredicateBuilder startingWith(String value) {
        this.predicate.and(new StartingWithPredicate(value));
        return this;
    }

    public PredicateBuilder notEndingWith(String value) {
        this.predicate.and(new EndingWithPredicate(value).negate());
        return this;
    }

    public PredicateBuilder notContaining(String value) {
        this.predicate.and(new ContainsPredicate(value).negate());
        return this;
    }

    public PredicateBuilder matching(String placeHolded) {
        this.predicate.and(new MatchingPredicate(placeHolded));
        return this;
    }

    public PredicateBuilder withCharAt(char c, int position) {
        this.predicate.and(new CharAtPredicate(c, position));
        return this;
    }

    public PredicateBuilder withoutCharAt(char c, int position) {
        this.predicate.and(new CharAtPredicate(c, position).negate());
        return this;
    }

    public Predicate build() {
        return this.predicate;
    }
}