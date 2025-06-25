USING: combinators io kernel math math.functions sequences ;

! 🚀 FACTOR STACK GYMNASTICS EXTRAVAGANZA! 🎪
! Let's build "Hello World!" in the most unnecessarily awesome way possible!

! Start with our components in reverse order for dramatic effect!
"World!" "Hello"
! Stack: [ "World!" "Hello" ]

! Now let's do some stack acrobatics to get them in the right order
swap
! Stack: [ "Hello" "World!" ]

! Insert a space using Factor's powerful combinators
" " swap append append
! This appends space to "Hello", then appends "World!" to that result
! Stack: [ "Hello World!" ]

! Let's add some mathematical wizardry that ultimately does nothing
! but shows off Factor's computational prowess
69 25 + 42 - dup * sqrt drop
! Calculate (69+25-42), square it, take sqrt, then drop it - pure artistry!

! Create and execute a quotation for maximum Factor-ness
[
    ! Duplicate our string, reverse it twice (because we can!),
    ! then keep only the original - it's like Factor poetry!
    dup [ reverse reverse ] dip drop
] call

! Execute our masterpiece with flourish! 🎭
print

! Factor: where even simple tasks become beautiful stack dances! 💫