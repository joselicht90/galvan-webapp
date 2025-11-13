// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_web_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftWebApp _$NftWebAppFromJson(Map<String, dynamic> json) => NftWebApp(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  standardName: json['standardName'] as String,
  owner: json['owner'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  modifiedAt: json['modifiedAt'] == null
      ? null
      : DateTime.parse(json['modifiedAt'] as String),
  availabilities:
      (json['availabilities'] as List<dynamic>?)
          ?.map((e) => NftAvailability.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$NftWebAppToJson(NftWebApp instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'standardName': instance.standardName,
  'owner': instance.owner,
  'description': instance.description,
  'price': instance.price,
  'createdAt': instance.createdAt.toIso8601String(),
  'modifiedAt': instance.modifiedAt?.toIso8601String(),
  'availabilities': instance.availabilities.map((e) => e.toJson()).toList(),
};
