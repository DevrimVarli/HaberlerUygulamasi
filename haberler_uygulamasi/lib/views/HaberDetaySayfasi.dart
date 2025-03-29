import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haberler_uygulamasi/model/Haberler.dart';
import 'package:url_launcher/url_launcher.dart';

class HaberDetaySayfasi extends StatefulWidget {
  Haberler haberler;

  HaberDetaySayfasi(this.haberler);

  @override
  State<HaberDetaySayfasi> createState() => _HaberDetaySayfasiState();
}

class _HaberDetaySayfasiState extends State<HaberDetaySayfasi> {

  @override

  Future<void> _launchUrl(var url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget build(BuildContext context) {
    Uri url =Uri.parse(widget.haberler.url);
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text("Detaylar",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 28),),
        centerTitle: true,
        backgroundColor:CupertinoColors.destructiveRed ,
      ) ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.haberler.konu,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(width: 380,widget.haberler.resim,fit: BoxFit.cover,)),
              SizedBox(height: 10),
              Text(widget.haberler.haber_icerigi,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: ()  {
                  launchUrl(url);

                },
                icon: Icon(Icons.open_in_new),
                label: Text("Haberi Oku"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
             SizedBox(height: 20,),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.haberler.tarih,
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
              ),



            ],
          ),
        ),
      ),

    );
  }
}
