function y = Median(x, n) %Median Filtering, x is original image matrix, n is the unit number want to calculate

n_mid = fix(n/2);

%padding the image
x1 = Zero_Pad2(x,n_mid);
[m1, n1] = size(x1);
for i = 1:m1-n+1
    for j = 1:n1-n+1
        x2 = x1(i:i+n-1, j:j+n-1);
        x3 = sort(x2(:));
        y(i, j) = x3((1+n^2)/2);
    end
end
end