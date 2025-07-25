import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? postId;
  String? ownerId;
  String? username;
  String? location;
  String? description;
  String? date; // <-- Add this
  String? time; // <-- Add this
  String? gathering;
  String? mediaUrl;
  Timestamp? timestamp;

  PostModel({
    this.id,
    this.postId,
    this.ownerId,
    this.location,
    this.description,
    this.date,
    this.time,
    this.gathering,
    this.mediaUrl,
    this.username,
    this.timestamp,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    location = json['location'];
    username = json['username'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    gathering = json['gathering'];

    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['date'] = this.date;
    data['time'] = this.time;
    data['gathering'] = this.gathering;
    data['mediaUrl'] = this.mediaUrl;
    data['timestamp'] = this.timestamp;
    data['username'] = this.username;
    return data;
  }
}
