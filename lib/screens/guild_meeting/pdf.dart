import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({Key? key, required this.url, required this.title}) : super(key: key);
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        fitPolicy: FitPolicy.WIDTH,
        fitEachPage: false,
        onError: (error) {
          print(error.toString());
        },
        onPageChanged: (int? page, int? total) {
          print('page change: $page/$total');
        },
      ).cachedFromUrl(url),
    );
  }
}
