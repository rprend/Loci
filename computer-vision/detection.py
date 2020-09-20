import cv2
import json

# JSON Format: {'id': NUMBER, 'location': TUPLE, 'capacity': NUMBER}
buildings = []

# Read in image as grayscale
image = cv2.imread('example_images/example7.png', cv2.IMREAD_GRAYSCALE)

# Convert to binary
a = image.max()  
_, im_bw = cv2.threshold(image, a/2+60, a,cv2.THRESH_BINARY_INV)

# Find contours
(contours, hierarchy) = cv2.findContours(im_bw, mode=cv2.RETR_EXTERNAL, method=cv2.CHAIN_APPROX_NONE)

'''
Calculate capacity as proportion of sizes of drawn quadrilateral. Normalized to add up to
100 ish
'''
total_area = sum([cv2.contourArea(c) for c in contours])

for i, c in zip(range(len(contours)), contours):
    M = cv2.moments(c)

    cX = int(M["m10"] / M["m00"])
    cY = int(M["m01"] / M["m00"])
    capacity = int(round(cv2.contourArea(c)/total_area * 100, -1))
    print(capacity)
    buildings.append({'id': i, 'location': (cX, cY),'capacity': capacity})

json.dumps(buildings)