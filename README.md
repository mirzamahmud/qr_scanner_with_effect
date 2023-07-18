# qr_scanner_with_effect

A Flutter widget that will use for scanning QR Code and it also has scanning effect.

## Features


## Demo

![qr_scanner_with_effect demo](https://giphy.com/gifs/CYnuVBrQbEiqwOZbdO.gif "qr_scanner_with_effect demo")

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
