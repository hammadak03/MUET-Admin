import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String? id;
  final String? title;
  final String? description;
  final String? img;
  final String? date;
  final String? link;

  NewsModel({this.id, this.title, this.description, this.img, this.date, this.link});

  factory NewsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NewsModel(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
      date: snapshot['date'],
      img: snapshot['img'],
      link: snapshot['link'],
    );
  }

  Map<String, dynamic> toDocument() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'img': img,
    'link': link,
  };
}
