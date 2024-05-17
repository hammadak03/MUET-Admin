import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muet_app_admin/widgets/custom_textfield.dart';
import '../utils/colors.dart';
import '../utils/home_screen_data.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_grid_view.dart';

class UpdateEventsScreen extends StatefulWidget {
  const UpdateEventsScreen({super.key});

  @override
  State<UpdateEventsScreen> createState() => _UpdateEventsScreenState();
}

class _UpdateEventsScreenState extends State<UpdateEventsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    File? _image;
    final _picker = ImagePicker();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    @override
    void dispose() {
      super.dispose();
      _titleController.dispose();
      _descriptionController.dispose();
    }

    Future<void> _pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          print('image selected');
        } else {
          print('No image selected.');
        }
      });
    }

    return Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: backgroundgrey,
              ),
            ),
            Column(
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.059, bottom: height * 0.035),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: height * 0.134,
                      height: height * 0.134,
                      child: Image.asset(
                        'assets/images/muet logo.png',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.032, bottom: height * 0.045),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Update Events'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xfffffc817),
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtils.width(context) * 0.05),
                          child: Column(
                            children: [
                              //TODO: After selecting image, image is not showing in the place holder, i.e. gesture detector
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: (_image == null)
                                      ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_photo_alternate, size: 50),
                                      SizedBox(height: 8),
                                      Text(
                                        'Upload Image here',
                                        style: TextStyle(fontSize: 16, color: Colors.black45),
                                      ),
                                    ],
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              CustomTextField(
                                  hintText: "Event Title", controller: _titleController),
                              SizedBox(
                                height: ScreenUtils.height(context) * 0.03,
                              ),
                              CustomTextField(
                                  hintText: "Event Description", controller: _descriptionController),
                              SizedBox(
                                height: ScreenUtils.height(context) * 0.03,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle form submission
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: darkBlueColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                ),
                                child: const Text('Update Events', style: TextStyle(color: Colors.white),),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
