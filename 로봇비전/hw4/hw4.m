%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

% read the targeted image
IM_Fruits = imread('C:\Users\user\OneDrive\���� ȭ��\2019 Ư��, 4�г�\4�г� 2�б�\�κ�����\hw4\pepper_noisy_30.png');

%Median Filtering
Median_Friuits3 = Median(IM_Fruits,3);
Median_Friuits5 = Median(IM_Fruits,5);
Median_Friuits7 = Median(IM_Fruits,7);

figure, imshow(IM_Fruits)
figure, imshow(Median_Friuits3)
figure, imshow(Median_Friuits5)
figure, imshow(Median_Friuits7)
