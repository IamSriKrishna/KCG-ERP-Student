import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kcgerp/Widget/Additional/TobbarArea.dart';
import 'package:kcgerp/Widget/Additional/WebView.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutWebviewScreen extends StatelessWidget {
  static const route = '/AboutWebviewScreen';

  const AboutWebviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutWebviewScreenController());
    return Scaffold(
      body: Column(
        children: [
          TopBarArea(title: S.current.about),
          Expanded(child: WebViewWidget(controller: controller.controller)),
        ],
      ),
    );
  }
}

