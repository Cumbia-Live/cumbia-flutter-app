import 'package:cumbialive/components/catapulta_scroll_view.dart';
import 'package:cumbialive/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LegalScreen extends StatefulWidget {
  LegalScreen({@required this.pNumber});
  final int pNumber;
  @override
  _LegalScreenState createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  PdfViewerController _pdfViewerController = PdfViewerController();
  @override
  void initState() {
    print(widget.pNumber);
    _pdfViewerController.jumpToPage(widget.pNumber);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: Palette.white,
       // actionsForegroundColor: Palette.black,
        border: Border(bottom: BorderSide.none),
        middle: Text(
          "Legal",
          style: Styles.navTitleLbl,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SfPdfViewer.asset(
          'images/trm.pdf',
          controller: _pdfViewerController,
        ),
      ),
    );
  }
}
