import 'package:flutter/material.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ], // Đặt IconButton vào actions
        centerTitle: true,
        title: const Text(
          '會員註冊',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 78, 78, 78),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
        shadowColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.check,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Verification Success',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                '感謝您註冊成為88go的會員,您的手機號碼已驗證成功!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(300, 51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                // Xử lý khi nhấn nút "前往首頁"
                // Ví dụ: Chuyển hướng đến màn hình Home
              },
              child: const Text(
                '前往首頁',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
