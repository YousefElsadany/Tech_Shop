import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_shop/shared/style/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVeiwScreen extends StatelessWidget {
  late final String url;

  WebVeiwScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: fullBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: fullBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: shopColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
