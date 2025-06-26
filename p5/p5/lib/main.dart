import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMO APLIKASI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: const Text("HELLO, DUNIA"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.blue,
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Hello',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.amber,
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Hello',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            // Spacer kosong di tengah
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.amber,
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Hello',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.blue,
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Hello',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}