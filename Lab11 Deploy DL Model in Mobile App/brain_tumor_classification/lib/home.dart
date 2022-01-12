import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  //METHOD TO INITIALIZE
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  //LOADING THE TFLITE MODEL
  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_19bce7002_trial2.tflite',
      labels: 'assets/labels.txt',
    );
  }

  //MAIN METHOD TO CLASSIFY THE IMAGE THAT RETURN THE LIST WITH CONFIDENCE LEVEL
  //OF DIFFERENT CLASS OF WHICH WE TAKE THE MAXIMUM.
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.7,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      showConsoleUsingPrint(_output);
      _loading = false;
    });
  }
  //HELPER FUNCTION TO PRINT OUTPUT OF CLASSIFICATION ON CONSOLE
  void showConsoleUsingPrint(List _outputcheck) {
    print('Hi');
    print(_outputcheck);
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff123456),
              Colors.blueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.004, 1],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              Text(
                'Brain Tumor Classification',
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: _loading
                            ? Container(
                          width: 300,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/image.png',
                                  ),
                                  SizedBox(
                                height: 12,
                              ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 4,
                                    ),
                                        GestureDetector(
                                          onTap: pickGalleryImage,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width - 180,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 17,
                                              ),
                                            decoration: BoxDecoration(
                                            color: Color(0xFF56ab2f),
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                                "Upload from Gallery",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                          ),
                        )
                            : Container(
                              child: Column(
                                children: [
                                  Container(
                                height: 300,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(_image),
                                ),
                              ),
                                  SizedBox(
                                height: 20,
                              ),
                              // if(_output==null)Text(""),
                              // if(_output[0]["label"] == '1 no_tumor')
                              //   Text(
                              //     'No Tumor',
                              //     style: TextStyle(
                              //       fontSize: 50,
                              //       fontWeight: FontWeight.bold,
                              //       color: Color(0xffFAE6FC),
                              //       backgroundColor: Color(0xff9700ff),
                              //     ),
                              //   ),
                              // if(_output[0]["label"] == '2 pituitary_tumor')
                              //   Text(
                              //     'Pituitary Tumor',
                              //     style: TextStyle(
                              //       fontSize: 50,
                              //       fontWeight: FontWeight.bold,
                              //       color: Color(0xffFAE6FC),
                              //       backgroundColor: Color(0xff9700ff),
                              //     ),
                              //   ),
                              // if(_output[0]["label"] == '3 meningioma_tumor')
                              //   Text(
                              //     'Meningioma Tumor',
                              //     style: TextStyle(
                              //       fontSize: 50,
                              //       fontWeight: FontWeight.bold,
                              //       color: Color(0xffFAE6FC),
                              //       backgroundColor: Color(0xff9700ff),
                              //     ),
                              //   ),
                              // if(_output[0]["label"] == '4 glioma_tumor')
                              //   Text(
                              //     'Glioma tumor',
                              //     style: TextStyle(
                              //       fontSize: 50,
                              //       fontWeight: FontWeight.bold,
                              //       color: Color(0xffFAE6FC),
                              //       backgroundColor: Color(0xff9700ff),
                              //     ),
                              //   ),
                              _output != null
                                  ? Text(
                                'Predicted: ${_output[0]['label']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20),
                              )
                                  : Container(),
                                  SizedBox(
                                height: 4,
                              ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                      height: 4,
                                    ),
                                        GestureDetector(
                                          onTap: pickGalleryImage,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width -180,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 17,
                                        ),
                                            decoration: BoxDecoration(
                                          color: Color(0xFF56ab2f),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                        ),
                                            child: Text(
                                              "Upload from Gallery",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
