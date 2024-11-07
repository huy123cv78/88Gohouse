import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import package http

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeControllers = List.generate(4, (index) => TextEditingController());

  // Hàm gửi request lấy mã code từ API
  Future<void> _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      final code = _codeControllers.map((c) => c.text).join();
      final url =
          Uri.parse('YOUR_API_ENDPOINT'); // Thay thế bằng API endpoint thực tế
      final headers = {
        'Authorization':
            'Bearer YOUR_API_TOKEN', // Thay thế bằng API token thực tế
      };
      final response = await http.post(url, headers: headers, body: {
        'code': code,
      });

      if (response.statusCode == 200) {
        // Xác thực thành công
        // Chuyển hướng đến màn hình tiếp theo
      } else {
        // Xác thực thất bại
        // Hiển thị thông báo lỗi
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Center(
            // Sử dụng Center để căn giữa theo chiều dọc
            child: Column(
              // Căn giữa các phần tử con theo chiều dọc
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Verify Your Phone Number',
                  textAlign: TextAlign.center, // Căn giữa văn bản
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  '已發送4位驗證碼至 +84 912-611-516',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _codeControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ''; // Trả về empty string để hiển thị lỗi
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(300, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6), // Thay đổi độ bo góc ở đây
                    ),
                  ),
                  onPressed: _verifyCode, // Gọi hàm xác thực mã code
                  child: const Text(
                    '驗證',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('沒有收到驗證碼嗎?'),
                TextButton(
                  onPressed: () {
                    // Xử lý khi nhấn "重新發送驗證碼"
                  },
                  child: Text(
                    '重新發送驗證碼 (10s)',
                    style: TextStyle(
                      color: Colors.grey, // Đổi màu chữ thành màu xanh
                      decoration: TextDecoration.underline, // Thêm gạch chân
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
