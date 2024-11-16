import 'package:Yes_Loyalty/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late final WebViewController controller;
  late final String fileUrl;
  bool isPdf = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the URL from the arguments and determine its file type
    fileUrl = ModalRoute.of(context)!.settings.arguments.toString();
    isPdf = fileUrl.toLowerCase().endsWith('.pdf');

    if (isPdf) {
      // For PDFs, use Google Docs viewer for compatibility
      controller.loadRequest(
          Uri.parse("https://docs.google.com/gview?embedded=true&url=$fileUrl"));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            HomeAppBar(
              onBackTap: () {
                Navigator.of(context).pop();
              },
              isthereQr: false,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isPdf
                  ? WebViewWidget(controller: controller)
                  : Center(
                      child: Image.network(
                        fileUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text("Error loading image");
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
