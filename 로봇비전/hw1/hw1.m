%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai



F = im2double(imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif')); % read the targeted image

imdata = imfinfo('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif'); % read the precise imformation of image
% extract the information of image from imdata
fprintf('Format of the image = %s\n',imdata.Format)
fprintf('Size of the image = %d\n',imdata.FileSize)
fprintf('Compression of the image = %s\n',imdata.Compression)
fprintf('BPP of the image = %d\n',imdata.BitsPerSample)

S = F(300:340, 300:340); % cut the image
S = im2uint8(S);
figure('Name', 'Cutted','NumberTitle','off'), imshow(S);

F = im2uint8(F); % change a matrix F into an uint8 format

R = reverse(F); % reverse the left and right side of image
figure('Name', 'Reversed','NumberTitle','off'), imshow(R)

SD = F.*0.8; % blur the image
figure('Name', 'Blurred','NumberTitle','off'), imshow(SD)

SR = right_shift(F, 3); % shift the image to the right side, right_shift(Matrix, number wanted to be shifted)
SB = F-SR; % Subtract an original image F to shifted image SR
figure('Name', 'Subtracted','NumberTitle','off'), imshow(SB)