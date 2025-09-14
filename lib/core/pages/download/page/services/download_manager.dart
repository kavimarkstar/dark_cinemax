import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

enum DownloadStatus { downloading, paused, completed }

class DownloadTask {
  final String fileName;
  final String url;
  double progress;
  DownloadStatus status;
  CancelToken cancelToken;

  DownloadTask({
    required this.fileName,
    required this.url,
    this.progress = 0,
    this.status = DownloadStatus.downloading,
    CancelToken? cancelToken,
  }) : cancelToken = cancelToken ?? CancelToken();
}

class DownloadManager {
  DownloadManager._privateConstructor();
  static final DownloadManager _instance =
      DownloadManager._privateConstructor();
  static DownloadManager get instance => _instance;

  final Dio dio = Dio();
  final List<DownloadTask> tasks = [];

  Future<String> _getSavePath(String fileName) async {
    final dir = await getExternalStorageDirectory();
    final folder = Directory("${dir!.path}/Movies/Dark Cinema");
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return "${folder.path}/$fileName";
  }

  void addTask(String url, String fileName) {
    final task = DownloadTask(fileName: fileName, url: url);
    tasks.add(task);
    _startDownload(task);
  }

  void _startDownload(DownloadTask task) async {
    final path = await _getSavePath(task.fileName);
    try {
      task.status = DownloadStatus.downloading;
      await dio.download(
        task.url,
        path,
        cancelToken: task.cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            task.progress = received / total;
          }
        },
      );
      task.progress = 1.0;
      task.status = DownloadStatus.completed;
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) {
        task.status = DownloadStatus.paused;
      }
    }
  }

  // ✅ Pause a specific task
  void pause(DownloadTask task) {
    task.cancelToken.cancel("Paused");
    task.status = DownloadStatus.paused;
  }

  // ✅ Resume a specific task
  void resume(DownloadTask task) {
    if (task.status == DownloadStatus.paused) {
      task.cancelToken = CancelToken(); // reset cancel token
      _startDownload(task);
    }
  }
}
