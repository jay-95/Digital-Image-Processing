import numpy as np
import cv2

# Read the Image
Im_Rose = cv2.imread('Fig0206(a)(rose-original).tif',cv2.IMREAD_GRAYSCALE)

# Sobel Mask
Gy = np.double([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])
Gx = np.double([[-1, -2, -1], [0, 0, 0], [1, 2, 1]])


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


# Scale Transform of Image
def Scale(Image):
    Min = np.amin(Image)
    Max = np.amax(Image)
    M, N = Image.shape
    R = np.empty((M, N), dtype=float)
    R = (255/(Max-Min)*(Image-Min))
    return R


# 180degree Rotation of Sobel Mask
Conv_Gy = Conv_Rev(Gy)
Conv_Gx = Conv_Rev(Gx)

# Padding the Image with the zero value
Pd_Rose_Gy = Zero_Pad(Im_Rose, Gy)
Pd_Rose_Gx = Zero_Pad(Im_Rose, Gx)

# Calculate the Convolution between Rose Image and Sobel Masks
B1Conv_Rose_Gy = Conv_IM(Pd_Rose_Gy, Conv_Gy) 
B1Conv_Rose_Gx = Conv_IM(Pd_Rose_Gx, Conv_Gx)

my, ny = Gy.shape
mx, nx = Gx.shape

my1, ny1 = B1Conv_Rose_Gy.shape
mx1, nx1 = B1Conv_Rose_Gx.shape

my2, ny2 = my//2, ny//2
mx2, nx2 = mx//2, nx//2

# Cutting the Image that Make Caculated Image into Original Image Size
B2Conv_Rose_Gy = B1Conv_Rose_Gy[my2:my1-my2, ny2:ny1-ny2]
B2Conv_Rose_Gx = B1Conv_Rose_Gx[mx2:mx1-mx2, nx2:nx1-nx2]

# Scale Transform
Conv_Rose_Gy = Scale(B2Conv_Rose_Gy)
Conv_Rose_Gx = Scale(B2Conv_Rose_Gx)

# Combine the Vertical and Horizontal Image
Gy1 = Conv_Rose_Gy
Gx1 = Conv_Rose_Gx

Conv_Rose = np.uint8((Gy1**2+(Gx1)**2)**0.5);

# Show the Image that Calculated
cv2.imshow("Rose", Im_Rose)
cv2.imshow("Vertical Direction Edge of Rose", np.uint8(Conv_Rose_Gy))
cv2.imshow("Horizontal Direction Edge of Rose", np.uint8(Conv_Rose_Gx))
cv2.imshow("Not Scaled 1", np.uint8(B2Conv_Rose_Gy))
cv2.imshow("Not Scaled 2", np.uint8(B2Conv_Rose_Gx))
cv2.imshow("Edge Detected Rose", Conv_Rose)

cv2.waitKey(0)
cv2.destroyAllWindows()
