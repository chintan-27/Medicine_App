import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class OneMed extends StatefulWidget {
  String name;
  OneMed(this.name);
  @override
  _OneMedState createState() => _OneMedState();
}

class _OneMedState extends State<OneMed> {
  List<dynamic> convertData(var data) {
    return jsonDecode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe6f1ff),
        body: FutureBuilder(
            future: http.get(
                'http://chintan27.pythonanywhere.com/medicine/name/${widget
                    .name}'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<dynamic> data = convertData(snapshot.data.body);
                return SafeArea(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.chevron_left , color: Colors.black,size: 30,),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.favorite_border , color: Colors.redAccent,size: 30,),
                                  ),
                                ],
                              ),
                              Center(
                                child: Stack(children: [
                                  Opacity(child: Padding(
                                      padding:EdgeInsets.all(20),
                                      child: Image.network('https://chintan27.pythonanywhere.com${data[0]['image']}', color: Colors.black)), opacity: 0.2),
                                  ClipRect(child: BackdropFilter(

                                      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Image.network('https://chintan27.pythonanywhere.com${data[0]['image']}')
                                        ,
                                      )

                                  ))
                                ]),
                              ),
                            ],
                          )
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                              ),
                              color: Colors.white,
                              boxShadow: [
                              BoxShadow(
                                color: Color(0x11000000),
                                blurRadius: 10,
                                spreadRadius: 10,
                                offset: Offset(0, -5),
                              ),
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      data[0]['name'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        data[0]['type'] + " - " +data[0]['amountperpack'].toString(),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "\$ "+data[0]['price'].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                        "In stock " + data[0]['remaininginstock'].toString() + " /100",
                                        style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        )
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: 150,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black26,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: data[0]['remaininginstock'].toDouble()*1.5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.lightGreenAccent,
                                                ),
                                              )
                                            ],
                                          )
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Dosage from',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15
                                          ),
                                        ),
                                        Text(
                                          data[0]['type'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Active Substance',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15
                                          ),
                                        ),
                                        Text(
                                          data[0]['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Dosage',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15
                                          ),
                                        ),
                                        Text(
                                          data[0]['amountperdosage'].toString() + 'mg',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Manufacturer',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15
                                          ),
                                        ),
                                        Text(
                                          data[0]['manufacturer'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50,),
                                FlatButton(
                                  onPressed: (){
                                  },
                                  child: Container(
                                    width: 300,
                                    height: MediaQuery.of(context).size.height*0.08,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueAccent,
                                        boxShadow: [
                                        BoxShadow(
                                          offset: Offset(
                                            5,5
                                          ),
                                          blurRadius: 10,
                                          color: Colors.black26
                                        )
                                      ]
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],

                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                );
              }
              else {
                return Container(
                  child: Center(
                    child: SpinKitCubeGrid(
                      color: Colors.blueAccent,
                      size: 50,
                    ),
                  ),
                );
              }
            }

        ),
      );
  }
}