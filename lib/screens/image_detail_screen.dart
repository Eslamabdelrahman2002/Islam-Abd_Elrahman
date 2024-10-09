import 'package:flutter/material.dart';

import '../api_service/api_service.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  ImageDetailScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ApiService.downloadImage('https://image.tmdb.org/t/p/w500$imageUrl');
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network('https://image.tmdb.org/t/p/w500$imageUrl'),
        ),
      ),
    );
  }
}
