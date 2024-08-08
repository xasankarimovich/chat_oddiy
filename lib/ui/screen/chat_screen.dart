import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/models/message.dart';

class ChatScreen extends StatelessWidget {
  final int contactId;

  const ChatScreen({super.key, required this.contactId});

  Future<void> _downloadFile(
      String url, String fileName, BuildContext context) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DownloadProgressDialog(
              url: url, fileName: fileName, dirPath: dir.path),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Download failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.freepik.com/512/180/180656.png?ga=GA1.1.969355796.1713496108'),
            ),
            SizedBox(width: 10),
            Text(
              'Xasan',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: allMessages.length,
              itemBuilder: (context, index) {
                final message = allMessages[index];
                final isMe = message.contactId == contactId;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.redAccent : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: message.isFile
                        ? GestureDetector(
                            onTap: () {
                              _downloadFile(message.messageText,
                                  "downloaded_file", context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'File: ${message.messageText}',
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.white,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Download',
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.download,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Text(
                            message.messageText,
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black),
                          ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Ok great, let me ask around...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.redAccent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadProgressDialog extends StatefulWidget {
  final String url;
  final String fileName;
  final String dirPath;

  const DownloadProgressDialog({
    super.key,
    required this.url,
    required this.fileName,
    required this.dirPath,
  });

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  late Dio _dio;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _startDownload();
  }

  void _startDownload() async {
    try {
      await _dio.download(
        widget.url,
        "${widget.dirPath}/${widget.fileName}",
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );
      if (mounted) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Download complete",
            backgroundColor: Colors.green,
            textColor: Colors.white);
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Download failed: $e",
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Downloading..."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _progress),
          const SizedBox(height: 20),
          Text("${(_progress * 100).toStringAsFixed(0)}%"),
        ],
      ),
    );
  }
}
