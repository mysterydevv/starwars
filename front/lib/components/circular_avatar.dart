import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class OwnCircularAvatar extends StatefulWidget {
  final Future<String> image;
  final int radius;

  const OwnCircularAvatar({super.key, required this.image, this.radius = 100});
  @override
  State<StatefulWidget> createState() {
    return OwnCircularAvatarState();
  }
}

class OwnCircularAvatarState extends State<OwnCircularAvatar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: widget.image,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: widget.radius.toDouble(),
            backgroundColor: Colors.grey,
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          Uint8List bytes = base64Decode(snapshot.data!);
          return CircleAvatar(
            radius: widget.radius.toDouble(),
            backgroundImage: MemoryImage(bytes),
          );
        } else {
          return CircleAvatar(
            radius: widget.radius.toDouble(),
            backgroundColor: Colors.grey,
            child: const Icon(Icons.error),
          );
        }
      },
    );
  }
}
