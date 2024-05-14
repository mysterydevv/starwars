import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movie/models/stuff.dart';
import 'package:flutter_movie/screens/stuff_screen.dart';
import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/services/stuff_service.dart';
import 'package:flutter_movie/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

class UpdateStuffDialog extends StatefulWidget {
  final Stuff stuff;

  const UpdateStuffDialog({super.key, required this.stuff});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateStuffDialogState createState() => _UpdateStuffDialogState();
}

class _UpdateStuffDialogState extends State<UpdateStuffDialog> {
  late TextEditingController nameController;
  late TextEditingController activityController;
  late TextEditingController bioController;
  String? image;
  XFile? pickedFile;
  FileService fileService = FileService();
  StuffService stuffService = StuffService();
   

  final picker = ImagePicker();
  bool isLoading = false; // Add a boolean variable to track loading state

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.stuff.name);
    activityController = TextEditingController(text: widget.stuff.activity);
    bioController = TextEditingController(text: widget.stuff.biography);
    image = widget.stuff.image;
  }

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
    return AlertDialog(
      title: const Text('Update Stuff'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: activityController,
              decoration: const InputDecoration(
                labelText: 'Activity',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (validate()) {
              var updatedStuff = Stuff(
                widget.stuff.id,
                nameController.text,
                activityController.text,
                image!,
                bioController.text,
              );
              await stuffService.updateMemberOfStuff(updatedStuff);
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
          child: const Text('Update'),
        ),
      ],
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
