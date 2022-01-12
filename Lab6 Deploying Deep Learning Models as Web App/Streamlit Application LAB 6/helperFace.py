import streamlit as st
import cv2
from PIL import Image, ImageEnhance
import numpy as np

face_cascade = face_cascade = cv2.CascadeClassifier(
    "haarcascade_frontalface_default.xml"
)
eye_cascade = cv2.CascadeClassifier("haarcascade_eye.xml")


def detect_faces(our_image):
    new_img = np.array(our_image.convert("RGB"))
    img = cv2.cvtColor(new_img, 1)
    gray = cv2.cvtColor(new_img, cv2.COLOR_BGR2GRAY)
    # Detect faces
    faces = face_cascade.detectMultiScale(gray, 1.1, 4)
    # Draw rectangle around the faces
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
    return img, faces


def detect_eyes(our_image):
    new_img = np.array(our_image.convert("RGB"))
    img = cv2.cvtColor(new_img, 1)
    gray = cv2.cvtColor(new_img, cv2.COLOR_BGR2GRAY)
    eyes = eye_cascade.detectMultiScale(gray, 1.3, 5)
    for (ex, ey, ew, eh) in eyes:
        cv2.rectangle(img, (ex, ey), (ex + ew, ey + eh), (0, 255, 0), 2)
    return img
