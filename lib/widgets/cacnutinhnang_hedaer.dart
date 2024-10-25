import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Column,
        EdgeInsets,
        GestureDetector,
        GridView,
        Image,
        Key,
        MainAxisAlignment,
        Navigator,
        Scaffold,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        VoidCallback,
        Widget;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView Example"),
      ),
      body: GridView.count(
        crossAxisCount: 4, // 4 cột
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildGridItem(
            imagePath: 'images/button1.png', // Thay bằng đường dẫn ảnh của bạn
            label: '租屋',
            onTap: () {
              // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
              Navigator.pushNamed(context, '/rent');
            },
          ),
          _buildGridItem(
            imagePath: 'images/button2.png', // Thay bằng đường dẫn ảnh của bạn
            label: '購屋',
            onTap: () {
              // Chuyển đến màn hình tương ứng (ví dụ: '/buy')
              Navigator.pushNamed(context, '/buy');
            },
          ),
          // Thêm các nút khác tương tự
        ],
      ),
    );
  }

  Widget _buildGridItem({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 50), // Điều chỉnh kích thước hình ảnh
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
