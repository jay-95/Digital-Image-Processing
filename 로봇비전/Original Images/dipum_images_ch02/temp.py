import numpy as np
import cv2

F = cv2.imread("Fig0206(a)(rose-original).tif",cv2.IMREAD_GRAYSCALE)
cv2.imshow("Rose", F)
Gy = np.double([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])
Gx = np.double([[-1, -2, -1], [0, 0, 0], [1, 2, 1]])
#Gy = [[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]]
b = (np.ravel(Gy, order='C'))
b.sort()

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
S_Rose = F.shape
c =LPF_Round(S_Rose, 50)
cv2.waitKey(0)
cv2.destroyAllWindows()
