import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../model/person_model.dart';
import '../model/user_info_model.dart';
import '../model/user_images_model.dart';

class ApiService {
  static const String apiKey = '2dfe23358236069710a379edd4c65a6b';

  static Future<List<Person>> fetchFamousPersons() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/person/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Failed to load famous persons');
    }
  }

  static Future<UserInfo> fetchUserInfoFromApi(int personId) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/person/$personId?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return UserInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user info');
    }
  }

  static Future<List<UserImage>> fetchUserImagesFromApi(int personId) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/person/$personId/images?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['profiles'] as List).map((image) => UserImage.fromJson(image)).toList();
    } else {
      throw Exception('Failed to load user images');
    }
  }

  // New method to download the image
  static Future<void> downloadImage(String imageUrl) async {
    try {
      // Fetch the image from the URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get the directory for storing images
        final directory = await getApplicationDocumentsDirectory();

        // Create a file path with a valid name
        String filePath = '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Save the image file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Image downloaded to: $filePath');
        // Optionally, show a success message here
      } else {
        throw Exception('Failed to download image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}
