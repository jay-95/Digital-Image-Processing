import numpy as np
import cv2

Im_Rose = cv2.imread('Fig0206(a)(rose-original).tif',cv2.IMREAD_GRAYSCALE)
Sob_Mask = np.array(([[1, 2, 1], [0, 0, 0], [-1, -2, -1]]), dtype=float)

# Scale Transform of Image
def Scale(Image):
    Min = np.amin(Image)
    Max = np.amax(Image)
    M, N = Image.shape
    R = np.empty((M, N), dtype=float)
    R = (255/(Max-Min)*(Image-Min))
    return R

# 180 Degree Rotation for Convolution
def Conv_Rev(Mask):
    M, N = Mask.shape
    R = np.empty((M, N), dtype=float)
    for i in range(M):
        for j in range(N):
           R[i, j] = Mask[M-i-1, N-j-1]
    return R

# Zero Padding
def Zero_Pad(Image, Mask):
    Im, In = Image.shape
    M, N = Mask.shape
    A = np.uint8(np.zeros((Im, N-1)))
    B = np.uint8(np.zeros((M-1, In+2*(N-1))))
    R1 = np.concatenate((A, Image, A), axis = 1)
    R2 = np.concatenate((B, R1, B), axis = 0 )
    return R2

# Calculate the Convolution between Image and Mask
def Conv_IM(Image, Mask):
    M1, N1 = Image.shape
    M2, N2 = Mask.shape
    R = np.empty((M1-M2+1, N1-N2+1), dtype=float)
    Image1 = np.double(Image)
    
    for i in range(M1-M2+1):
        for j in range(N1-N2+1):
            R[i, j] = sum(sum(Image1[i:i+M2, j:j+N2]*Mask))
    
    return abs(R)


#Padding
A = np.zeros((3, 2045), dtype=float)
B = np.zeros((2045, 2048), dtype=float)
C= np.zeros((1024, 1024), dtype=float)
D = np.zeros((1024, 2048), dtype=float)
PSob1 = np.concatenate((Sob_Mask, A), axis = 1)
PSob2 = np.concatenate((PSob1, B), axis = 0 )
PI1 = np.concatenate((Im_Rose, C), axis = 1)
PI2 = np.concatenate((PI1, D), axis = 0 )
# Fourier Transform of Mask and Image
I = cv2.dft(np.float64(PI2),flags = cv2.DFT_COMPLEX_OUTPUT)
H = cv2.dft(np.float64(PSob2),flags = cv2.DFT_COMPLEX_OUTPUT)

# Visualization Test
I1_test = np.fft.fftshift(I)
I_test = Scale(cv2.magnitude(I1_test[:,:,0],I1_test[:,:,1]))

H1_test = np.fft.fftshift(H)
H_test = Scale(cv2.magnitude(H1_test[:,:,0],H1_test[:,:,1]))


# Real Calculation
I1 = I1_test*H1_test
I2 = np.fft.ifftshift(I1)
I3 = cv2.idft(I2)
I3 = Scale(cv2.magnitude(I3[:,:,0],I3[:,:,1]))
I3 = I3[0:1024, 0:1024]

# Spatial Filtering
# 180degree Rotation of Sobel Mask
Conv_Sob = Conv_Rev(Sob_Mask)

# Padding the Image with the zero value
Pd_Rose_Sob = Zero_Pad(Im_Rose, Conv_Sob)

# Calculate the Convolution between Rose Image and Sobel Masks
B1Conv_Rose_Sob = Conv_IM(Pd_Rose_Sob, Conv_Sob)

# Cutting the Image that Make Caculated Image into Original Image Size
my, ny = Conv_Sob.shape
my1, ny1 = B1Conv_Rose_Sob.shape
my2, ny2 = my//2, ny//2
B2Conv_Rose_Sob = B1Conv_Rose_Sob[my2:my1-my2, ny2:ny1-ny2]

# Scale Transform the Image
Conv_Rose_Sob = np.uint8(B2Conv_Rose_Sob)

# Show the Image that Calculated

cv2.imshow("FT Image", I_test)
cv2.imshow("FT Mask", H_test)
cv2.imshow("FT Calculated Imgae", np.uint8(I3))
cv2.imshow("Convolution Filtered Image", Conv_Rose_Sob)


cv2.imwrite('I_test.tif', np.uint8(Scale(I_test))) #store the chaged image
cv2.imwrite('H_test.tif', np.uint8(H_test))
cv2.imwrite('I3.tif',np.uint8(I3))
cv2.imwrite('Conv_Rose_Sob.tif', Conv_Rose_Sob)

cv2.waitKey(0)
cv2.destroyAllWindows()