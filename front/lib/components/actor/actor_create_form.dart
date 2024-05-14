import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movie/models/actors.dart';
import 'package:flutter_movie/screens/actor_screen.dart';
import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/actor_service.dart';

class ActorForm extends StatefulWidget {
  const ActorForm({super.key});

  @override
  ActorFormState createState() => ActorFormState();
}

class ActorFormState extends State<ActorForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController ageController;
  late TextEditingController biographyController;
  late TextEditingController dateOfBirthController;
  late TextEditingController moviesController;
  late TextEditingController awardsController;
  String? image;
  XFile? pickedFile;
  final picker = ImagePicker();
  bool isLoading = false;
  ActorService actorService = ActorService();
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    roleController = TextEditingController();
    ageController = TextEditingController();
    biographyController = TextEditingController();
    dateOfBirthController = TextEditingController();
    moviesController = TextEditingController();
    awardsController = TextEditingController();
  }

  Future<void> pickImage() async {
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile!.path);

        setState(() {
          isLoading = true;
        });

        // Simulate an image upload and set the image path
        await Future.delayed(
            const Duration(seconds: 1)); // Simulating upload delay

        fileService.upload(imageFile).then((value) {
          setState(() {
            image = value;
            isLoading = false;
          });
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Helper.showErrorDialog(context, error.toString());
        });
      } else {
        // ignore: use_build_context_synchronously
        Helper.showErrorDialog(context, 'No image selected');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Helper.showErrorDialog(context, error.toString());
    }
  }

  bool validate() {
    return _formKey.currentState!.validate() && image != null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Actor'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: biographyController,
                decoration: const InputDecoration(
                  labelText: 'Biography',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter biography';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: moviesController,
                decoration: const InputDecoration(
                  labelText: 'Movies (comma separated)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one movie';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: awardsController,
                decoration: const InputDecoration(
                  labelText: 'Awards (comma separated)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one award';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  if (isLoading)
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
              var newActor = Actor(
                  id: null,
                  role: roleController.text,
                  movies: moviesController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                  awards: awardsController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                  biography: biographyController.text,
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  image: image!);
              await actorService.addActor(newActor);
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ActorScreen()));
            } else {
              Helper.showErrorDialog(context, 'Please fill all fields');
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    ageController.dispose();
    biographyController.dispose();
    dateOfBirthController.dispose();
    moviesController.dispose();
    awardsController.dispose();
    super.dispose();
  }
}
