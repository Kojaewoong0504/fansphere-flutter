// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: _stringFromJson(json['id']),
  email: _stringFromJson(json['email']),
  username: _stringFromJson(json['username']),
  fullName: _stringFromJson(json['full_name']),
  bio: json['bio'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  isActive: _boolFromJson(json['is_active']),
  isVerified: _boolFromJson(json['is_verified']),
  createdAt: _dateTimeFromJson(json['created_at']),
  updatedAt: _dateTimeFromJson(json['updated_at']),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'username': instance.username,
  'full_name': instance.fullName,
  'bio': instance.bio,
  'avatar_url': instance.avatarUrl,
  'is_active': instance.isActive,
  'is_verified': instance.isVerified,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
