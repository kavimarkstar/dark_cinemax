import 'package:dark_cinemax/core/pages/download/page/services/download_manager.dart';
import 'package:flutter/material.dart';

class DownloadViewPage extends StatefulWidget {
  const DownloadViewPage({Key? key}) : super(key: key);

  @override
  _DownloadViewPageState createState() => _DownloadViewPageState();
}

class _DownloadViewPageState extends State<DownloadViewPage> {
  @override
  void initState() {
    super.initState();
    // Refresh UI every 500ms
    Future.delayed(Duration.zero, _updateLoop);
  }

  void _updateLoop() async {
    while (mounted) {
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = DownloadManager.instance.tasks;

    return Scaffold(
      appBar: AppBar(title: const Text("Downloads")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final percent = (task.progress * 100).toStringAsFixed(0);

          return ListTile(
            title: Text(task.fileName),
            subtitle: Text("Progress: $percent% | Status: ${task.status.name}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (task.status == DownloadStatus.downloading)
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () => DownloadManager.instance.pause(task),
                  ),
                if (task.status == DownloadStatus.paused)
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => DownloadManager.instance.resume(task),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
