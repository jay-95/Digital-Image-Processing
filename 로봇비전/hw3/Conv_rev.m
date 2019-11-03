function y = Conv_rev(x) %Function that makes mask reversed vertically and horizontally
[m, n] = size(x);
for i = 1:m
    for j = 1:n
        y(i, j) = x(m-i+1, n-j+1);
    end
end
end