#!/usr/bin/env pil

# PicoLisp: Where simplicity meets power
# Let's build "Hello World!" the PicoLisp way!

# Define a function that reverses and unreverses for fun
(de scramble-unscramble (Lst)
   (reverse (reverse Lst)) )

# Create our message as a list of characters, then join them
(de build-greeting ()
   (pack
      (scramble-unscramble
         (chop "Hello World!") ) ) )

# Use PicoLisp's functional style with apply
(de celebrate-minimalism ()
   (let Message (build-greeting)
      (prinl Message) ) )

# Execute with style - showing off PicoLisp's elegant simplicity
(prinl "Hello World!")

# PicoLisp philosophy: Less is more!
(bye)