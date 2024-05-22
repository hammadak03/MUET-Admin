import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../utils/image_picker_util.dart';
import '../utils/date_picker_util.dart';
import '../utils/firebase_util.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_image_picker.dart';
import '../widgets/custom_background.dart';
import '../widgets/loading_dialog.dart';

class UpdateEventsScreen extends StatefulWidget {
  const UpdateEventsScreen({super.key});

  @override
  State<UpdateEventsScreen> createState() => _UpdateEventsScreenState();
}

class _UpdateEventsScreenState extends State<UpdateEventsScreen> {
  XFile? _image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  final GlobalKey<CustomImagePickerState> _imagePickerKey = GlobalKey<CustomImagePickerState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _resetState() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _image = null;
      _selectedDate = null;
    });
    _imagePickerKey.currentState?.resetImage();
  }

  Future<void> _uploadEvent() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null ||
        _image == null) {
      String errorMessage = 'Please fill all fields and select an image.\n';
      if (_titleController.text.isEmpty) errorMessage += 'Title is empty.\n';
      if (_descriptionController.text.isEmpty) errorMessage += 'Description is empty.\n';
      if (_selectedDate == null) errorMessage += 'Date is not selected.\n';
      if (_image == null) errorMessage += 'Image is not selected.\n';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    LoadingDialog.show(context);

    await FirebaseUtil.uploadEvent(
      context: context,
      image: _image,
      titleController: _titleController,
      descriptionController: _descriptionController,
      selectedDate: _selectedDate,
      resetState: _resetState,
    );

    LoadingDialog.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomBackground(
              title: 'Update Events',
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtils.width(context) * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImagePicker(
                        key: _imagePickerKey,
                        initialImage: _image,
                        onImagePicked: () async {
                          final pickedFile = await ImagePickerUtil.pickImage();
                          setState(() {
                            _image = pickedFile;
                          });
                          return pickedFile;
                        },
                      ),
                      SizedBox(height: ScreenUtils.height(context) * 0.02,),
                      CustomTextField(
                        hintText: "Event Title",
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: ScreenUtils.height(context) * 0.02,
                      ),
                      CustomTextField(
                        hintText: "Event Description",
                        controller: _descriptionController,
                      ),
                      SizedBox(
                        height: ScreenUtils.height(context) * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          DatePickerUtil.pickDate(context).then((pickedDate) {
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtils.height(context) * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: _uploadEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBlueColor,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text('Update Events', style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
