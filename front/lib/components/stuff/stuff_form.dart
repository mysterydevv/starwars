import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movie/models/stuff.dart';
import 'package:flutter_movie/screens/stuff_screen.dart';
import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/services/stuff_service.dart';
import 'package:flutter_movie/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

class StuffForm extends StatefulWidget {
  const StuffForm({super.key});

  @override
  StuffFormState createState() => StuffFormState();
}

class StuffFormState extends State<StuffForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String? image;
  XFile? pickedFile;
  FileService fileService = FileService();
  StuffService stuffService = StuffService();

  final picker = ImagePicker();
  bool isLoading = false; // Add a boolean variable to track loading state

  Future<void> pickImage() async {
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile!.path);

        setState(() {
          isLoading = true; // Set loading to true
        });

        // Upload the file and update the state after the upload completes
        fileService.upload(imageFile).then((value) {
          setState(() {
            image = value;
            isLoading = false; // Set loading to false after upload
          });
        }).catchError((error) {
          setState(() {
            isLoading = false; // Set loading to false in case of error
          });
          Helper.showErrorDialog(context, error.toString());
        });
      } else {
        // ignore: use_build_context_synchronously
        Helper.showErrorDialog(context, 'No image selected');
      }
    } catch (error) {
      setState(() {
        isLoading = false; // Set loading to false in case of error
      });
      // ignore: use_build_context_synchronously
      Helper.showErrorDialog(context, error.toString());
    }
  }

  bool validate() {
    return nameController.text.isNotEmpty &&
        activityController.text.isNotEmpty &&
        bioController.text.isNotEmpty &&
        image != null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        height: height * 0.7,
        width: width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add new stuff',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: activityController,
              decoration: const InputDecoration(
                labelText: 'Activity',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                if (isLoading) // Show CircularProgressIndicator when loading
                  const CircularProgressIndicator()
                else if (image == null)
                  const Text('No image selected.')
                else
                  Text(image!),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text('Pick Image'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (validate()) {
                          var stuff = Stuff(
                              null,
                              nameController.text,
                              activityController.text,
                              image!,
                              bioController.text);
                          await stuffService.addMemberOfStuff(stuff);
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const StuffScreen(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        } else {
                          Helper.showErrorDialog(context, 'Please fill all fields');
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    activityController.dispose();
    bioController.dispose();
    super.dispose();
  }
}


