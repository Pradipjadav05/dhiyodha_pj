import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showAttendanceSuccessDialog(
  BuildContext context, {
  String? visitorName,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.22),
    builder: (_) => _AttendanceSuccessDialog(visitorName: visitorName),
  );
}

class _AttendanceSuccessDialog extends StatefulWidget {
  final String? visitorName;

  const _AttendanceSuccessDialog({this.visitorName});

  @override
  State<_AttendanceSuccessDialog> createState() =>
      _AttendanceSuccessDialogState();
}

class _AttendanceSuccessDialogState extends State<_AttendanceSuccessDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String displayName =
        widget.visitorName?.trim().isNotEmpty == true
            ? widget.visitorName!.trim()
            : "visitor".tr;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 290,
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x24131824),
                    blurRadius: 28,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _AnimatedCheck(),
                  const SizedBox(height: 18),
                  Text(
                    "attendance_success_title".tr,
                    textAlign: TextAlign.center,
                    style: fontBold.copyWith(
                      fontSize: 20,
                      color: const Color(0xFF161922),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "attendance_recorded_for".trParams({
                      "name": displayName,
                    }),
                    textAlign: TextAlign.center,
                    style: fontRegular.copyWith(
                      fontSize: 13,
                      height: 1.45,
                      color: const Color(0xFF707788),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Divider(height: 1, color: Color(0xFFE8EBF2)),
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 46),
                      overlayColor:
                          const Color(0xFF121A44).withValues(alpha: 0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "close".tr,
                      style: fontMedium.copyWith(
                        fontSize: 15,
                        color: const Color(0xFF1C2230),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedCheck extends StatefulWidget {
  const _AnimatedCheck();

  @override
  State<_AnimatedCheck> createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<_AnimatedCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 88,
        height: 88,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF2CE56E),
        ),
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 56,
        ),
      ),
    );
  }
}
