import 'dart:convert';
import 'dart:io';
import 'package:flutter_movie/models/response.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FileService {
  final String baseUrl = 'http://10.0.2.2:3000';
  Future<String> read(String path) async {
    try {
      Uri uri = Uri.parse('$baseUrl/image/$path');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        var data = Response.fromJson(responseBody);
        return data.data;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> upload(File photo) async {
    try {
      Uri uri = Uri.parse('$baseUrl/upload');
      var request = http.MultipartRequest('POST', uri);
      String fileExtension = photo.path.split('.').last.toLowerCase();
      MediaType? contentType;
      switch (fileExtension) {
        case 'png':
          contentType = MediaType('image', 'png');
          break;
        case 'jpg':
          contentType = MediaType('image', 'jpg');
          break;
        case 'jpeg':
          contentType = MediaType('image', 'jpeg');
          break;
        default:
          throw Exception('Unsupported file type');
      }
      request.files.add(await http.MultipartFile.fromPath('file', photo.path,
          contentType: contentType));
      request.headers.addAll({
        'accept': '*/*',
        'Content-Type': 'multipart/form-data',
      });
      var response = await request.send();
      var responeBody = jsonDecode(await response.stream.bytesToString());
      var data = Response.fromJson(responeBody);
      if (data.status == 200) {
        return data.data;
      }
      throw Exception(data.message);
    } catch (error) {
      throw Exception(error);
    }
  }
}
