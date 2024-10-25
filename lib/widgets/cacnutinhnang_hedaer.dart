import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Buttons'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CategoryButton(
            icon: Icons.home,
            label: "租屋",
            onTap: () {
              // Xử lý khi nhấn vào nút "租屋"
            },
          ),
          CategoryButton(
            icon: Icons.home,
            label: "購屋",
            onTap: () {
              // Xử lý khi nhấn vào nút "購屋"
            },
          ),
          // ... thêm các nút khác
        ],
      ),
    );
  }
}
