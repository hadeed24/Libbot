import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:http/http.dart' as http;

//credentials
const _credentials = r'''

{
  "type": "service_account",
  "project_id": "libbotapp",
  "private_key_id": "0eeadc3bbcd2704c7ed38fae698f7082e3aaaa2e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCnaC4xw6DZ2CyA\nB7LWTfo8r7tG0qWeEU7lRxq59vyfwtnSP2l4i1dtTWhgYiXRnOhvepJKG8FT2hJT\nc0SKwPBmPdrsIXw7nfz8gxGumdWSfMn8fFykCRTn/tAv0h+IlaMjr6+zDyzjU0rC\nB6MdxvT2BuPrdS7tvVJ1MihEjvgKF79dcea2CX3Dr/CJobrx0WiVvIOxe609JxQV\nyP+a7CRRFDKCN0YrHGuQcJt12gynNYlzQYj88WUPOouUshXNdd6BVGWauDbnLJUk\nL5/99y3/5XT/JEIcufMxzs4pMzlVC2PcAid49h2l4U1rW0DP5v5cVVC6s21chO27\nsPFdXbLjAgMBAAECggEANbRp0WQpd4luqToPCMomQ466vTs5j26NCWfYrp0KKTSI\nzXazXs0Q5ItHN1h1OnwkYxMG2Eh0KnLUmzno3LyNwrcIQuVxJe0Gqnlf1EwcpGxt\nHhdFXwhc0RpBbn3xyM78cafcbUyqgVkIrBtoHFbl4gGO38wNnI42ZEuNeIUHFLFJ\nx9ZUaZ2tDTD+umV3Zn8V0lQHF7J+CLhSdCa3Pcheu29wfbx7/fMJqIBGHBECMDAH\n1RaefMjwA7KUaBuIQ4zG879y22zF32+CEfVcVVZPYtAw9CBQAdP33HWhFXNrrn8j\n1mKCu6HMq33QXR9J5fSgZzIPzwj50Qi1NOLJ8FhodQKBgQDR37uWROtscbo85fX4\nJzXJiofliMLKdasAr3YNuAaDpbuRPwGK3hNtkMy1chp9oytEvVadLkmxdFT8C9FI\n8Js/pn65Wv6RbPDRh2r4yL/SjcgjoSdW8n59QrobygF69ADvp/VWSjwkk5P/J6Ep\nMnkMpzYM/KeNl9iRlcQU0qdT7QKBgQDMMxnJBJ6lpBNzBvv8mtWgCYVdn0HV7LJ1\nf4bdpK5UMtkGBN+vbHxvILrl608er/K4IMb2szkNWs5HRCfvgmCxg8BNXeu2KymG\nJBDOW7dCl61omHkzPyz+Mw4UFFD31XRJNvZIk0DbpNyiZbP0hRz3tNxbIC8EQRu+\n3CrjuWXoDwKBgCDnhf6aUZrP/dX8a+L7Ksitan8HQRsC9cuGtuiRuJu9SToNec1u\n4fbko+OyvwqBoZAGa2T7U9x5k7VsmORprL1++hFPfegI/3yqUZAt0T1Os1k6s/NC\n06gJ5SnkMvU2+kqYt7NOsj090g9IBFF0M1xTfvrsRczCSNcSdwqYuFlFAoGBAJLU\nG7JjVAAe3q1TVFXqr7kHn5IWNayxKhE6xasSAxggB9VAI+drxn3RtxIkBRw3v/uN\n9gLmFBv6M2EjLOQXh5ec+OWopxiyKIV/4WXApSGJFvOiz2N+BcgyxejCQwYxwg/z\nKVw+JeDJxqwvHRqxrIag0eHkXmpctqqifWSJpzEZAoGBAMI+tH0EzlD0tum6YhGX\nqGjg15ARQua31zSUk6dsnnTCzlL3hnwhfkkewISuDzSNaU3nLmgVx4wkmaZpKDeN\nb+dHe8ZQnoyAxegBFNsxsR5Ud6+WgC37CJSAhw5tpYj9WBlT7fdgIIGjMwOIR5N9\nGzFcJOlpJ2hZQ5YOWHZZHj17\n-----END PRIVATE KEY-----\n",
  "client_email": "libbot@libbotapp.iam.gserviceaccount.com",
  "client_id": "100456988919079654708",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/libbot%40libbotapp.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}


''';

const _spreadsheetid = '18R1iIEU8BoeWYREOvl879jcQriH8zHFLt9P6FbJ4Sks';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: BarcodeScannerScreen(),
    );
  }
}

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _barcode = '1';
  String Bname = '';
  String Aname = '';
  int book_count = 0;
  List<String> barcodes = [];
  String result = '';

  http.Client client = http.Client();

  Future<void> sendDataToServer() async {
    {
      final url = Uri.parse(
          'http://20.169.193.144:80/upload'); // Update with your Flask server URL

      // Convert barcodes to a JSON string
      String jsonString = jsonEncode({'barcode': barcodes});

      try {
        final response = await http.post(
          url,
          body: jsonString,
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          print('Data sent successfully!');
          print('Response from server: ${response.body}');
        } else {
          print('Failed to send data. Status code: ${response.statusCode}');
          print('FAILED Response from server: ${response.body}');
        }
      } catch (error) {
        print('Error sending data: $error');
      }
    }
  }

  void restart() {
    barcodes = [];
  }

  void startscanning() async {
    book_count = 0;
    String barcodeScanResult = '0';
    do {
      barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      print('Barcode scan result: $barcodeScanResult');

      if (barcodeScanResult != '-1') {
        setState(() {
          _barcode = barcodeScanResult;
          if (_barcode != null) {
            barcodes.add(_barcode);
            if (_barcode.length == 13) {
              book_count++;
            }

            print("Barcode added: $_barcode");
          } else {
            print('Invalid barcode: $barcodeScanResult');
          }
        });
      }
    } while (barcodeScanResult != '-1');
    await sendDataToServer();
    restart();
    print("WHILE IS WORKING");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libbot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: startscanning,
              child: Text('Scan Books'),
            ),
            SizedBox(height: 20.0),
            Text("Books added $book_count"),
          ],
        ),
      ),
    );
  }
}
