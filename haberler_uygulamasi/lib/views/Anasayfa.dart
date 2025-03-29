import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haberler_uygulamasi/views/HaberDetaySayfasi.dart';

import '../model/Haberler.dart';
import '../model/HaberlerCevap.dart';
import 'package:http/http.dart'as http;

class Anasayfa extends StatefulWidget {
  String kategori;

  Anasayfa(this.kategori);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  late ScrollController _scrollController;
  List<String> kategoriList=["Genel Haberler","Ekonomi Haberleri","Spor Haberleri","Magazin & Eğlence Haberler","Dünya Haberleri","Sağlık Haberleri","Teknoloji Haberleri",];
  List<String> kategoriListapi=["general","economy","sport","entertainment","world","health","technology",];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }
  @override
  void dispose() {
    _scrollController.dispose(); //
    super.dispose();
  }

  var sayfa=0;
  var apikey="5DPs8alCLDIOu5NdCqRYwT:0oG41YUv1wPOXd2zeYVn5E";
  List<Haberler> parseHaberlerCevap(String cevap){
    return HaberlerCevap.formJson(json.decode(cevap)).haberListesi;
  }
  Future<List<Haberler>> haberleriGetir() async{
    var url=Uri.parse("https://api.collectapi.com/news/getNews?country=tr&tag=${widget.kategori}&paging=$sayfa");
    var cevap=await http.get(url,headers: {
      "authorization": "apikey $apikey",
      "content-type": "application/json"
    });
    return parseHaberlerCevap(cevap.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: kategoriList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.kategori=kategoriListapi[index];
                        sayfa = 0; // Sayfayı sıfırla
                      });
                      _scrollController.jumpTo(0);
                    },
                    child: Text(
                      kategoriList[index],
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Haberler>>(
              future: haberleriGetir(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var haberlerListesi=snapshot.data;
                  return ListView.builder(
                    controller: _scrollController,
                      itemCount: haberlerListesi!.length,
                      itemBuilder: (context,indeks){
                        var haber=haberlerListesi[indeks];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HaberDetaySayfasi(haber)));
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              elevation: 4,

                              child: Stack(
                                children: [
                                  ClipRRect(

                                      borderRadius:BorderRadius.circular(12),
                                      child: Image.network(haber.resim,fit: BoxFit.cover,height: 200,width: double.infinity,)),
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 15,
                                    right: 15,
                                    child: Text(
                                      haber.konu,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (){
                    setState(() {
                      sayfa=0;
                    });
                    _scrollController.jumpTo(0);
                  }, child: Text("1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
              TextButton(
                  onPressed: (){
                    setState(() {
                      sayfa++;
                    });
                    _scrollController.jumpTo(0);
                  }, child: Text(">",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
              TextButton(
                  onPressed: (){
                    setState(() {
                      if(sayfa!=0){
                        sayfa--;
                      }

                    });
                    _scrollController.jumpTo(0);
                  }, child: Text("<",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),


            ],
          ),
        ],

      ),

    );
  }
}
