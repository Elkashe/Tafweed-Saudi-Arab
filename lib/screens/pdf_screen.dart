import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tafweed/services/dio/pdf_services.dart';

class PdfScreen extends StatelessWidget {
  final String path;
  const PdfScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              MediaDownload().downloadMedia(context, path);
            }, 
            icon: Icon(Icons.download_rounded),
          )
        ],
      ),
      body: FutureBuilder(
        future: PdfServices().download(path), 
        builder: (context, snapshot){
          if(snapshot.hasData){
            return PDFView(
              filePath: snapshot.data!.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onError: (error) {
                print("error:::: ${error.toString()}");
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            );
          }
          else{
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}