import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? buttonText;
  final String? date;
  final String? link;

  EventsModel(
      {this.title,
      this.description,
      this.imageUrl,
      this.buttonText,
      this.date,
      this.link,
      this.id});

  factory EventsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return EventsModel(
        id: snapshot['id'],
        title: snapshot['title'],
        description: snapshot['description'],
        buttonText: snapshot['buttonText'],
        date: snapshot['date'],
        link: snapshot['link'],
        imageUrl: snapshot['imageUrl']);
  }

  Map<String, dynamic> toDocument() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
        'buttonText': buttonText,
        'link': link,
        'imageUrl': imageUrl
  };
}
