%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

IM_Pollen = imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch03\Fig0308(a)(pollen).tif'); % read the targeted image
IM_Moon = imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch03\Fig0310(a)(Moon Phobos).tif');


P_Pollen = imhist(IM_Pollen);
P_Moon = imhist(IM_Moon);

%Find Max and Min value of Pollen Image
Min1 = min(find(P_Pollen))-1; %also can be done using min and max value of IM_Pollen
Max1 = max(find(P_Pollen))-1; %the reason of -1 is that array in matlab start to calculate the index of array as 1 

%Find Max and Min value of Moon Image
Min2 = min(find(P_Moon))-1;
Max2 = max(find(P_Moon))-1;

IMScale_Pollen = Scale(IM_Pollen, Max1, Min1);
IMScale_Moon = Scale(IM_Moon, Max2, Min2);

PScale_Pollen = imhist(IMScale_Pollen);
PScale_Moon = imhist(IMScale_Moon);

[m1, n1] = size(IM_Pollen);
[m2, n2] = size(IM_Moon);

ETF_Pollen = ETF(P_Pollen)./(m1.*n1).*255;
ETF_Moon = ETF(P_Moon)./(m2.*n2).*255;

EF_Pollen = uint8(EF(IM_Pollen, ETF_Pollen));
EF_Moon = uint8(EF(IM_Moon, ETF_Moon));

CEF_Pollen = histeq(IM_Pollen, 256);
CEF_Moon = histeq(IM_Moon, 256);

% Compare the histogram of Original Image and scale transformed Image
figure(1);
subplot(1,2,1);
imhist(IM_Pollen)
title('Original Image of Pollen')
subplot(1,2,2);
imhist(IMScale_Pollen)
title('Scale transformed Image of Pollen')


figure(2);
subplot(1,2,1);
imhist(IM_Moon)
title('Original Image of the Moon')
subplot(1,2,2);
imhist(IMScale_Moon)
title('Scale transformed Image of the Moon')

% Compare the Original Image and scale transformed Image
figure(3);
subplot(1,2,1);
imshow(IM_Pollen)
title('Original Image of Pollen')
subplot(1,2,2);
imshow(IMScale_Pollen)
title('Scale transformed Image of Pollen')

figure(4)
subplot(1,2,1);
imshow(IM_Moon)
title('Original Image of the Moon')
subplot(1,2,2);
imshow(IMScale_Moon)
title('Scale transformed Image of the Moon')

% Compare the histogram of Original Image and equalized Image
figure(5);
subplot(1,2,1);
imhist(IM_Pollen)
title('Original Image of Pollen')
subplot(1,2,2);
imhist(EF_Pollen)
title('Equalized Image of Pollen')

figure(6);
subplot(1,2,1);
imhist(IM_Moon)
title('Original Image of the Moon')
subplot(1,2,2);
imhist(EF_Moon)
title('Equalized Image of the Moon')


% Compare the Original Image and equalized Image
figure(7);
subplot(1,2,1);
imshow(IM_Pollen)
title('Original Image of Pollen')
subplot(1,2,2);
imshow(EF_Pollen)
title('Equalized Image of Pollen')

figure(8);
subplot(1,2,1);
imshow(IM_Moon)
title('Original Image of the Moon')
subplot(1,2,2);
imshow(EF_Moon)
title('Equalized Image of the Moon')

%Compare whether equalization that I made is correct or not
figure(9)
subplot(1,2,1);
imhist(EF_Pollen)
title('Equalization Fuction I made')
subplot(1,2,2);
imhist(CEF_Pollen)
title('Equalization Fuction')

figure(10)
subplot(1,2,1);
imhist(EF_Moon)
title('Equalization Fuction I made')
subplot(1,2,2);
imhist(CEF_Moon)
title('Equalization Fuction')

figure(11)
subplot(1,2,1);
imshow(EF_Pollen)
title('Equalization Fuction I made')
subplot(1,2,2);
imshow(CEF_Pollen)
title('Equalization Fuction')

figure(12)
subplot(1,2,1);
imshow(EF_Moon)
title('Equalization Fuction I made')
subplot(1,2,2);
imshow(CEF_Moon)
title('Equalization Fuction')
