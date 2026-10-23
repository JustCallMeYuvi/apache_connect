import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfAttachmentViewer extends StatefulWidget {
  const PdfAttachmentViewer({
    super.key,
    required this.bytes,
  });

  final Uint8List bytes;

  @override
  State<PdfAttachmentViewer> createState() => _PdfAttachmentViewerState();
}

class _PdfAttachmentViewerState extends State<PdfAttachmentViewer> {
  late final bool _isWindows;
  PdfController? _controller;
  PdfControllerPinch? _pinchController;

  @override
  void initState() {
    super.initState();

    _isWindows = !kIsWeb && Platform.isWindows;

    final document = PdfDocument.openData(widget.bytes);

    if (_isWindows) {
      _controller = PdfController(document: document);
    } else {
      _pinchController = PdfControllerPinch(
        document: document,
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _pinchController?.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_isWindows) {
      return SizedBox.expand(
        child: PdfView(
          controller: _controller!,
          scrollDirection: Axis.vertical,
          pageSnapping: false,
          physics: const ClampingScrollPhysics(),
        ),
      );
    }

    return SizedBox.expand(
      child: PdfViewPinch(
        controller: _pinchController!,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
