class Haberler{
  String haber_id;
  String url;
  String haber_icerigi;
  String resim;
  String konu;
  String tarih;

  Haberler(this.haber_id, this.url, this.haber_icerigi, this.resim, this.konu,
      this.tarih);
  factory Haberler.fromJson(Map<String,dynamic>json){
    return Haberler(json["key"] as String, json["url"] as String, json["description"] as String, json["image"] as String, json["name"] as String, json["date"] as String);
    
  }
}