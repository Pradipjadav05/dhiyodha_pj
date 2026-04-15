import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AttendanceScannerPage extends StatefulWidget {
  const AttendanceScannerPage({super.key});

  @override
  State<AttendanceScannerPage> createState() => _AttendanceScannerPageState();
}

class _AttendanceScannerPageState extends State<AttendanceScannerPage> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool _isProcessingScan = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _handleDetection(BarcodeCapture capture) async {
    if (_isProcessingScan) {
      return;
    }

    if (capture.barcodes.isEmpty) {
      return;
    }

    final String? scannedValue = capture.barcodes.first.rawValue;
    if (scannedValue == null || scannedValue.trim().isEmpty) {
      return;
    }

    _isProcessingScan = true;
    await _scannerController.stop();

    if (!mounted) {
      return;
    }

    Get.back(result: scannedValue.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(
            "scan_qr_code_for_attendance".tr,
            style: fontBold.copyWith(
              color: Colors.white,
              fontSize: fontSize16,
            ),
          ),
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: _scannerController,
              onDetect: _handleDetection,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.22),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.26),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 255,
                height: 255,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 172,
                      height: 172,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8557F7),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      left: 0,
                      child: _ScannerCorner(top: true, left: true),
                    ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: _ScannerCorner(top: true, left: false),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      child: _ScannerCorner(top: false, left: true),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: _ScannerCorner(top: false, left: false),
                    ),
                    Container(
                      width: 210,
                      height: 2.5,
                      color: const Color(0xFF8557F7),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 58,
              child: Text(
                'align_qr_code_inside_frame'.tr,
                textAlign: TextAlign.center,
                style: fontRegular.copyWith(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: fontSize14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerCorner extends StatelessWidget {
  final bool top;
  final bool left;

  const _ScannerCorner({
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: CustomPaint(
        painter: _ScannerCornerPainter(
          color: const Color(0xFF8557F7),
          top: top,
          left: left,
        ),
      ),
    );
  }
}

class _ScannerCornerPainter extends CustomPainter {
  final Color color;
  final bool top;
  final bool left;

  const _ScannerCornerPainter({
    required this.color,
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final Path path = Path();

    if (top && left) {
      path.moveTo(size.width, 0);
      path.lineTo(14, 0);
      path.quadraticBezierTo(0, 0, 0, 14);
      path.lineTo(0, size.height);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width - 14, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 14);
      path.lineTo(size.width, size.height);
    } else if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height - 14);
      path.quadraticBezierTo(0, size.height, 14, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height - 14);
      path.quadraticBezierTo(
          size.width, size.height, size.width - 14, size.height);
      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ScannerCornerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.top != top ||
        oldDelegate.left != left;
  }
}
