import cv2
import json

# {'id': , 'location': , 'capacity': }
buildings = []

# Read in image as grayscale
image = cv2.imread('images/example7.png', cv2.IMREAD_GRAYSCALE)

# Convert to binary
a = image.max()  
_, im_bw = cv2.threshold(image, a/2+60, a,cv2.THRESH_BINARY_INV)

# Find contours
(contours, hierarchy) = cv2.findContours(im_bw, mode=cv2.RETR_EXTERNAL, method=cv2.CHAIN_APPROX_NONE)

for i, c in zip(range(len(contours)), contours):
    M = cv2.moments(c)

    cX = int(M["m10"] / M["m00"])
    cY = int(M["m01"] / M["m00"])
    buildings.append({'id': i, 'location': (cX, cY)})

return json.dumps(buildings)