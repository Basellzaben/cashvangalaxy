import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui';
import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/connection_status.dart';
import 'package:blue_print_pos/receipt/receipt_alignment.dart';
import 'package:blue_print_pos/receipt/receipt_section_text.dart';
import 'package:blue_print_pos/receipt/receipt_text_size_type.dart';
import 'package:blue_print_pos/receipt/receipt_text_style_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../provider/SalesInvoice.dart';
import 'package:image/image.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:image/image.dart' as Image;
void main() {
  runApp(const Prinitng());
}

class Prinitng extends StatelessWidget {
  const Prinitng({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طباعه الفاتوره',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:  MyHomePage(title: 'طباعه الفاتوره'),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);

   String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice? _selectedDevice;
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = false;
  int _loadingAtIndex = -1;
  late BuildContext c;

  Future<void> _onScanPressed() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,].request();
      if (statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
          statuses[Permission.bluetoothConnect] != PermissionStatus.granted) {
        return;
      }
    }

    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        try{
          setState(() => _isLoading = false);

        }catch(_){
          if(mounted)
          Navigator.of(context, rootNavigator: true).pop();

        }
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
        });
      }
    });
  }

  void _onSelectDevice(int index,BuildContext context) {
    _refreshItems(context);
    setState(() {
      _isLoading = true;
      _loadingAtIndex = index;
    });
    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      if (status == ConnectionStatus.connected) {
        setState(() => _selectedDevice = blueDevice);
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        if (kDebugMode) {
          print('$runtimeType - something wrong');
        }
      }
      setState(() => _isLoading = false);
    });
  }

 /* Future<void> _onPrintReceipt() async {
    /// Example for Print Image
    final ByteData logoBytes = await rootBundle.load('assets/logoprint.png',);

    /// Example for Print Text
    final ReceiptSectionText receiptText = ReceiptSectionText();
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 300,);
    receiptText.addSpacer();
    receiptText.addText('Galaxy Group',
     size: ReceiptTextSizeType.medium,
     style: ReceiptTextStyleType.bold,
    );
    receiptText.addText('Cash Van',size: ReceiptTextSizeType.small,
    );
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText("${context.read<SalesInvoiceProvider>().MaxOrder}", 'رقم الفاتوره');
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText("${context.read<SalesInvoiceProvider>().Name}", 'اسم العميل');
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText("${context.read<SalesInvoiceProvider>().No}", 'رقم العميل');
    receiptText.addSpacer(useDashed: true);


    receiptText.addText('السعر', alignment: ReceiptAlignment.left
    );
    receiptText.addText('الكميه', alignment: ReceiptAlignment.center);
    receiptText.addText('اسم الماده',alignment: ReceiptAlignment.right);

    receiptText.addSpacer(useDashed: true);

    for(int index=0;index<_journals.length;index++){

      receiptText.addText(_journals[index]['netprice'], alignment: ReceiptAlignment.left
      );
      receiptText.addText(_journals[index]['qt'], alignment: ReceiptAlignment.center);
      receiptText.addText(_journals[index]['name'],alignment: ReceiptAlignment.right);

     // receiptText.addLeftRightText( _journals[index]['netprice'], _journals[index]['qt']+"       "+_journals[index]['name']);
    }
    receiptText.addSpacer(useDashed: true);

    receiptText.addSpacer(count: 2);

    receiptText.addLeftRightText(Globalvireables.Total, 'المجموع');
    receiptText.addSpacer(useDashed: true);

    receiptText.addSpacer(count: 2);

    await _bluePrintPos.printReceiptText(receiptText);

    /// Example for print QR
   // await _bluePrintPos.printQR('https://www.google.com/', size: 250);

    /// Text after QR
    final ReceiptSectionText receiptSecondText = ReceiptSectionText();
    receiptSecondText.addText(
        'Powered by Galaxy Group',
         size: ReceiptTextSizeType.small
    );
    receiptSecondText.addSpacer();
    await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
  }
*/
  @override
  Widget build(BuildContext context) {
    c=context;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Align(alignment:Alignment.centerRight,child: Text(widget.title)),
        ),
        body: SafeArea(
          child: _isLoading && _blueDevices.isEmpty
              ? const Center(
            child: CircularProgressIndicator(
            ),
          )
              : _blueDevices.isNotEmpty
              ? SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: List<Widget>.generate(_blueDevices.length,
                          (int index) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: _blueDevices[index].address ==
                                    (_selectedDevice?.address ?? '')
                                    ? _onDisconnectDevice
                                    : () => _onSelectDevice(index,context),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _blueDevices[index].name,
                                        style: TextStyle(
                                          color: _selectedDevice?.address ==
                                              _blueDevices[index]
                                                  .address
                                              ? Colors.blue
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _blueDevices[index].address,
                                        style: TextStyle(
                                          color: _selectedDevice?.address ==
                                              _blueDevices[index].address
                                              ? Colors.blueGrey
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (_loadingAtIndex == index && _isLoading)
                              Container(
                                height: 24.0,
                                width: 24.0,
                                margin: const EdgeInsets.only(right: 8.0),
                                child: const CircularProgressIndicator(

                                ),
                              ),
                            if (!_isLoading &&
                                _blueDevices[index].address ==
                                    (_selectedDevice?.address ?? ''))
                              TextButton(
                                onPressed: _onPrintReceipt,
                                child: Container(
                                  color: _selectedDevice == null
                                      ? Colors.grey
                                      : Colors.blue,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'طباعه',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                style: ButtonStyle(

                                ),

                              ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'البحث عن الاجهزه القريبه',
                  style: TextStyle(fontSize: 24, color: Colors.blueAccent),
                ),
                Text(
                  'Press button scan',
                  style: TextStyle(fontSize: 14, color: Colors.indigo),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isLoading ? null : _onScanPressed,
          child: const Icon(Icons.search),
          backgroundColor: _isLoading ? Colors.grey : Colors.indigo,
        ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }

  void _refreshItems(BuildContext co) async {
      c=co;
      final handler = DatabaseHandler();
      Globalvireables.journals = await handler.retrievesalDetails();
      setState(() {
        _journals = Globalvireables.journals;
      });


  }


  Future<void> _onPrintReceipt() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    bytes +=
        generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes +=
        generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print image:
    final ByteData data = await rootBundle.load('assets/logo.png');
    final Uint8List imgBytes = data.buffer.asUint8List();
     //Image image = decodeImage(imgBytes)!;
   // bytes += generator.image(image);
    // Print image using an alternative (obsolette) command
    // bytes += generator.imageRaster(image);

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
    // ticket.text(
    //   'hello ! 中文字 # world @ éphémère &',
    //   styles: PosStyles(codeTable: PosCodeTable.westEur),
    //   containsChinese: true,
    // );

    bytes += generator.feed(2);
    bytes += generator.cut();




  }




}