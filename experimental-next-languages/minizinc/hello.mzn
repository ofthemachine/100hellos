% MiniZinc Hello World - N-Queens Problem
% This demonstrates constraint programming by solving the classic N-Queens problem

int: n = 4; % Size of chessboard (4x4 for quick solving)

% Decision variables: queen positions
array [1..n] of var 1..n: queens;

% Constraints
constraint alldifferent(queens); % No two queens in same row
constraint alldifferent(i in 1..n)(queens[i] + i); % No two queens on same diagonal
constraint alldifferent(i in 1..n)(queens[i] - i); % No two queens on same anti-diagonal

% Solve and output
solve satisfy;

output ["Hello from MiniZinc constraint programming!\n"] ++
       ["N-Queens solution for n=", show(n), ":\n"] ++
       ["Queens positions: ", show(queens), "\n"] ++
       ["Board representation:\n"] ++
       [if j == 1 then "Row " ++ show(i) ++ ": " else "" endif ++
        if queens[i] == j then "Q " else ". " endif ++
        if j == n then "\n" else "" endif
        | i in 1..n, j in 1..n];