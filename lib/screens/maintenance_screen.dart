import 'package:flutter/material.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        // Chiều cao mặc định của AppBar
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: AppBar(
            title: const Text('維護更新'),
            centerTitle: true,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Khoảng cách 40px từ AppBar
            Image.asset(
                'images/logo_Maintenance.png'), // Thay bằng đường dẫn đến logo của bạn
            SizedBox(height: 40), // Khoảng cách 40px từ logo
            Container(
              padding: EdgeInsets.all(20), // Padding cho khung
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey), // Viền khung màu xám
                  ),
              child: Column(
                children: [
                  Text(
                    'System\nMaintenance',
                    textAlign: TextAlign.center, // Căn giữa dòng text
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '本網站將於 2023/11/29 00:00~01:00 進行系統維護作業',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, // Thay đổi kích thước chữ ở đây
                      color: const Color.fromARGB(
                          255, 96, 95, 95), // Thay đổi màu chữ ở đây
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '為您帶來不便，敬請見諒！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, // Thay đổi kích thước chữ ở đây
                      color: const Color.fromARGB(
                          255, 96, 95, 95), // Thay đổi màu chữ ở đây
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Khoảng cách 40px từ khung
            Image.asset(
                'images/img-system-maintenance.png'), // Thay bằng đường dẫn đến hình ảnh của bạn
          ],
        ),
      ),
    );
  }
}
