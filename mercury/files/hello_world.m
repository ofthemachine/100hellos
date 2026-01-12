:- module hello_world.

:- interface.
:- import_module io.
:- import_module int.
:- import_module list.
:- import_module string.
:- pred main(io::di, io::uo) is det.

:- implementation.
% BEGIN_FRAGLET
main(!IO) :-
    io.write_string("Hello World!\n", !IO).
% END_FRAGLET