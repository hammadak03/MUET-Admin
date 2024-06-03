import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muet_app_admin/Models/events_model.dart';
import 'package:muet_app_admin/database/events_handler.dart';

class FirebaseUtil {
  static Future<void> uploadEvent({
    required BuildContext context,
    required XFile? image,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController linkController,
    required TextEditingController buttonTextController,
    required DateTime? selectedDate,
    required VoidCallback resetState,
  }) async {
    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('events/${image!.name}');
      await imageRef.putFile(File(image.path));
      final imageUrl = await imageRef.getDownloadURL();

      EventHandler.createEvent(EventsModel(
        title: titleController.text,
        description: descriptionController.text,
        link: linkController.text,
        buttonText: buttonTextController.text,
        imageUrl: imageUrl,
        date: selectedDate!.toIso8601String(),
      ));
      resetState();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update event: $e')),
      );
    }
  }
}
