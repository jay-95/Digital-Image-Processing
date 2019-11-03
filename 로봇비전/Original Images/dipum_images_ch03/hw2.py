import cv2
import numpy as np
import random
from matplotlib import pyplot as plt

#Read the Images
Im_Pollen = cv2.imread('Fig0308(a)(pollen).tif',cv2.IMREAD_UNCHANGED)
Im_Moon = cv2.imread('Fig0310(a)(Moon Phobos).tif',cv2.IMREAD_UNCHANGED)


#Make Histogram Matrix
Hist_Pollen = cv2.calcHist([Im_Pollen],[0],None,[256],[0,256])
Hist_Moon = cv2.calcHist([Im_Moon],[0],None,[256],[0,256])


#Scale Transformation Function
def Scale(Matrix1):
    Min = np.amin(Matrix1)
    Max = np.amax(Matrix1)
    M1, N1 = Matrix1.shape
    A1 = np.zeros((M1,N1))
    A1 = (255/(Max-Min)*(Matrix1-Min))
    return A1


#Equalize Transform Fuction
def ETF(Histogram1):
    M2, N2 = Histogram1.shape
    Sum = 0
    A2 = np.zeros((M2,N2))
    for i in range(0,M2):
        Sum = Sum + Histogram1[i]
        A2[i] = Sum
    return A2

#Function that helps to make image equilized
def EF(Orig_Image, ETF1):
    M3, N3 = Orig_Image.shape
    A3 = np.zeros((M3,N3))
    for j in range(M3):
        for k in range(N3):
            A3[j, k] = ETF1[Orig_Image[j, k]]
    return A3

#Scale Transformation
SIm_Pollen = np.uint8(Scale(Im_Pollen))
SIm_Moon = np.uint8(Scale(Im_Moon))

#Histogram of Scaled Images
Hist_SPollen = cv2.calcHist([SIm_Pollen],[0],None,[256],[0,256])
Hist_SMoon = cv2.calcHist([SIm_Moon],[0],None,[256],[0,256])


#Make Equalize Transform Function
M4, N4 = Im_Pollen.shape
M5, N5 = Im_Moon.shape
ETF_Pollen = ETF(Hist_Pollen)*255/(M4*N4)
ETF_Moon = ETF(Hist_Moon)*255/(M5*N5)

#Equalize the Images
EF_Pollen = np.uint8(EF(Im_Pollen, ETF_Pollen))
EF_Moon = np.uint8(EF(Im_Moon, ETF_Moon))


#Histogram of Equalized Images
Hist_EFPollen = cv2.calcHist([EF_Pollen],[0],None,[256],[0,256])
Hist_EFMoon = cv2.calcHist([EF_Moon],[0],None,[256],[0,256])

#Show all Images
cv2.imshow('Pollen1', Im_Pollen)
cv2.imshow('Pollen2', SIm_Pollen)
cv2.imshow('Epollen', EF_Pollen)

cv2.imshow('Moon1', Im_Moon)
cv2.imshow('Moon2', SIm_Moon)
cv2.imshow('EMoon', EF_Moon)

#Store all Images
cv2.imwrite('Pollen.tif', Im_Pollen)
cv2.imwrite('SPollen.tif', SIm_Pollen)
cv2.imwrite('EFpollen.tif', EF_Pollen)

cv2.imwrite('Moon.tif', Im_Moon)
cv2.imwrite('SMoon.tif', SIm_Moon)
cv2.imwrite('EFMoon.tif', EF_Moon)


#Show Images and Their Histogram
plt.figure(1)
plt.subplot(221),plt.imshow(Im_Pollen,'gray'),plt.title('Pollen')
plt.subplot(222),plt.imshow(Im_Moon, 'gray'),plt.title('Moon')
plt.subplot(223),plt.plot(Hist_Pollen)
plt.subplot(224),plt.plot(Hist_Moon)
plt.xlim([0,256])
plt.show()

#Compare the Histogram of Orginal Images and Scaled Images
plt.figure(2)
plt.subplot(221),plt.plot(Hist_Pollen),plt.title('Pollen')
plt.subplot(222),plt.plot(Hist_Moon),plt.title('Moon')
plt.subplot(223),plt.plot(Hist_SPollen)
plt.subplot(224),plt.plot(Hist_SMoon)
plt.xlim([0,256])
plt.show()

#compare the Histogram of Original Images and Equalized Images
plt.figure(3)
plt.subplot(221),plt.plot(Hist_Pollen),plt.title('Pollen')
plt.subplot(222),plt.plot(Hist_Moon),plt.title('Moon')
plt.subplot(223),plt.plot(Hist_EFPollen)
plt.subplot(224),plt.plot(Hist_EFMoon)
plt.xlim([0,256])
plt.show()


cv2.waitKey(0)
cv2.destroyAllWindows()