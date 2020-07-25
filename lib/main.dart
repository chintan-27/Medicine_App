import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:medicineapp/onemed.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins'
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<dynamic> convertData(var data){
    return jsonDecode(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Row(
              children: <Widget>[
                SizedBox(width: 20,),
                Icon(Icons.near_me, color: Colors.black54,size: 20,),
                Text(
                  "London",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Hi, Chintan",
                    style:TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins'
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/one.jpeg'),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFe6f1ff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(2, 4), // changes position of shadow
                  ),
                ],
              ),
              height: 200,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "\" We will deliver",
                          style:TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins'
                          ),
                        ),
                        Text(
                          "you medicine \"",
                          style:TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Image.asset(
                        'images/man.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Icon(
                    Icons.equalizer,
                    size: 30,
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: http.get('https://chintan27.pythonanywhere.com/medicine/'),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  List<dynamic> data = convertData(snapshot.data.body);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: (data.length/2).round(),
                      itemBuilder: (context,index){
                        return Container(
                          height: 290,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => OneMed(data[index]['name'])
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: 190,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFe6f1ff),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height:100,
                                        width: 190,
                                        child: Image.network(
                                          'https://chintan27.pythonanywhere.com${data[index]['image']}',
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Text(
                                        data[index]['name'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Text(
                                        data[index]['type']+" - "+data[index]['amountperpack'].toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color:Colors.black26
                                        ),
                                      ),
                                      SizedBox(height: 40,),
                                      Text(
                                        "\$ " + data[index]['price'].toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color:Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => OneMed(data[index+6]['name'])
                                  ));
                                },
                                child: Container(
                                    width: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFFe6f1ff),
                                    ),
                                  child: Column(
                                  children: <Widget>[
                                  Container(
                                  height:100,
                                  width: 100,
                                  child: Image.network(
                                    'https://chintan27.pythonanywhere.com${data[index+6]['image']}',
                                  ),
                                ),
                                    SizedBox(height: 20,),
                                    Text(
                                      data[index+6]['name'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      data[index+6]['type']+" - "+data[index+6]['amountperpack'].toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color:Colors.black26
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Text(
                                      "\$ " + data[index+6]['price'].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color:Colors.black
                                      ),
                                    ),
                            ],
                                  )
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }else{
                  return Expanded(
                    child: Center(
                      child: SpinKitCubeGrid(
                        color: Colors.blueAccent,
                        size: 50,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFFb3d6ff),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xFFb3d6ff),
        items: <Widget>[
          Icon(Icons.search,color: Colors.black,),
          Icon(Icons.favorite_border,color: Colors.black,),
          Icon(Icons.dashboard,color: Colors.black,),
          Icon(Icons.shopping_cart,color: Colors.black,),
          Icon(Icons.account_circle,color: Colors.black,)
        ],
        index: 2,
        animationDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
