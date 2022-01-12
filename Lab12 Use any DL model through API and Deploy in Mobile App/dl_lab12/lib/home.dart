import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:image_picker/image_picker.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  //Content and Style Image flags
  bool _contentAdded = false;
  bool _styleAdded = false;
  File _contentImageFile = File("assets/images/null.png");
  File _styleImageFile = File("assets/images/null.png");
  int _responseOK = 0;
  ImageProvider _finalImage=AssetImage('assets/images/blob.jpg');
  final picker = ImagePicker();

  //METHODS USED
  Future _contentFromCamera() async {
    final contentImg = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (contentImg != null) {
        _contentImageFile = File(contentImg.path);
        _contentAdded = true;
      }
    });
  }
  Future _contentFromGallery() async {
    final contentImg = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (contentImg != null) {
        _contentImageFile = File(contentImg.path);
        _contentAdded = true;
      }
    });
  }
  Future _styleFromCamera() async {
    final styleImg = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (styleImg != null) {
        _styleImageFile = File(styleImg.path);
        _styleAdded = true;
      }
    });
  }
  Future _styleFromGallery() async {
    final styleImg = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (styleImg != null) {
        _styleImageFile = File(styleImg.path);
        _styleAdded = true;
      }
    });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How To Use?',
                style: TextStyle(fontSize: 30)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Add the images for the content and the style and hit combine! ",
                  style: TextStyle(
                      fontSize: 20
                  ),),
                Text('As simple as that. Click okay to proceed...  '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: ()=> {
                Navigator.of(context).pop()
              },
            ),
          ],
        );
      },
    );
  }
  _uploadFiles() async{
    http.MultipartRequest request = http.MultipartRequest(
            'POST', Uri.parse('https://ai-art-maker.p.rapidapi.com/art-remixer-api-bin'));
    Map<String, String> headers = {
      'x-rapidapi-host': 'ai-art-maker.p.rapidapi.com',
      'x-rapidapi-key': '*************************************************'
    };
    request.fields['focusContent']="true";
    request.files.add(
      await http.MultipartFile.fromPath(
        'contentImage',
        _contentImageFile.path,
        contentType: http_parser.MediaType('image', 'jpg'),
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'styleImage',
        _styleImageFile.path,
        contentType: http_parser.MediaType('image', 'jpg'),
      ),
    );
    request.headers.addAll(headers);
    http.StreamedResponse res = await request.send();
    var response = await http.Response.fromStream(res);
    setState(() {
      _responseOK = response.statusCode;
      _finalImage = Image.memory(response.bodyBytes).image;
    });
  }
  void _clearState() {
    setState(() {
      _styleImageFile = File("assets/images/null.png");
      _contentImageFile = File("assets/images/null.png");
      _finalImage = AssetImage('assets/images/blob.jpg');
      _responseOK = 0;
    });
  }
  void _showContentPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                  child: Wrap(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.menu),
                          title: Text('From gallery'),
                          onTap: () {
                            _contentFromGallery();
                            Navigator.of(context).pop();
                          }),
                      ListTile(
                          leading: Icon(Icons.photo_camera),
                          title: Text("From camera"),
                          onTap: () {
                            _contentFromCamera();
                            Navigator.of(context).pop();
                          })
                    ],
                  )));
        });
  }
  void _showStylePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                  child: Wrap(
                    children: <Widget>[
                      ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('From gallery'),
                          onTap: () {
                            _styleFromGallery();
                            Navigator.of(context).pop();
                          }),
                      ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text("From camera"),
                          onTap: () {
                            _styleFromCamera();
                            Navigator.of(context).pop();
                          })
                    ],
                  )));
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/icon.png'), fit: BoxFit.cover
                  )
              ),
              child:Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0,2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://lh3.googleusercontent.com/ogw/ADea4I6YFaOABFNhPMaD_fkb-YGaLFfPjNuvpaIXpgIWJQ=s192-c-mo",
                    ),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.fromLTRB(70.0,70.0,30.0, 1.0),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Text("      K CHARVI      19bce7002",style: TextStyle(
                    fontFamily: 'Inconsolata',
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.w300
                  ),
                  )
                ]
            )
        ),
        ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0,0.0,0.0, 1.0),
            ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
            elevation: 5.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("What is Neural Style Transfer?",
                            style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25.0,
                          )
                        ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0.0,10.0,20.0, 1.0),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                child:Text(
                  "Neural Style Transfer refers to a class of "
                      "software algorithms that manipulate digital images,"
                      " or videos, in order to adopt the appearance or visual "
                      "style of another image. NST algorithms are characterized "
                      "by their use of deep neural networks for the "
                      "sake of image transformation. ",
                ),
              ),
              Container(
                height: 100.0,
                child: Ink.image(
                    image: AssetImage('assets/images/download.jpg')
                ),
              ),
              ButtonBar(
                children: [
                  TextButton(
                    child: const Text('LEARN HOW TO USE THIS APP'),
                    onPressed: () {
                      _showMyDialog();
                    },
                  )
                ],
              )
            ],
          )),
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0,30.0,20.0, 1.0),
            ),
            _responseOK != 200
                ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _contentImageFile.path ==
                                "assets/images/null.png"
                                ? AssetImage(_contentImageFile.path)
                                : FileImage(_contentImageFile)
                            as ImageProvider,
                            fit: BoxFit.cover,
                          )),
                      child: Text(
                        " ",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  ),
                  Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _styleImageFile.path ==
                                "assets/images/null.png"
                                ? AssetImage(_styleImageFile.path)
                                : FileImage(_styleImageFile) as ImageProvider,
                            fit: BoxFit.cover,
                          )),
                      child: Text(
                        " ",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                ])
                : Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _finalImage,
                    fit: BoxFit.cover,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0,50.0,20.0, 1.0),
            ),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/blob.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                    ),
                    ElevatedButton(
                        onPressed: () =>{
                          _showContentPicker()
                        },
                        child: const Text("Add content image"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          _showStylePicker();
                        },
                        child: const Text("Add style image"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          _clearState();
                        },
                        child: const Text("Clear Images"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                        )),
                    ElevatedButton(
                        onPressed: _contentAdded == false ||
                            _styleAdded == false
                            ? null
                            : ()=> {_uploadFiles()},
                        child: const Text("Combine"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                        )),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
        title: const Text('RAPID NEURAL STYLE TRANSFER'),
      leading: Icon(
        Icons.menu,
      ),
    );
  }
}
