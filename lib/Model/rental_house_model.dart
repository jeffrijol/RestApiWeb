class RentalHouseModel {
  RentalHouseModel({
    required this.id,
    required this.address,
    required this.type,
    required this.constructionDate,
    required this.lastReformDate,
    required this.bedrooms,
    required this.bathrooms,
    required this.services,
    required this.managedByUser,
    required this.v,
  });
  late final String id;
  late final String address;
  late final String type;
  late final String constructionDate;
  late final String lastReformDate;
  late final int bedrooms;
  late final int bathrooms;
  late final List<Services> services;
  late final String managedByUser;
  late final int v;
  
  RentalHouseModel.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    address = json['address'];
    type = json['type'];
    constructionDate = json['constructionDate'];
    lastReformDate = json['lastReformDate'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    services = List.from(json['services']).map((e)=>Services.fromJson(e)).toList();
    managedByUser = json['managedByUser'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['address'] = address;
    _data['type'] = type;
    _data['constructionDate'] = constructionDate;
    _data['lastReformDate'] = lastReformDate;
    _data['bedrooms'] = bedrooms;
    _data['bathrooms'] = bathrooms;
    _data['services'] = services.map((e)=>e.toJson()).toList();
    _data['managedByUser'] = managedByUser;
    _data['__v'] = v;
    return _data;
  }
}

class Services {
  Services({
    required this.name,
    required this.provider,
    required this.contractDate,
    required this.id,
  });
  late final String name;
  late final String provider;
  late final String contractDate;
  late final String id;
  
  Services.fromJson(Map<String, dynamic> json){
    name = json['name'];
    provider = json['provider'];
    contractDate = json['contractDate'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['provider'] = provider;
    _data['contractDate'] = contractDate;
    _data['_id'] = id;
    return _data;
  }
}