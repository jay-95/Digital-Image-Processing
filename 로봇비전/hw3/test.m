%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

% read the targeted image
IM_Rose = imread('C:\Users\user\OneDrive\���� ȭ��\2019 Ư��, 4�г�\4�г� 2�б�\�κ�����\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif');
Sob_Mask = [1 2 1; 0 0 0; -1 -2 -1];

% padding
PQ = paddedsize(size(IM_Rose));

I = fft2(IM_Rose,PQ(1),PQ(2));
H = fft2(Sob_Mask,PQ(1),PQ(2));

%Real calculation
I1 = I.*H;
I2 = ifft2(I1);

figure, imshow(uint8(I2));