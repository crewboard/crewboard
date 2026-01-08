import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/palette.dart';

class FilePreview extends StatelessWidget {
  const FilePreview({
    super.key,
    required this.name,
    required this.size,
    this.url,
  });
  final String name;
  final int size;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallet.inside2,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      constraints: const BoxConstraints(maxWidth: 200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 35,
            height: 42,
            child: Stack(
              children: [
                SvgPicture.asset(
                  getFileColor(name.split(".").last.toLowerCase()),
                  width: 35,
                  height: 42,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Text(
                    name.split(".").last.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 12, color: Pallet.font1),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  formatBytes(size),
                  style: const TextStyle(fontSize: 10, color: Pallet.font3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getFileColor(String fileType) {
    List<String> green = ["xlsx", "xls", "csv", "py", "apk"];
    List<String> red = ["pdf", "ppt", "pptx", "odp"];
    List<String> yellow = ["html", "ipa"];
    if (green.contains(fileType)) {
      return "assets/files/green.svg";
    } else if (red.contains(fileType)) {
      return "assets/files/red.svg";
    } else if (yellow.contains(fileType)) {
      return "assets/files/yellow.svg";
    } else {
      return "assets/files/blue.svg";
    }
  }

  String formatBytes(int bytes) {
    if (bytes <= 0) {
      return "0 B";
    }
    if (bytes < 1024) {
      return "$bytes B";
    }
    if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    }
    if (bytes < 1024 * 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    }
    return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB";
  }
}
