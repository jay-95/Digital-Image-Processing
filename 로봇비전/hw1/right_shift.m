function y = right_shift(x, a) %Shift the Matrix x a space to the right
[m, n] = size(x);
for i = 1:m
    for j = 1:n-a
       y(i, j+a) = x(i, j);
    end
end
end