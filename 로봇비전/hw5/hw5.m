%%% Robot Vision%%%
%%% Dept. of Electronic Engineering
%%% 201314651 Lee Wonjai

% read the targeted image
IM_Rose = imread('C:\Users\user\OneDrive\바탕 화면\2019 특별, 4학년\4학년 2학기\로봇비전\Original Images\dipum_images_ch02\Fig0206(a)(rose-original).tif');

% Size of Image
S_Rose = size(IM_Rose);

%LPF
% Visualizing Test
LFT_Rose1 = fft2(IM_Rose);
LFT_Rose2 = abs(LFT_Rose1);
LFT_Rose3 = Scale(LFT_Rose2, max(max(LFT_Rose2)), min(min(LFT_Rose2)));
LFTS_Rose_test = fftshift(LFT_Rose3);


LR_Mask = LPF_Round(S_Rose,50);
LF_Rose_test = LFTS_Rose_test.*LR_Mask;

% Real Mask Filtering in Frequency Domain
LFTS_Rose = fftshift(LFT_Rose1);
LF_Rose = LFTS_Rose.*LR_Mask;
LF_Rose1 = ifftshift(LF_Rose);
LPF_Rose = uint8(ifft2(LF_Rose1));

%HPF
% Visualizing Test
HFT_Rose1 = fft2(IM_Rose);
HFT_Rose2 = abs(HFT_Rose1);
HFT_Rose3 = Scale(HFT_Rose2, max(max(HFT_Rose2)), min(min(HFT_Rose2)));
HFTS_Rose_test = fftshift(HFT_Rose3);

HR_Mask = HPF_Round(S_Rose,50);
HF_Rose_test = HFTS_Rose_test.*HR_Mask;

% Real Mask Filtering in Frequency Domain
HFTS_Rose = fftshift(HFT_Rose1);
HF_Rose = HFTS_Rose.*HR_Mask;
HF_Rose1 = ifftshift(HF_Rose);
HPF_Rose = uint8(ifft2(HF_Rose1));

figure, imshow(LFTS_Rose_test)
figure, imshow(LF_Rose_test)
figure, imshow(LPF_Rose)
figure, imshow(HF_Rose_test)
figure, imshow(HPF_Rose)