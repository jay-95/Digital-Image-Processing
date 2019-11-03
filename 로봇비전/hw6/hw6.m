%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

% read the targeted image
IM_Rose = imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif');
Sob_Mask = [1 2 1; 0 0 0; -1 -2 -1];

% padding
[A, B] = size (IM_Rose);
[C, D] = size(Sob_Mask);

PSob1 = [Sob_Mask zeros(C, B-D)];
PSob2 = [PSob1; zeros(A-C, B)];

% FastFourier Transform
I = fft2(IM_Rose);
H = fft2(PSob2);

%Visualize test
I1_test = abs(I);
I2_test = Scale(I1_test, max(max(I1_test)), min(min(I1_test)));
I_test = fftshift(I2_test);


H1_test = abs(H);
H2_test = Scale(H1_test, max(max(H1_test)), min(min(H1_test)));
H_test = fftshift(H2_test);

%Real calculation
I1 = I.*H;
I2 = ifft2(I1);


%Spatial Filtering
Conv_Sob = Conv_rev(Sob_Mask);
[mx, nx] = size(Conv_Sob);

Pd_Rose_Sob = double(Zero_Pad1(IM_Rose, Conv_Sob));
B1Conv_Rose_Sob = Conv_IM(Pd_Rose_Sob, Conv_Sob);
[mx1, nx1] = size(B1Conv_Rose_Sob);

mx2 = fix(mx/2);
nx2 = fix(nx/2);

B2Conv_Rose_Sob = B1Conv_Rose_Sob(1+mx2:mx1-mx2, 1+nx2:nx1-nx2);

Min1 = min(min(B2Conv_Rose_Sob));
Max1 = max(max(B2Conv_Rose_Sob));

Conv_Rose_Sob = Scale(B2Conv_Rose_Sob, Max1, Min1);

figure, imshow(I_test)
figure, imshow(H2_test)
figure, imshow(uint8(I2));
figure, imshow(uint8(Conv_Rose_Sob))