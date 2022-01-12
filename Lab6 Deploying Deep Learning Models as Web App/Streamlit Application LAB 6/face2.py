# Core Pkgs
import streamlit as st
import cv2
from PIL import Image, ImageEnhance
import numpy as np
import time
from helperFace import *

face_cascade = face_cascade = cv2.CascadeClassifier(
    'haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier(
    'haarcascade_eye.xml')

st.set_option('deprecation.showfileUploaderEncoding', False)

st.title("Face Detection App")

image_file = st.file_uploader("Upload Image", type=['jpg', 'png', 'jpeg'])

# Display Image
st.write("Uploaded Image")


try:
    our_image = Image.open(image_file)
    st.subheader("Original Image")
    # st.write(type(our_image))
    st.image(our_image)

    enhance_type = st.sidebar.radio(
        "Enhance Type", ["Original", "Gray-Scale", "Contrast", "Brightness", "Blurring"])

    st.subheader("Enhanced Image: ")
    if enhance_type == 'Gray-Scale':
        new_img = np.array(our_image.convert('RGB'))
        img = cv2.cvtColor(new_img, 1)
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        # st.write(new_img)
        st.image(gray)
    elif enhance_type == 'Contrast':
        c_rate = st.sidebar.slider("Contrast", 0.5, 3.5)
        enhancer = ImageEnhance.Contrast(our_image)
        img_output = enhancer.enhance(c_rate)
        st.image(img_output)

    elif enhance_type == 'Brightness':
        c_rate = st.sidebar.slider("Brightness", 0.5, 3.5)
        enhancer = ImageEnhance.Brightness(our_image)
        img_output = enhancer.enhance(c_rate)
        st.image(img_output)

    elif enhance_type == 'Blurring':
        new_img = np.array(our_image.convert('RGB'))
        blur_rate = st.sidebar.slider("Brightness", 0.5, 3.5)
        img = cv2.cvtColor(new_img, 1)
        blur_img = cv2.GaussianBlur(img, (11, 11), blur_rate)
        st.image(blur_img)

    elif enhance_type == 'Original':
        st.image(our_image, width=300)
    else:
        st.image(our_image, width=300)

    # Face Detection
    task = ["Faces", "Eyes"]
    feature_choice = st.sidebar.selectbox("Find Features", task)
    st.subheader("Click To See the Detection: ")

    if st.button("Process"):

        if feature_choice == 'Faces':
            result_img, result_faces = detect_faces(our_image)
            st.image(result_img)
            st.success("Found faces")

        if feature_choice == 'Eyes':
            result_img = detect_eyes(our_image)
            st.image(result_img)
            st.success("Found Eyes")


except AttributeError:
    st.write("No Image Selected")
