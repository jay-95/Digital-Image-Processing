import numpy as np
import cv2
from matplotlib import pyplot as plt

# Read the Image
Im_Rose = cv2.imread('Fig0206(a)(rose-original).tif',cv2.IMREAD_GRAYSCALE)

S_Rose = Im_Rose.shape

# Scale Transform of Image
def Scale(Image):
    Min = np.amin(Image)
    Max = np.amax(Image)
    M, N = Image.shape
    R = np.empty((M, N), dtype=float)
    R = (255/(Max-Min)*(Image-Min))
    return R

# Function that Makes Circle Shaped LPF Mask
def LPF_Round(Im_Size, Radius):
    Sx = Im_Size[0]
    Sy = Im_Size[1]
    
    Mx = Sx//2
    My = Sy//2
    
    R1 = np.empty((Sx, Sy, 2), dtype = float)
    
    for i in range(Sx):
        for j in range(Sy):
            R = ((i-Mx)**2 + (j-My)**2)**0.5
            if R > Radius:
                R1[i, j] = 0
            else:
                R1[i, j] = 1
                
    return R1

# Function that Makes Circle Shaped HPF Mask
def HPF_Round(Im_Size, Radius):
    Sx = Im_Size[0]
    Sy = Im_Size[1]
    
    Mx = Sx//2
    My = Sy//2
    
    R1 = np.empty((Sx, Sy, 2), dtype = float)
    
    for i in range(Sx):
        for j in range(Sy):
            R = ((i-Mx)**2 + (j-My)**2)**0.5
            if R > Radius:
                R1[i, j] = 1
            else:
                R1[i, j] = 0
                
    return R1


# LPF
# Visualizing Test
LFT_Rose1 = cv2.dft(np.float64(Im_Rose),flags = cv2.DFT_COMPLEX_OUTPUT)
LFT_Rose2 = np.fft.fftshift(LFT_Rose1)
LFTS_Rose_test = Scale(cv2.magnitude(LFT_Rose2[:,:,0],LFT_Rose2[:,:,1]))

LR_Mask = LPF_Round(S_Rose,50)
LF_Rose_test = LFTS_Rose_test*LR_Mask[:,:,0]

# Real LPF Mask Filtering in Frequency Domain
LFTS_Rose = np.fft.fftshift(LFT_Rose1)
LF_Rose = LFTS_Rose*LR_Mask
LF_Rose1 = np.fft.ifftshift(LF_Rose)
LPF_Rose = cv2.idft(LF_Rose1)
LPF_Rose = cv2.magnitude(LPF_Rose[:,:,0],LPF_Rose[:,:,1])

# HPF
# Visualizing Test
HFT_Rose1 = cv2.dft(np.float64(Im_Rose),flags = cv2.DFT_COMPLEX_OUTPUT)
HFT_Rose2 = np.fft.fftshift(HFT_Rose1)
HFTS_Rose_test = Scale(cv2.magnitude(HFT_Rose2[:,:,0],HFT_Rose2[:,:,1]))

HR_Mask = HPF_Round(S_Rose,50)
HF_Rose_test = HFTS_Rose_test*HR_Mask[:,:,0]

# Real HPF Mask Filtering in Frequency Domain
HFTS_Rose = np.fft.fftshift(HFT_Rose1)
HF_Rose = HFTS_Rose*HR_Mask
HF_Rose1 = np.fft.ifftshift(HF_Rose)
HPF_Rose = cv2.idft(HF_Rose1)
HPF_Rose = cv2.magnitude(HPF_Rose[:,:,0],HPF_Rose[:,:,1])


# Show  the Images

"""
plt.figure(1),plt.imshow(LFTS_Rose_test, cmap = 'gray')
plt.xticks([]), plt.yticks([])
plt.figure(2),plt.imshow(LF_Rose_test, cmap = 'gray')
plt.xticks([]), plt.yticks([])
plt.figure(3),plt.imshow(LPF_Rose, cmap = 'gray')
plt.xticks([]), plt.yticks([])
plt.figure(4),plt.imshow(HF_Rose_test, cmap = 'gray')
plt.xticks([]), plt.yticks([])
plt.figure(5),plt.imshow(HPF_Rose, cmap = 'gray')
plt.xticks([]), plt.yticks([])

plt.show()
"""
LPF_Rose1 = Scale(LPF_Rose)
HPF_Rose1 = Scale(HPF_Rose)
cv2.imshow("1", LFTS_Rose_test)
cv2.imshow("2", LF_Rose_test)
cv2.imshow("3", np.uint8(LPF_Rose1))
cv2.imshow("4", HF_Rose_test)
cv2.imshow("5", np.uint8(HPF_Rose1))


cv2.waitKey(0)
cv2.destroyAllWindows()