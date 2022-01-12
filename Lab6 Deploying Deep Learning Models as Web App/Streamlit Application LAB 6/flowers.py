from logging import NullHandler
import streamlit as st
from PIL import Image
import tensorflow as tf
import time
from classifier import *
from streamlit import caching


st.set_option("deprecation.showfileUploaderEncoding", False)

st.title("Flower Classifier")
st.write(
    "This app can predict flowers from five categories: Daisy, Rose, Sunflower, Tulip and Dandelion"
)

img = st.file_uploader("Please upload Image", type=["jpeg", "jpg", "png"])

# Display Image
st.write("Uploaded Image")
try:
    img = Image.open(img)
    st.image(img)  # display the image
    img = process_image(img)

    # Prediction
    model = tf.keras.models.load_model(
        "flower_pred_updated_Lab6_final_for_streamlit.h5"
    )
    prediction = prediction_result(model, img)

    # Progress Bar
    my_bar = st.progress(0)
    for percent_complete in range(100):
        time.sleep(0.05)
        my_bar.progress(percent_complete + 1)

    # Output
    st.write("# Flower Type: {}".format(prediction["class"]))
    st.write("With Accuracy:", prediction["accuracy"], "%")
    caching.clear_cache()

except AttributeError:
    st.write("No Image Selected")
