%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

F = im2double(imread('.\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif')); % 이미지 read

imfinfo('.\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif') % 이미지 정보 표시

S = F(300:340, 300:340); % 이미지 커팅하여 표시 
S = im2uint8(S);
figure('Name', 'Cutted','NumberTitle','off'), imshow(S);

F = im2uint8(F); % 행렬 F를 uint8 형태로 바꿈

R = reverse(F); % 이미지 좌우 반전
figure('Name', 'Reversed','NumberTitle','off'), imshow(R)

SD = F.*0.8; % 이미지 흐리게 하기
figure('Name', 'Blurred','NumberTitle','off'), imshow(SD)

SR = right_shift(F, 3); % 이미지 시프트
SB = F-SR; % original 이미지에서 shifted 이미지 빼기
figure('Name', 'Subtracted','NumberTitle','off'), imshow(SB)

