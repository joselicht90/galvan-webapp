import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_web_app.g.dart';

@JsonSerializable()
class NftWebApp extends Equatable {
  final int id;
  final String name;
  final String standardName;
  final DateTime createdAt;
  final String? owner;
  final String? description;
  final double? price;
  final DateTime? modifiedAt;

  const NftWebApp({
    required this.id,
    required this.name,
    required this.standardName,
    required this.createdAt,
    this.owner,
    this.description,
    this.price,
    this.modifiedAt,
  });

  /// Factory para deserializar desde JSON
  factory NftWebApp.fromJson(Map<String, dynamic> json) =>
      _$NftWebAppFromJson(json);

  /// Serializar a JSON
  Map<String, dynamic> toJson() => _$NftWebAppToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    standardName,
    createdAt,
    owner,
    description,
    price,
    modifiedAt,
  ];
}
