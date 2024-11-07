import 'package:flutter/material.dart';

class ChooseIdentityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding:
                const EdgeInsets.only(top: 12.0), // Thêm padding top cho icon
            child: IconButton(
              padding: const EdgeInsets.only(left: 16.0),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context); // Quay lại trang trước
              },
            ),
          ),
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 12.0), // Thêm padding top cho title
            child: Text(
              '會員註冊',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 78, 78, 78),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 4,
          shadowColor: Colors.grey,
        ),
      ),
      body: SingleChildScrollView(
        // Thêm SingleChildScrollView ở đây
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Choose Your Identity',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '您的註冊身份',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              IdentityCard(
                title: 'Buyer/Tenant',
                subtitle: '買家/房客',
                onPressed: () {
                  // Hành động khi bấm vào nút "选择" của thẻ Buyer/Tenant
                },
              ),
              IdentityCard(
                title: 'Owner/Agent',
                subtitle: '屋主/代理人',
                onPressed: () {
                  // Hành động khi bấm vào nút "选择" của thẻ Owner/Agent
                },
              ),
              IdentityCard(
                title: 'Real estate agent',
                subtitle: '經理人/房屋仲介',
                onPressed: () {
                  // Hành động khi bấm vào nút "选择" của thẻ Real estate agent
                },
              ),
              IdentityCard(
                title: 'Real estate agency',
                subtitle: '仲介公司',
                onPressed: () {
                  // Hành động khi bấm vào nút "选择" của thẻ Real estate agency
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IdentityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const IdentityCard({
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 220, // Điều chỉnh chiều cao của IdentityCard
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Màu của bóng
              spreadRadius: 1, // Độ lan tỏa của bóng
              blurRadius: 8, // Độ mờ của bóng
              offset: Offset(0, 4), // Độ dịch chuyển của bóng
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 295, // Đặt chiều rộng cụ thể cho nút để tránh tràn viền
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  minimumSize:
                      Size(0, 45), // Điều chỉnh chiều cao của nút tại đây
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Làm tròn góc của nút
                  ),
                ),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    '选择',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
