import 'package:equatable/equatable.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proof_of_action.g.dart';

@JsonSerializable()
class ProofOfAction extends Equatable {
  final int? id;
  final String firebaseId;
  final String email;
  final String walletAddress;
  final int walletTypeId;
  final String imageUrl;
  final String? sponsorFirebaseId;
  final String? sponsorEmail;
  final String? sponsorName;
  final double netTotalUsd;
  final bool approved;
  final int nftId;
  final NftWebApp nft;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String actionType;

  const ProofOfAction({
    this.id,
    required this.firebaseId,
    required this.email,
    required this.walletAddress,
    required this.walletTypeId,
    required this.imageUrl,
    this.sponsorFirebaseId,
    this.sponsorEmail,
    this.sponsorName,
    required this.netTotalUsd,
    required this.approved,
    required this.nftId,
    required this.nft,
    required this.createdAt,
    this.updatedAt,
    required this.actionType,
  });

  factory ProofOfAction.fromJson(Map<String, dynamic> json) =>
      _$ProofOfActionFromJson(json);

  Map<String, dynamic> toJson() => _$ProofOfActionToJson(this);

  @override
  List<Object?> get props => [
    id,
    firebaseId,
    email,
    walletAddress,
    walletTypeId,
    imageUrl,
    sponsorFirebaseId,
    sponsorEmail,
    sponsorName,
    netTotalUsd,
    approved,
    nftId,
    nft,
    createdAt,
    updatedAt,
    actionType,
  ];
}
