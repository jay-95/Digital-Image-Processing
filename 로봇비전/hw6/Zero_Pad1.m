function y = Zero_Pad1(x1, x2) %Zero Padding, x1 is original image matrix, x2 is mask matrix
[m1, n1] = size(x1);
[m2, n2] = size(x2);
A = [zeros(m1,n2-1) x1 zeros(m1,n2-1)];
y = [zeros(m2-1,n1+2*(n2-1)); A; zeros(m2-1,n1+2*(n2-1))];
end