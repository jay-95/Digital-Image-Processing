function y = reverse(x) %Make the right and left side of matrix reversed
[m, n] = size(x);
for i = 1:m
    for j = 1:fix(n/2)
        S1 = x(i, j);
        S2 = x(i, n-j+1);
        y(i, j) = S2;
        y(i, n-j+1) = S1;
    end
end
end