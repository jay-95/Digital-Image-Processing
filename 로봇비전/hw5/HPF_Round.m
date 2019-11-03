function y = HPF_Round(s,r) % Making HPF Mask function, s is size of image and r is radius

Sx = s(1);
Sy = s(2);

Mx = Sx/2;
My = Sy/2;

for i = 1:Sx
    for j = 1:Sy
        R = sqrt((i-Mx).^2 + (j-My).^2);
        if R > r
            y(i,j) = 1;
        else
            y(i,j) = 0;
        end
    end
end