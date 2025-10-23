// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_web_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftWebApp _$NftWebAppFromJson(Map<String, dynamic> json) => NftWebApp(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  standardName: json['standardName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  owner: json['owner'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  modifiedAt: json['modifiedAt'] == null
      ? null
      : DateTime.parse(json['modifiedAt'] as String),
);

Map<String, dynamic> _$NftWebAppToJson(NftWebApp instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'standardName': instance.standardName,
  'createdAt': instance.createdAt.toIso8601String(),
  'owner': instance.owner,
  'description': instance.description,
  'price': instance.price,
  'modifiedAt': instance.modifiedAt?.toIso8601String(),
};
