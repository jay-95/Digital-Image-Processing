IM_Pollen = imread('C:\Users\user\OneDrive\바탕 화면\4학년 2학기\로봇비전\Original Images\dipum_images_ch03\Fig0308(a)(pollen).tif'); % read the targeted image
P_Pollen = imhist(IM_Pollen);

Min = min(find(P_Pollen))-1; %also can be done using min and max value of IM_Pollen
Max = max(find(P_Pollen))-1; %the reason of -1 is that array in matlab start to calculate the index of array as 1 

IMScale_Pollen = Scale(IM_Pollen, Max, Min);
PScale_Pollen = imhist(IMScale_Pollen);

figure(1);
subplot(1,2,1);
imhist(IM_Pollen)
subplot(1,2,2);
imhist(IMScale_Pollen)
figure(3);
subplot(1,2,1);
imshow(IM_Pollen)
subplot(1,2,2);
imshow(IMScale_Pollen)