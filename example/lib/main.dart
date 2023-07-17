import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner_with_effect/qr_scanner_with_effect.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isComplete = false;

  void onQrScannerViewCreated(QRViewController controller) {

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{

      result = scanData;
      controller.pauseCamera();

      await Future<void>.delayed(const Duration(milliseconds: 300));

      String? myQrCode = result?.code!=null && result!.code.toString().isNotEmpty ?result?.code.toString():'';
      if(myQrCode!=null && myQrCode.isNotEmpty){
        manageQRData(myQrCode);
      }

    });
  }

  void manageQRData(String myQrCode)async{
    controller?.stopCamera();
    setState(() {
      isComplete = true;
    });
  }

  @override
  void reassemble() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
    super.reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller?.stopCamera();
    super.dispose();
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return QrScannerWithEffect(
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
              );
            }
        ),
      ),
    );
  }
}
