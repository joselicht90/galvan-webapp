// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftAvailability _$NftAvailabilityFromJson(Map<String, dynamic> json) =>
    NftAvailability(
      id: (json['id'] as num).toInt(),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: json['endAt'] == null
          ? null
          : DateTime.parse(json['endAt'] as String),
      isActive: json['isActive'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$NftAvailabilityToJson(NftAvailability instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
      'isActive': instance.isActive,
      'notes': instance.notes,
    };
