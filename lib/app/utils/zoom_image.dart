import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/config/app_config.dart';
import 'package:of_flutter_mobile/app/utils/file_downloader.dart';

class ZoomImageView extends StatelessWidget {
  ZoomImageView({super.key});

  final controller = Get.find<FileDownloader>();

  @override
  Widget build(BuildContext context) {
    final dynamic imageUrl = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.5,
            maxScale: 2.5,
            child: SizedBox(
              height: double.infinity,
              width: Get.width,
              child: Hero(
                tag: imageUrl,
                child: CachedNetworkImage(
                  imageUrl: "${AppConfig().getBaseUrl}/images/$imageUrl",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Center(
                      child: Text("${(downloadProgress.progress)}%"),
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 30,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => controller.downloadImage(imageUrl),
                    icon: const Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
