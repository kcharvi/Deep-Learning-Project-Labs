import streamlit as st
from PIL import Image
import tensorflow as tf
import time
from streamlit import caching
from helper import *

st.title("Bird Species Classifier")
st.header("315 different Bird Species are present!")
st.header("Dataset Information: ")
st.write("45980 Train, 1575 Test, 1575 Validation images 224X224X3 jpg format")
st.write(
    "MODELLING: Trained EfficientNetB3 model trained on 128 X 128 X3 image size. F1 test set score = 99% "
)
img = st.file_uploader("Please upload Image", type=["jpeg", "jpg", "png"])
st.set_option("deprecation.showfileUploaderEncoding", False)

st.write("Uploaded Image")
try:
    img = Image.open(img)
    st.image(img)  # display the image
    img = process_image(img)

    # Prediction
    model = tf.keras.models.load_model("EfficientNetB3-birds-98.92.h5")
    prediction = prediction_result(model, img)

    # Progress Bar
    my_bar = st.progress(0)
    for percent_complete in range(100):
        time.sleep(0.05)
        my_bar.progress(percent_complete + 1)

    # Output
    st.write("# Bird Type: {}".format(prediction["class"]))
    # st.write(prediction)
    # st.write("With Accuracy:", prediction["accuracy"], "%")
    caching.clear_cache()
except AttributeError:
    st.write("No Image Selected")
