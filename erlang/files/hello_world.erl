% The module name must match the filename, and dashes
% are not supported -- which is why this one has a different
% filename.
-module(hello_world).
% BEGIN_FRAGLET
-export([main/0]).

main() -> io:fwrite("Hello World!\n").
% END_FRAGLET
