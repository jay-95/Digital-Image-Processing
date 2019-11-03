import numpy as np
import cv2

# Read the Image
Im_Fruits = cv2.imread('pepper_noisy_30.png',cv2.IMREAD_GRAYSCALE)

#Zero Padding Function that I Want to Expend
def Zero_Pad1(Image, num):
    Im, In = Image.shape
    A = np.uint8(np.zeros((Im, num)))
    B = np.uint8(np.zeros((num, In+2*(num))))
    R1 = np.concatenate((A, Image, A), axis = 1)
    R2 = np.concatenate((B, R1, B), axis = 0 )
    return R2

# Median Filtering, num is the unit number want to calculate
def Median(Image, num):
    n_mid = num//2
    
    M, N = Image.shape
    Pd_Image = Zero_Pad1(Image, n_mid)
    Im, In = Pd_Image.shape
    R3 = np.empty((M, N), dtype=float)
    for i in range(Im-num+1):
        for j in range(In-num+1):
            R1 = Pd_Image[i:i+num, j:j+num]
            R2 = np.ravel(R1, order='C')
            R2.sort()
            R3[i, j] = R2[(num**2)//2]
    return R3

# Calculate the Median Filtering
Median_Friuits3 = Median(Im_Fruits,3)
Median_Friuits5 = Median(Im_Fruits,5)
Median_Friuits7 = Median(Im_Fruits,7)

# Show  the Images
cv2.imshow("Fruits", Im_Fruits)
cv2.imshow("Median Fruits3", np.uint8(Median_Friuits3))
cv2.imshow("Median Fruits5", np.uint8(Median_Friuits5))
cv2.imshow("Median Fruits7", np.uint8(Median_Friuits7))

cv2.waitKey(0)
cv2.destroyAllWindows()