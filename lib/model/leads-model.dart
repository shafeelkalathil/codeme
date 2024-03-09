// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

LeadModel userModelFromJson(String str) => LeadModel.fromJson(json.decode(str));

// String userModelToJson(LeadModel data) => json.encode(data.toJson());

class LeadModel {
  final int id;
  final String source;
  final String createdUser;
  final String assignedUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String mobile;
  final String email;
  final String image;
  final String interest;
  final String location;
  final bool isAssigned;
  final String status;
  final String priority;
  final String subSource;
  final int fkCompany;
  final int createdBy;

  LeadModel({
    required this.id,
    required this.source,
    required this.createdUser,
    required this.assignedUser,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.mobile,
    required this.email,
    required this.image,
    required this.interest,
    required this.location,
    required this.isAssigned,
    required this.status,
    required this.priority,
    required this.subSource,
    required this.fkCompany,
    required this.createdBy,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'],
      source: json['source'] ?? "",
      createdUser: json['created_user'],
      assignedUser: json['assigned_user'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      image: json['image'] ?? '',
      interest: json['interest'],
      location: json['location'],
      isAssigned: json['is_assigned'],
      status: json['status'],
      priority: json['priority'],
      subSource: json['sub_source'] ?? '',
      fkCompany: json['fk_company'],
      createdBy: json['created_by'],
    );
  }
}
