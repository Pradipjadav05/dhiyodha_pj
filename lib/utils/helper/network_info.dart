import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
// import 'package:image_compression_flutter/image_compression_flutter.dart';

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /*static Future<Uint8List> compressImage(XFile file) async {
    final ImageFile input =
        ImageFile(filePath: file.path, rawBytes: await file.readAsBytes());
    final Configuration config = Configuration(
      outputType: ImageOutputType.webpThenPng,
      useJpgPngNativeCompressor: false,
      quality: (input.sizeInBytes / 1048576) < 2
          ? 90
          : (input.sizeInBytes / 1048576) < 5
              ? 50
              : (input.sizeInBytes / 1048576) < 10
                  ? 10
                  : 1,
    );
    final ImageFile output = await compressor
        .compress(ImageFileConfiguration(input: input, config: config));
    if (kDebugMode) {
      debugPrint('Input size : ${input.sizeInBytes / 1048576}');
      debugPrint('Output size : ${output.sizeInBytes / 1048576}');
    }
    return output.rawBytes;
  }*/
}
