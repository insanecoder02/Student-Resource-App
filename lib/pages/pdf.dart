import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget {
  final String url;
  final int sem;
  final String subjectCode;
  final String typeKey;
  final int uniqueID;
  final String title;
  PDFViewer(
      {required this.url,
      required this.sem,
      required this.subjectCode,
      required this.typeKey,
      required this.uniqueID,
      required this.title});
  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  String pathPDF = "";

  @override
  // void initState() {
  //   super.initState();
  //   createFile().then((f) {
  //     setState(() {
  //       pathPDF = f.path;
  //       print(pathPDF);
  //     });
  //   });
  // }

  Future<File?> createFile() async {
    try {
      String url = widget.url;
      final fileID = widget.uniqueID;
      String dir = (await getApplicationDocumentsDirectory()).path;
      String path =
          '$dir/${widget.sem}_${widget.subjectCode}_${widget.typeKey[0]}_${fileID}_${widget.title}';
      if (await File(path).exists()) {
        //print('$path is already present');
        return File(path);
      }
      //print('Creating new file $path');
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      File file = new File(path);
      await file.writeAsBytes(bytes);
      return file;
    } catch (err) {
      var errorMessage = "Error";
      print(errorMessage);
      print(err);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return pathPDF == ''
        ? Scaffold(
      body: Center(
        child: Text(
          "PDF Viewer is not available. Please install a PDF viewer to see the content.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
          )
        : Scaffold(
      appBar: AppBar(
        title: Text("Document"),
      ),
      body: Center(
        child: Text(
          "PDF Viewer is not available. Please install a PDF viewer to see the content.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
