%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

F = im2double(imread('.\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif')); % �̹��� read

imfinfo('.\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif') % �̹��� ���� ǥ��

S = F(300:340, 300:340); % �̹��� Ŀ���Ͽ� ǥ�� 
S = im2uint8(S);
figure('Name', 'Cutted','NumberTitle','off'), imshow(S);

F = im2uint8(F); % ��� F�� uint8 ���·� �ٲ�

R = reverse(F); % �̹��� �¿� ����
figure('Name', 'Reversed','NumberTitle','off'), imshow(R)

SD = F.*0.8; % �̹��� �帮�� �ϱ�
figure('Name', 'Blurred','NumberTitle','off'), imshow(SD)

SR = right_shift(F, 3); % �̹��� ����Ʈ
SB = F-SR; % original �̹������� shifted �̹��� ����
figure('Name', 'Subtracted','NumberTitle','off'), imshow(SB)

