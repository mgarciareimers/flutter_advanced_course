import 'dart:convert';

BandModel bandModelFromJson(String str) => BandModel.fromJson(json.decode(str));
BandModel bandModelFromBand(BandModel band) => BandModel.fromBand(band);

String bandModelToJson(BandModel data) => json.encode(data.toJson());

class BandModel {
  BandModel({
    this.id,
    this.name,
    this.votes,
  });

  String id;
  String name;
  int votes;

  factory BandModel.fromJson(Map<String, dynamic> json) => BandModel(
    id: json['id'],
    name: json['name'],
    votes: json['votes'],
  );

  factory BandModel.fromBand(BandModel band) => BandModel(
    id: band.id,
    name: band.name,
    votes: band.votes,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'votes': votes,
  };
}
