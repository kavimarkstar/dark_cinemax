import 'package:dark_cinemax/core/pages/download/page/services/download_manager.dart';
import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  final String url;
  final String fileName;

  const DownloadButton({Key? key, required this.url, required this.fileName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: const Text("Download"),
      onPressed: () {
        DownloadManager.instance.addTask(url, fileName);
      },
    );
  }
}
