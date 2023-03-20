import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
class ViewPdf extends StatefulWidget {
  ViewPdf(  {Key? key,  required this.document, }) : super(key: key);
   PDFDocument document;
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        child: PDFViewer(document: widget.document),
      )
    );
  }
}