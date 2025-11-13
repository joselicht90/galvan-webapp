import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_availability.g.dart';

@JsonSerializable()
class NftAvailability extends Equatable {
  final int id;
  final DateTime startAt;
  final DateTime? endAt;
  final bool isActive;
  final String? notes;

  const NftAvailability({
    required this.id,
    required this.startAt,
    this.endAt,
    required this.isActive,
    this.notes,
  });

  factory NftAvailability.fromJson(Map<String, dynamic> json) =>
      _$NftAvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$NftAvailabilityToJson(this);

  @override
  List<Object?> get props => [id, startAt, endAt, isActive, notes];
}
