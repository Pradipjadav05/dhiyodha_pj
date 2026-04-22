import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/home_viewmodel.dart';
import '../widgets/image_zoom_in_out.dart';

class SpeakerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<HomeViewModel>();

    final data =
        homeVM.businessPresentationBannerList.isNotEmpty ? homeVM.businessPresentationBannerList : [];

    return Scaffold(
      appBar: AppBar(title: Text("Speakers")),
      body: data.isEmpty
          ? Center(child: Text("No Data"))
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              if ((item.url ?? "").isNotEmpty) {
                                _openBannerViewer(
                                  context,
                                  item.url!,
                                  item.fileName ?? "",
                                );
                              }
                            },
                            child: CachedNetworkImage(
                              imageUrl: item.url ?? "",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Title
                        Row(
                          children: [
                            Text(
                              "Speaker Title: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                item.fileName ?? "-",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _openBannerViewer(
      BuildContext context,
      String imageUrl,
      String title,
      ) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) {
          return FullScreenBannerView(
            imageUrl: imageUrl,
            title: title,
          );
        },
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

