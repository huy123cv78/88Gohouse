import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 55),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Zalo 與我們取得聯繫',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24, // Thêm kích thước font chữ
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.facebook,
              iconColor: Colors.blue, // Màu cho icon Facebook
              onTap: () {
                // Xử lý khi nhấn nút Facebook
              },
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: FontAwesomeIcons.instagram,
              iconColor: Colors.pink, // Màu cho icon Instagram
              onTap: () {
                // Xử lý khi nhấn nút Instagram
              },
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: Icons.message,
              iconColor: Colors.orange, // Màu cho icon Message
              onTap: () {
                // Xử lý khi nhấn nút Message
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // Thêm Container để tạo hiệu ứng đổ bóng
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 40, color: iconColor),
        ),
      ),
    );
  }
}
