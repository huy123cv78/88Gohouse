import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0; // Chỉ số của item được chọn

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 90, // Tăng chiều cao của thanh điều hướng
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: '首頁',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.favorite,
                label: '收藏',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.search,
                label: '搜尋',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: '會員',
                index: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isSelected
                ? Matrix4.translationValues(0, -20, 0)
                : Matrix4.translationValues(0, 0, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected)
                  Container(
                    width: 60, // Tăng kích thước khung màu cam
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, // Thêm viền trắng
                        width: 7, // Độ dày của viền
                      ),
                    ),
                  ),
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isSelected
                ? Matrix4.translationValues(0, -20, 0)
                : Matrix4.translationValues(0, 0, 0),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
