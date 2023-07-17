# qr_scanner_with_effect

A Flutter widget that will use for scanning QR Code and it also has scanning effect.

## Features


## Demo

https://github.com/mirzamahmud/qr_scanner_with_effect/assets/91328350/397e1a12-a10e-4c61-822c-3f8c7c2906ea

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
