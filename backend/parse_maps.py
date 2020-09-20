import cv2
import json

default_img_path = "../computer_vision/example_images/example7.png"

def measure_buildings(img_path):

    # JSON Format: {'id': NUMBER, 'location': TUPLE, 'capacity': NUMBER}
    buildings = []

    # Read in image as grayscale
    image = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)

    # Convert to binary
    a = image.max()  
    _, im_bw = cv2.threshold(image, a/2+60, a,cv2.THRESH_BINARY_INV)

    # Find contours
    (contours, hierarchy) = cv2.findContours(im_bw, mode=cv2.RETR_EXTERNAL, method=cv2.CHAIN_APPROX_NONE)

    for i, c in zip(range(len(contours)), contours):
        M = cv2.moments(c)
        if (len(M) < 4):
            continue

        cX = int(M["m10"] / M["m00"])
        cY = int(M["m01"] / M["m00"])
        buildings.append({'id': i, 'location': (cX, cY),'capacity': 8})

    return json.dumps(buildings)
