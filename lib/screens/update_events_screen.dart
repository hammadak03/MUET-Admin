import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_image_picker.dart';
import '../widgets/custom_background.dart';

class UpdateEventsScreen extends StatefulWidget {
  const UpdateEventsScreen({super.key});

  @override
  State<UpdateEventsScreen> createState() => _UpdateEventsScreenState();
}

class _UpdateEventsScreenState extends State<UpdateEventsScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  Future<XFile?> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    return pickedFile;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtils.width(context) * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImagePicker(
                      initialImage: _image,
                      onImagePicked: _pickImage,
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
                        _pickDate(context);
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
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.height(context) * 0.02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle form submission
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlueColor,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        elevation: 5,
                      ),

                      child: const Text('Update Events', style: TextStyle(color: Colors.white),),
                    ),
                  ],
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