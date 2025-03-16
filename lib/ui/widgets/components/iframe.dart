import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:web/web.dart';

class Iframe extends StatefulWidget {
  final String url;
  const Iframe({super.key, required this.url});

  @override
  IframeState createState() => IframeState();
}

class IframeState extends State<Iframe> {
  late Widget iframeWidget;
  final HTMLIFrameElement iframeElement = HTMLIFrameElement();
  @override
  void initState() {
    super.initState();
    iframeElement.height = '100%';
    iframeElement.style.height = '100%';
    iframeElement.width = '100%';
    iframeElement.style.width = '100%';
    iframeElement.src = widget.url;
    iframeElement.style.border = 'none';
    ui.platformViewRegistry.registerViewFactory(
      widget.url,
      (int viewId) => iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.url);
  }
}
