import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0,2.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/ogw/ADea4I6YFaOABFNhPMaD_fkb-YGaLFfPjNuvpaIXpgIWJQ=s192-c-mo"
                      ),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 60,
              ),
              Text(
                "K Charvi"
                ,style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 50.0,
                  color:Colors.blueAccent,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w700
              ),
              ),
                SizedBox(
                height: 10,
              ),
              Text(
                "Hyderabad, India"
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
                width: 50,
              ),

              Text(
                "ML and DL Engineer"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 15,
              ),

              Card(
                  margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),

                  elevation: 5.0,

                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children:[ Icon(
                          Icons.call,

                          color: Colors.blue,
                          size: 24.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                      Text("     +91 7406380637",style: TextStyle(
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.w300
                      ),)]
                      )
              ),
              ),
              SizedBox(
                height: 15,
              ),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                elevation: 5.0,

                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children:[ Icon(
                          Icons.email,
                          color: Colors.blue,
                          size: 24.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                          Text("     charvi.19bce7002@gmail.com",style: TextStyle(
                              letterSpacing: 3.0,
                              fontWeight: FontWeight.w300
                          ),)]
                    )
                ),
              ),
      ]
     )
    )
    );
  }
}