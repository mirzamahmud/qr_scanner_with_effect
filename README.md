# qr_scanner_with_effect

A Flutter widget that will use for scanning QR Code and it also has scanning effect.

# QR Scanner with Effect

[![pub package](https://img.shields.io/pub/v/qr_scanner_with_effect?include_prereleases)](https://pub.dartlang.org/packages/qr_scanner_with_effect)
[![GH Actions](https://github.com/juliuscanute/qr_code_scanner/workflows/dart/badge.svg)](https://github.com/mirzamahmud/qr_scanner_with_effect/actions)

## Features

| Parameter                                                       | Definition                                                                                                            |
|-----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `GlobalKey<State<StatefulWidget>> qrKey`                        | (Required) [qrKey] uniquely identify elements                                                                         |
| `void Function(QRViewController) onQrScannerViewCreated`        | (Required) [onQRViewCreated] gets called when the view is created                                                     | 
| `EdgeInsetsGeometry overlayMargin`                              | (Predefined)  use [overlayMargin] to provide a margin to [overlay]                                                    |
| `CameraFacing cameraFacing`                                     | (Predefined)  Set which camera to use on startup.[cameraFacing] can either be CameraFacing.front or CameraFacing.back |
| `void Function(QRViewController, bool)? onPermissionSet`        | (Optional) Calls the provided [onPermissionSet] callback when the permission is set                                   | 
| `List<BarcodeFormat> formatsAllowed`                            | (Predefined) Use [formatsAllowed] to specify which formats needs to be scanned                                        |
 | `Color qrOverlayBorderColor`                                    | (Required) [qrOverlayBorderColor] is used for giving color of qr overlay border                                       | 
| `double qrOverlayBorderRadius`                                  | (Predefined) [qrOverlayBorderRadius] is used for giving border radius of qr overlay border                            | 
| `double qrOverlayBorderWidth`                                   | (Predefined) [qrOverlayBorderWidth] it defines the width of the qr overlay border                                     |
| `double qrOverlayBorderLength`                                  | (Predefined) [qrOverlayBorderLength] it defines the length of the qr overlay border                                   |
| `Gradient? effectGradient`                                      | (Optional) use [effectGradient] for effect animated color from begin to top                                           |
| `double effectWidth`                                            | (Predefined) [effectWidth] define the width of the effect                                                             |
| `bool isScanComplete`                                           | (Predefined) [isScanComplete] is used for remove effect after scanning complete                                       |
| `Color? effectColor`                                            | (Optional) use [effectColor] for color of the effect                                                                  |
| `double? cutOutSize`                                            |                                                                                                                       | 
| `double? cutOutHeight`                                          |                                                                                                                       |
| `double? cutOutWidth`                                           |                                                                                                                       |
| `double cutOutBottomOffset`                                     |                                                                                                                       |


## Demo

![ezgif com-optimize](https://github.com/mirzamahmud/qr_scanner_with_effect/assets/91328350/fb8d1da5-19a6-492d-adb3-c152963d3fc3)

## Installation

Add dependency for package on your pubspec.yaml:

```yaml
    dependencies:
      qr_scanner_with_effect: latest
```
or

```shell
flutter pub add qr_scanner_with_effect
```

## Usage

```dart
QrScannerWithEffect(
  isScanComplete: isComplete,
  qrKey: qrKey,
  onQrScannerViewCreated: onQrScannerViewCreated,
  qrOverlayBorderColor: Colors.redAccent,
  cutOutSize: (MediaQuery.of(context).size.width < 300 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0,
  onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
  effectGradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1],
    colors: [
      Colors.redAccent,
      Colors.redAccent,
    ],
  ),
)
```
## Additional information

This package is built on "qr_code_scanner". When we use "qr_scanner_with_effect" package than we also use "qr_code_scanner" package for fetching its controller.
