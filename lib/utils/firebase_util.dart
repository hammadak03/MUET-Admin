import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseUtil {
  static Future<void> uploadEvent({
    required BuildContext context,
    required XFile? image,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required DateTime? selectedDate,
    required VoidCallback resetState,
  }) async {
    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('events/${image!.name}');
      await imageRef.putFile(File(image.path));
      final imageUrl = await imageRef.getDownloadURL();

      // Upload event data to Firestore
      await FirebaseFirestore.instance.collection('events').add({
        'title': titleController.text,
        'description': descriptionController.text,
        'date': selectedDate!.toIso8601String(),
        'imageUrl': imageUrl,
      });

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
