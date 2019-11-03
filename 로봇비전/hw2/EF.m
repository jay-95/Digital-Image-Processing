% x1 is original image and x2 is ETF
function y = EF(x1, x2)
[m, n] = size(x1);
for i = 1:m
    for j = 1:n
        y(i, j) = x2(x1(i, j)+1);
    end
end