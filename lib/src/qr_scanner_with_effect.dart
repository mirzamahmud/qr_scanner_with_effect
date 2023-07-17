import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef QRViewCreatedCallback = void Function(QRViewController);
typedef PermissionSetCallback = void Function(QRViewController, bool);

class QrScannerWithEffect extends StatefulWidget {

  final GlobalKey qrKey;

  /// [onQRViewCreated] gets called when the view is created
  final QRViewCreatedCallback onQrScannerViewCreated;

  /// Use [overlayMargin] to provide a margin to [overlay]
  final EdgeInsetsGeometry overlayMargin;

  /// Set which camera to use on startup.
  ///
  /// [cameraFacing] can either be CameraFacing.front or CameraFacing.back.
  /// Defaults to CameraFacing.back
  final CameraFacing cameraFacing;

  /// Calls the provided [onPermissionSet] callback when the permission is set.
  final PermissionSetCallback? onPermissionSet;

  /// Use [formatsAllowed] to specify which formats needs to be scanned.
  final List<BarcodeFormat> formatsAllowed;

  final Gradient? effectGradient;

  final Color qrOverlayBorderColor;
  final double qrOverlayBorderRadius;
  final double qrOverlayBorderLength;
  final double qrOverlayBorderWidth;

  final double? cutOutSize;
  final double? cutOutWidth;
  final double? cutOutHeight;
  final double cutOutBottomOffset;

  final double effectHeight;
  final double effectWidth;

  const QrScannerWithEffect({
    required this.qrKey,
    required this.onQrScannerViewCreated,
    this.overlayMargin = EdgeInsets.zero,
    this.cameraFacing = CameraFacing.back,
    this.onPermissionSet,
    this.formatsAllowed = const <BarcodeFormat>[],
    required this.qrOverlayBorderColor,
    this.qrOverlayBorderRadius = 0,
    this.qrOverlayBorderWidth = 5,
    this.qrOverlayBorderLength = 40,
    this.cutOutSize,
    this.cutOutHeight,
    this.cutOutWidth,
    this.cutOutBottomOffset = 0,
    this.effectGradient,
    this.effectHeight = 2,
    this.effectWidth = 250,

    super.key
  });

  @override
  State<QrScannerWithEffect> createState() => _QrScannerWithEffectState();
}

class _QrScannerWithEffectState extends State<QrScannerWithEffect> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -50),
      end: const Offset(0, 50),
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        QRView(
          key: widget.qrKey,
          onQRViewCreated: widget.onQrScannerViewCreated,
          cameraFacing: widget.cameraFacing,
          overlay: QrScannerOverlayShape(
            borderColor: widget.qrOverlayBorderColor,
            borderRadius: widget.qrOverlayBorderRadius,
            borderLength: widget.qrOverlayBorderLength,
            borderWidth: widget.qrOverlayBorderWidth,
            cutOutSize: widget.cutOutSize,
            cutOutWidth: widget.cutOutWidth,
            cutOutHeight: widget.cutOutHeight,
            cutOutBottomOffset: widget.cutOutBottomOffset,
          ),
          onPermissionSet: widget.onPermissionSet,
          formatsAllowed: widget.formatsAllowed,
        ),
        Align(
          alignment: Alignment.center,
          child: SlideTransition(
            position: offsetAnimation,
            child: Container(
              height: widget.effectHeight,
              width: widget.effectWidth,
              decoration: BoxDecoration(
                gradient: widget.effectGradient,
              ), // Adjust the color of the scanning animation
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}