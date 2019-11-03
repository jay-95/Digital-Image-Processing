function y = Conv_IM(x1, x2) %Convolution filtering function, x1 is padded image matrix, x2 is mask matrix
[m1, n1] = size(x1);
[m2, n2] = size(x2);

for i = 1:m1-m2+1
    for j = 1:n1-n2+1
        y(i, j) = sum(sum(x1(i:i+m2-1, j:j+n2-1).*x2));
    end
end
y = abs(y);
end