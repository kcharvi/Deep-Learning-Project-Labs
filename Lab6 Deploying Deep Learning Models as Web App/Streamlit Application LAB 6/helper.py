import tensorflow as tf
import numpy as np
from PIL import Image, ImageOps
import cv2
import pandas as pd
import csv


def process_image(img, img_size=(128, 128)):
    image = ImageOps.fit(img, img_size, Image.ANTIALIAS)
    # converts the image into numpy array
    image = np.asarray(image)
    # converts image from BGR color space to RGB
    img = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    img_resize = (
        cv2.resize(img, dsize=img_size, interpolation=cv2.INTER_CUBIC)
    ) / 255.0

    img_reshape = img_resize[np.newaxis, ...]

    return img_reshape


def prediction_result(model, image_data):
    # Mapping prediction results to the Flower type
    reader = csv.DictReader(open("class_dict.csv"))
    classes = {}
    for row in reader:
        k = int(row["class_index"])
        v = row["class"]
        print(k, v)
        classes[k] = v
    pred = model.predict(image_data)
    prediction = np.argmax(pred, axis=1)
    print(prediction)
    # prediction_df = pd.DataFrame(y_pred)
    prediction_class = {"class": classes[prediction[0]]}
    # "accuracy": np.round(np.max(pred) * 100, 2)
    return prediction_class
