import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haberler_uygulamasi/model/HaberlerCevap.dart';
import 'package:haberler_uygulamasi/views/Anasayfa.dart';

import 'model/Haberler.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int secilenIndeks=0;
  var sayfaListesi=[Anasayfa("general"),Anasayfa("economy"),Anasayfa("sport"),Anasayfa("entertainment"),Anasayfa("world"),Anasayfa("health"),Anasayfa("technology")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,weight: 35),
        backgroundColor: CupertinoColors.destructiveRed,
        title: Text("Haberler",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 28),),
        centerTitle: true,
      ),
      body: sayfaListesi[secilenIndeks],
      drawer: Drawer(
        backgroundColor: CupertinoColors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("Haber Konuları",style: TextStyle(fontSize: 30,color: Colors.white),),
              decoration: BoxDecoration(
                color: CupertinoColors.destructiveRed,
              ),

            ),
            ListTile(
              title: Text("Genel Haberler",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Ekonomi Haberleri",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=1;
                });
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Spor Haberleri",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=2;
                });
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Magazin & Eğlence Haberleri",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=3;
                });
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Dünya Haberleri",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=4;
                });
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Sağlık Haberleri",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=5;
                });
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Teknoloji Haberleri",style: TextStyle(fontSize: 22,color: Colors.black),),
              onTap: (){
                setState(() {
                  secilenIndeks=6;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
