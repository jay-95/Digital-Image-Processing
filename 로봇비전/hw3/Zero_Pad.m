function y = Zero_Pad(x1, x2) %Zero Padding, x1 is original image matrix, x2 is mask matrix
[m1, n1] = size(x1);
[m2, n2] = size(x2);
m3 = m1+2*(m2-1);
n3 = n1+2*(n2-1);
y = zeros(m3, n3);
for i = 1:m1
    for j = 1:n1
        y(i+m2-1, j+n2-1) = x1(i, j);
    end
end
end