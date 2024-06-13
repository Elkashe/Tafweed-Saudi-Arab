class PersonCase{
  int? id;
  String? enName;
  String? arName;
  String? trName;
  String? urName;
  String? idName;

  PersonCase({this.id, this.enName, this.arName, this.idName, this.urName, this.trName});
  PersonCase.fromJson(Map<String, dynamic> json){
    id = json["id"];
    arName = json["name_ar"];
    enName = json["name_en"];
    trName = json["name_tr"];
    urName = json["name_ur"];
    idName = json["name_ind"];
  }
  String getName(String langCode){
     if(langCode == "ar"){
      return arName!;
    }
    else if(langCode == "en"){
      return enName!;
    }
    else if(langCode == "tr"){
      return trName!;
    }
    else if(langCode == "ur"){
      return urName!;
    }
    else{
      return idName!;
    }
  }
}