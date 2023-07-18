import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef QRViewCreatedCallback = void Function(QRViewController);
typedef PermissionSetCallback = void Function(QRViewController, bool);

class QrScannerWithEffect extends StatefulWidget {

  /// [qrKey] uniquely identify elements
  final GlobalKey qrKey;

  /// [onQRViewCreated] gets called when the view is created
  final QRViewCreatedCallback onQrScannerViewCreated;

  /// use [overlayMargin] to provide a margin to [overlay]
  final EdgeInsetsGeometry overlayMargin;

  /// Set which camera to use on startup.
  /// [cameraFacing] can either be CameraFacing.front or CameraFacing.back.
  /// Defaults to CameraFacing.back
  final CameraFacing cameraFacing;

  /// Calls the provided [onPermissionSet] callback when the permission is set.
  final PermissionSetCallback? onPermissionSet;

  /// Use [formatsAllowed] to specify which formats needs to be scanned.
  final List<BarcodeFormat> formatsAllowed;

  /// use [effectGradient] for effect animated color from begin to top
  final Gradient? effectGradient;

  /// use [effectColor] for color of the effect
  final Color? effectColor;

  /// [qrOverlayBorderColor] is used for giving color of qr overlay border
  final Color qrOverlayBorderColor;

  /// [qrOverlayBorderRadius] is used for giving border radius of qr overlay border
  final double qrOverlayBorderRadius;

  /// [qrOverlayBorderLength] it defines the length of the qr overlay border
  final double qrOverlayBorderLength;

  /// [qrOverlayBorderWidth] it defines the width of the qr overlay border
  final double qrOverlayBorderWidth;

  final double? cutOutSize;
  final double? cutOutWidth;
  final double? cutOutHeight;
  final double cutOutBottomOffset;

  /// [effectWidth] define the width of the effect
  final double effectWidth;

  /// [isScanComplete] is used for remove effect after scanning complete
  final bool isScanComplete;

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
    this.effectWidth = 250,
    this.isScanComplete = false,
    this.effectColor,
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
        widget.isScanComplete ? Align(
          alignment: Alignment.center,
          child: Container(),
        ) : Align(
          alignment: Alignment.center,
          child: SlideTransition(
            position: offsetAnimation,
            child: Container(
              height: 2,
              width: widget.effectWidth,
              decoration: BoxDecoration(
                color: widget.effectColor,
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