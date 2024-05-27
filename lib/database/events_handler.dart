import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muet_app_admin/Models/events_model.dart';

class EventHandler {
  //Create Events
  static Future<void> createEvent(EventsModel events) async {
    final eventsCollection = FirebaseFirestore.instance.collection('events');
    final id = eventsCollection.doc().id;
    final newEvent = EventsModel(
            id: id,
            title: events.title,
            description: events.description,
            date: events.date,
            imageUrl: events.imageUrl,
            buttonText: events.buttonText,
            link: events.link)
        .toDocument();

    try {
      eventsCollection.doc(id).set(newEvent);
    } catch (e) {
      print("Error $e");
    }
  }

  //Read Events
  static Stream<List<EventsModel>> getEvents() {
    final eventCollection = FirebaseFirestore.instance.collection("events");
    return eventCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => EventsModel.fromSnapshot(e)).toList());
  }

  //Update/Edit Event Data
  static Future<void> updateEvent(EventsModel events) async {
    final eventCollection = FirebaseFirestore.instance.collection("events");
    final newEvent = EventsModel(
            id: events.id,
            title: events.title,
            description: events.description,
            date: events.date,
            link: events.link,
            imageUrl: events.imageUrl,
            buttonText: events.buttonText)
        .toDocument();

    try {
      await eventCollection.doc(events.id).update(newEvent);
    } catch (e) {}
  }

  //Delete Data
  static Future<void> deleteEvent(String id) async {
    final eventCollection =
    FirebaseFirestore.instance.collection("events");
    try {
      await eventCollection.doc(id).delete();
    } catch (e) {}
  }

}
