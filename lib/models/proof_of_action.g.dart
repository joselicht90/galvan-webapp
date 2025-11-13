// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_of_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofOfAction _$ProofOfActionFromJson(Map<String, dynamic> json) =>
    ProofOfAction(
      id: (json['id'] as num?)?.toInt(),
      firebaseId: json['firebaseId'] as String,
      email: json['email'] as String,
      walletAddress: json['walletAddress'] as String,
      walletTypeId: (json['walletTypeId'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      sponsorFirebaseId: json['sponsorFirebaseId'] as String?,
      sponsorEmail: json['sponsorEmail'] as String?,
      sponsorName: json['sponsorName'] as String?,
      netTotalUsd: (json['netTotalUsd'] as num).toDouble(),
      approved: json['approved'] as bool,
      nftId: (json['nftId'] as num).toInt(),
      nft: NftWebApp.fromJson(json['nft'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      actionType: json['actionType'] as String,
    );

Map<String, dynamic> _$ProofOfActionToJson(ProofOfAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firebaseId': instance.firebaseId,
      'email': instance.email,
      'walletAddress': instance.walletAddress,
      'walletTypeId': instance.walletTypeId,
      'imageUrl': instance.imageUrl,
      'sponsorFirebaseId': instance.sponsorFirebaseId,
      'sponsorEmail': instance.sponsorEmail,
      'sponsorName': instance.sponsorName,
      'netTotalUsd': instance.netTotalUsd,
      'approved': instance.approved,
      'nftId': instance.nftId,
      'nft': instance.nft,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'actionType': instance.actionType,
    };
