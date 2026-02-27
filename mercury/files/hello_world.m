:- module hello_world.

% BEGIN_FRAGLET
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
main(!IO) :-
    io.write_string("Hello World!\n", !IO).
% END_FRAGLET
