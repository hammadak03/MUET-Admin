import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final XFile? initialImage;
  final Future<XFile?> Function() onImagePicked;

  const CustomImagePicker({
    Key? key,
    this.initialImage,
    required this.onImagePicked,
  }) : super(key: key);

  @override
  CustomImagePickerState createState() => CustomImagePickerState();
}

class CustomImagePickerState extends State<CustomImagePicker> {
  XFile? _imageUpload;

  @override
  void initState() {
    super.initState();
    _imageUpload = widget.initialImage;
  }

  Future<void> _pickImage() async {
    final pickedFile = await widget.onImagePicked();
    setState(() {
      if (pickedFile != null) {
        _imageUpload = pickedFile;
        print('Image selected');
      }
    });
  }

  void resetImage() {
    setState(() {
      _imageUpload = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: (_imageUpload != null)
            ? ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.file(
            File(_imageUpload!.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
        )
            : const Center(
          child: Icon(
            Icons.add_photo_alternate_rounded,
            size: 40.0,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
