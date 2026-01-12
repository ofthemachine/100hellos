#!/usr/bin/env raku

# BEGIN_FRAGLET
class Greeting {
  has Str $.who;

  method greet() {
    say "Hello $!who!";
  }
}

my $greeting = Greeting.new(who => "World");
$greeting.greet();
# END_FRAGLET
