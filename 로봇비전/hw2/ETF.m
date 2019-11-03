%Equalize Transform Fuction, x is histogram value
function y = ETF(x)
m = size(x);
sum = 0;
for i = 1:m
    sum = sum+x(i);
    y(i,1) = sum;
end
end
