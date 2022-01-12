// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// // var req = unirest("POST", "https://ai-art-maker.p.rapidapi.com/art-remixer-api-bin");
// //
// // req.headers({
// // "content-type": "multipart/form-data; boundary=---011000010111000001101001",
// // "x-rapidapi-host": "ai-art-maker.p.rapidapi.com",
// // "x-rapidapi-key": "f759e74826mshf5b253fafbcc896p187e08jsn1f9c4a21e5d2",
// // "useQueryString": true
// // });
// class StyleApi{
//   static Future<FileImage> uploadImage() async{
//     var uri = Uri.https('ai-art-maker.p.rapidapi.com','/art-remixer-api-bin',
//         {
//           "focusContent": "true"
//         }
//     );
//     final response = await http.get(uri,headers: {
//       "content-type": "multipart/form-data; boundary=---011000010111000001101001",
//       "x-rapidapi-host": "ai-art-maker.p.rapidapi.com",
//       "x-rapidapi-key": "f759e74826mshf5b253fafbcc896p187e08jsn1f9c4a21e5d2",
//       "useQueryString": "true"
//     });
//
//     var data = jsonDecode(response.body);
//     final Uint8List bytes = data.buffer.asUint8List();
//     return Image.memory(bytes);
//   }
// }