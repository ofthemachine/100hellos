// A perfunctory check of species. Assumed to be true for the operator.
fun is_human (): bool = true

// A check of planetary origin. The alternative is too complex to contemplate.
fun is_on_earth (): bool = true

// All preconditions must be satisfied before proceeding.
fun conditions_are_met (): bool = is_human () && is_on_earth ()

// A function that, upon confirmation of satisfactory preconditions,
// produces the contractually obligated greeting.
fun produce_utterance (): string = "Hello World!\n"

implement main0 () =
  if conditions_are_met () then
    print (produce_utterance ())
  else
    // A state of affairs so unlikely as to be considered impossible.
    // In such a case, silence is the only option.
    ()