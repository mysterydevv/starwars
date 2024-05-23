import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_movie/models/news.dart';
import 'package:flutter_movie/screens/news_screen.dart';

import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/services/news_service.dart';
import 'package:flutter_movie/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

class UpdateNewsDialog extends StatefulWidget {
  final News news;

  const UpdateNewsDialog({super.key, required this.news});

  @override
  UpdateNewsDialogState createState() => UpdateNewsDialogState();
}

//  late String? id;
//   late String? title;
//   late String content;
//   late String author;
//   late String date;
//   late String image;
class UpdateNewsDialogState extends State<UpdateNewsDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController authorController;
  late TextEditingController dateController;

  String? image;
  XFile? pickedFile;
  final picker = ImagePicker();
  bool isLoading = false;
  NewsService newsService = NewsService();
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.news.title);
    contentController = TextEditingController(text: widget.news.content);
    authorController = TextEditingController(text: widget.news.author);
    dateController = TextEditingController(text: widget.news.date);

    image = widget.news.image;
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
      title: const Text('Update News'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'date',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
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
              var updatedNews = News(
                id: widget.news.id,
                title: titleController.text,
                content: contentController.text,
                author: authorController.text,
                date: dateController.text,
                image: image!,
              );
              await newsService.updateNews(updatedNews);
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()));
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
    titleController.dispose();
    contentController.dispose();
    authorController.dispose();
    dateController.dispose();

    super.dispose();
  }
}
