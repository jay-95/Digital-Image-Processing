% Scaling transformation function
function y = Scale(x, max_value, min_value) %x is image matrix
y = (255/(max_value-min_value)*(x-min_value));
end
