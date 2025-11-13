import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'nft_availability.dart';

part 'nft_web_app.g.dart';

@JsonSerializable(explicitToJson: true)
class NftWebApp extends Equatable {
  final int id;
  final String name;
  final String standardName;
  final String? owner;
  final String? description;
  final double? price;
  final DateTime createdAt;
  final DateTime? modifiedAt;

  @JsonKey(defaultValue: [])
  final List<NftAvailability> availabilities;

  bool get isAvailableNow {
    return availabilities.any(
      (availability) =>
          availability.isActive &&
          (availability.endAt == null ||
              availability.endAt!.isAfter(DateTime.now().toUtc())),
    );
  }

  const NftWebApp({
    required this.id,
    required this.name,
    required this.standardName,
    this.owner,
    this.description,
    this.price,
    required this.createdAt,
    this.modifiedAt,
    this.availabilities = const [],
  });

  factory NftWebApp.fromJson(Map<String, dynamic> json) =>
      _$NftWebAppFromJson(json);

  Map<String, dynamic> toJson() => _$NftWebAppToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    standardName,
    owner,
    description,
    price,
    createdAt,
    modifiedAt,
    availabilities,
  ];
}
