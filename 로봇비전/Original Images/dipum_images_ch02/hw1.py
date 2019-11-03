import numpy as np
import cv2
from PIL import Image

def reverse(Matrix1):
    M1, N1 = Matrix1.shape
    A1 = np.uint8(np.zeros((M1,N1)))
    for i in range(M1):
        for j in range(N1//2):
           S1 = Matrix1[i, j]
           S2 = Matrix1[i, N1-j-1]
           A1[i, N1-j-1] = S1
           A1[i, j] = S2
    return A1

def  right_shift(Matrix2, num):
    M2, N2 = Matrix2.shape
    A2 = np.uint8(np.zeros((M2,N2)))
    for k in range(M2):
        for l in range(N2-num-1,-1,-1):
            A2[k, l+num] = Matrix2[k, l]
    return A2

def minus_flow(Matrix3,Matrix4): #because if some value suffer overflow or underflow, it designate worng value, I use function the classify the case
    M3, N3 = Matrix3.shape
    A3 = np.uint8(np.zeros((M3,N3)))
    for m in range(M3):
        for n in range(N3):
            if Matrix3[m, n] < Matrix4[m, n]:
                A3[m, n] = 0            
                continue
            A3[m, n] = Matrix3[m, n] - Matrix4[m, n]
    return A3

F = cv2.imread('Fig0206(a)(rose-original).tif',cv2.IMREAD_GRAYSCALE)
S = F[299:340, 299:340] #also can be done by using or operation between F and filter imgae(299~339 white, others black)
R = reverse(F)
SD = cv2.multiply(F,0.8) #If i just muliply it, type of array and its element is not matched. That's why I use cvfunction
SR = right_shift(F,3)
SB = minus_flow(F,SR)

row, col = F.shape

img = Image.open('Fig0206(a)(rose-original).tif') #image information
print(img.format)
print(img.size)
print(img.filename)


cv2.imshow('Rose', F)
cv2.imshow('Cutted', S)
cv2.imshow('Reversed',R)
cv2.imshow('Blurred', SD)
cv2.imshow('Outline', SB)

cv2.imwrite('Rose.tif', F) #store the chaged image
cv2.imwrite('Cutted.tif', S)
cv2.imwrite('Reversed.tif',R)
cv2.imwrite('Blurred.tif', SD)
cv2.imwrite('Outline.tif', SB)
cv2.waitKey(0)
cv2.destroyAllWindows()
