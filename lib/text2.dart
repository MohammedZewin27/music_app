import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPage extends StatefulWidget {
  static const String routeName = 'Layout';
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String copiedText = ''; // المتغير لحفظ النص المنسوخ

  void _onTextCopied(String text) {
    setState(() {
      copiedText = text; // تحديث قيمة المتغير عند نسخ النص
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحتي'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('النص المنسوخ: $copiedText'), // عرض النص المنسوخ في واجهة المستخدم
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Clipboard.getData('text/plain').then((value) {
                if (value != null && value.text != null) {
                  _onTextCopied(value.text!); // استدعاء الدالة عند نسخ النص
                }
              });
            },
            child: Text('لصق النص'),
          ),
        ],
      ),
    );
  }
}
