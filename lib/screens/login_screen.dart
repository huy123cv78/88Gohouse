import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16.0),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            '會員登入',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 78, 78, 78),
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
          shadowColor: Colors.grey,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // Hình ảnh login
              Container(
                width: 400,
                height: 270,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 2.0,
                  ),
                ),
                child: Image.asset(
                  'images/img-login.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Tiêu đề "Welcome"
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Số điện thoại với tiêu đề 手機號碼 *
              // Số điện thoại với tiêu đề 手機號碼 *
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '手機號碼 *',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Khung chứa mã quốc gia
                      Container(
                        height: 48, // Đặt chiều cao cố định
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: '+84', // Đặt mã quốc gia mặc định
                          items: <String>['+84', '+1', '+44', '+61']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              // Cập nhật mã quốc gia mới nếu cần
                            });
                          },
                          underline: Container(),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Khung nhập số điện thoại
                      Expanded(
                        child: Container(
                          height: 48, // Đặt chiều cao cố định
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                              hintText: '手機號碼',
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

// Khung mật khẩu với tiêu đề "密碼 *"
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '密碼 *',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 48, // Đặt chiều cao cố định
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical:
                              14, // Căn giữa nội dung theo chiều cao của khung
                          horizontal: 12,
                        ),
                        border: InputBorder.none,
                        hintText: '密碼8至12位包含英數字(不含大寫)',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Ghi nhớ tôi & Quên mật khẩu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          // Xử lý khi checkbox thay đổi
                        },
                      ),
                      const Text('記住我'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn "Quên mật khẩu"
                    },
                    child: const Text('忘記密碼'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Nút đăng nhập
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize:
                      const Size(300, 50), // Chiều rộng và chiều cao của nút
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32), // Căn chỉnh padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6), // Bo góc nút đăng nhập
                  ),
                ),
                onPressed: () {
                  // Xử lý khi nhấn nút "Đăng nhập"
                },
                child: const Text(
                  '登入',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Liên kết đến màn hình đăng ký
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('還沒有帳號嗎？'),
                  // Giảm khoảng cách giữa "還沒有帳號嗎？" và "Đăng ký"
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn "Đăng ký"
                    },
                    child: const Text('Đăng ký'),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey, // Màu của đường thẳng
                thickness: 0.5, // Độ dày của đường thẳng
                indent: 16, // Khoảng cách từ bên trái
                endIndent: 16, // Khoảng cách từ bên phải
              ),

              const SizedBox(height: 1), // Giảm khoảng cách với đường thẳng
              // Đăng nhập bằng mạng xã hội
              Padding(
                padding: const EdgeInsets.only(left: 16), // Căn lề trái 16px
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('以社群帳號登入'),
                    const SizedBox(
                        width: 8), // Giảm khoảng cách giữa văn bản và nút

                    // Nút Google với viền
                    IconButton(
                      iconSize: 20, // Kích thước của icon
                      icon: const Icon(Icons.g_mobiledata, color: Colors.grey),
                      onPressed: () {
                        // Xử lý khi nhấn nút Google
                      },
                      // Áp dụng viền cho icon
                      style: IconButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.grey,
                            width: 0.5), // Màu và độ dày của viền
                        shape: const CircleBorder(),
                      ),
                    ),

                    const SizedBox(width: 2), // Khoảng cách giữa các nút

                    // Nút Facebook với viền
                    IconButton(
                      iconSize: 20, // Kích thước của icon
                      icon: const Icon(Icons.facebook, color: Colors.grey),
                      onPressed: () {
                        // Xử lý khi nhấn nút Facebook
                      },
                      // Áp dụng viền cho icon
                      style: IconButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.grey,
                            width: 0.5), // Màu và độ dày của viền
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
