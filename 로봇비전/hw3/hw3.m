%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

IM_Rose = imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif'); % read the targeted image
Gy = [-1 0 1; -2 0 2; -1 0 1];
Gx = [-1 -2 -1; 0 0 0; 1 2 1];

%Make the mask ready to do convolution
Conv_Gy = Conv_rev(Gy);
Conv_Gx = Conv_rev(Gx);

[my, ny] = size(Conv_Gy);
[mx, nx] = size(Conv_Gx);

%Padding the original image
Pd_Rose_Gy = double(Zero_Pad1(IM_Rose, Conv_Gy)); 
Pd_Rose_Gx = double(Zero_Pad1(IM_Rose, Conv_Gx));

%Calculate the convolution
B1Conv_Rose_Gy = Conv_IM(Pd_Rose_Gy, Conv_Gy); 
B1Conv_Rose_Gx = Conv_IM(Pd_Rose_Gx, Conv_Gx);

[my1, ny1] = size(B1Conv_Rose_Gy);
[mx1, nx1] = size(B1Conv_Rose_Gx);

my2 = fix(my/2);
ny2 = fix(ny/2);
mx2 = fix(mx/2);
nx2 = fix(nx/2);

%Cut the image as original size
B2Conv_Rose_Gy = B1Conv_Rose_Gy(1+my2:my1-my2, 1+ny2:ny1-ny2); 
B2Conv_Rose_Gx = B1Conv_Rose_Gx(1+mx2:mx1-mx2, 1+nx2:nx1-nx2);

%Scaling Process
Min1 = min(min(B2Conv_Rose_Gy));
Max1 = max(max(B2Conv_Rose_Gy));

Min2 = min(min(B2Conv_Rose_Gx));
Max2 = max(max(B2Conv_Rose_Gx));

Conv_Rose_Gy = Scale(B2Conv_Rose_Gy, Max1, Min1);
Conv_Rose_Gx = Scale(B2Conv_Rose_Gx, Max2, Min2);

%Combine the result of vertical and horizontal convolution
Gy1 = Conv_Rose_Gy;
Gx1 = Conv_Rose_Gx;

Conv_Rose = uint8(sqrt((Gy1).^2+(Gx1).^2));

%Show the Images
figure, imshow(IM_Rose)
figure, imshow(uint8(Conv_Rose_Gx))
figure, imshow(uint8(Conv_Rose_Gy))
figure, imshow(uint8(B2Conv_Rose_Gx))
figure, imshow(uint8(B2Conv_Rose_Gy))
figure, imshow(Conv_Rose)