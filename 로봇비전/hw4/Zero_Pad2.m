function y = Zero_Pad2(x, n) %Zero Padding, x is original image matrix, n is the number want to expand the matrix
[m1, n1] = size(x);
A = [zeros(m1,n) x zeros(m1,n)];
y = [zeros(n,n1+2*n); A; zeros(n,n1+2*n)];
end