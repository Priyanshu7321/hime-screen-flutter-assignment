import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PDFScreen(),
    );
  }
}

class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    final ByteData data = await rootBundle.load('assets/pdfs/Priyanshu_tanwar_USAR_GGSIPU.pdf');
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File("${tempDir.path}/example.pdf");
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    setState(() {
      pathPDF = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text("PDF Viewer"),),
      ),
      body: pathPDF.isNotEmpty
          ? PDFView(
        filePath: pathPDF,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
