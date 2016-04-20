function new = insertrow(A, r, n)
    tmp1 = A(1:(n-1), :);
    tmp2 = A(n:end, :);
    new = [tmp1; r; tmp2];
