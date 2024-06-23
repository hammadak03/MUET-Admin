import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/news_model.dart';

class NewsHandler {
  // Create News
  static Future<void> createNews(NewsModel news) async {
    final newsCollection = FirebaseFirestore.instance.collection('news');
    final id = newsCollection.doc().id;
    final newNews = NewsModel(
      id: id,
      title: news.title,
      description: news.description,
      date: news.date,
      img: news.img,
      link: news.link,
    ).toDocument();

    try {
      await newsCollection.doc(id).set(newNews);
    } catch (e) {
      print("Error $e");
    }
  }

  // Read News
  static Stream<List<NewsModel>> getNews() {
    final newsCollection = FirebaseFirestore.instance.collection("news");
    return newsCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => NewsModel.fromSnapshot(e)).toList());
  }

  // Update/Edit News
  static Future<void> updateNews(NewsModel news) async {
    final newsCollection = FirebaseFirestore.instance.collection("news");
    final newNews = NewsModel(
      id: news.id,
      title: news.title,
      description: news.description,
      date: news.date,
      img: news.img,
      link: news.link,
    ).toDocument();

    try {
      await newsCollection.doc(news.id).update(newNews);
    } catch (e) {
      print("Error $e");
    }
  }

  // Delete News
  static Future<void> deleteNews(String id) async {
    final newsCollection = FirebaseFirestore.instance.collection("news");
    try {
      await newsCollection.doc(id).delete();
    } catch (e) {
      print("Error $e");
    }
  }
}
