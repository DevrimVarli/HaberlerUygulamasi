import 'Haberler.dart';

class HaberlerCevap{
  List<Haberler> haberListesi;

  HaberlerCevap(this.haberListesi);
  factory HaberlerCevap.formJson(Map<String,dynamic>json){
    var jsonArray=json["result"] as List;
    List<Haberler> haberListesi=jsonArray.map((jsonArrayNesnesi) => Haberler.fromJson(jsonArrayNesnesi)).toList();
    return HaberlerCevap(haberListesi);
  }
}