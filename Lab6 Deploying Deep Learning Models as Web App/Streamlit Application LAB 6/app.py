import streamlit as st


def main():
    st.title("Deep Learning CSE 4006")
    st.sidebar.title("My Applications!")
    st.sidebar.header("Made by: K Charvi")

    activities = ["Know About Me","Flowers Classification","316 Birds Species prediction","Face Detection"]
    choice = st.sidebar.selectbox("Select ",activities)

    if choice == 'Know About Me':
        st.header("LAB 6")
        st.header(
            "Name: K CHARVI ")
        st.header("Reg No: 19BCE7002")
        st.header("Date: 27|10|2021")
        st.header("Submitted To: Dr. BKSP Kumarraju Alluri")

    elif choice== 'Flowers Classification':
        exec(open('flowers.py').read())
    
    elif choice == '316 Birds Species prediction':
        exec(open('bird_app.py').read())

    elif choice == 'Face Detection':
        exec(open('face2.py').read())

    else: 
        st.write("Make A selection from the dropdown")

if __name__ == '__main__':
    main()


