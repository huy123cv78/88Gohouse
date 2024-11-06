import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;
  List _countryCodes = []; // Danh sách mã quốc gia
  String _selectedPhoneCode = '+84_VN'; // Mã quốc gia mặc định
  final _phoneController =
      TextEditingController(); // Controller cho ô nhập số điện thoại
  bool _isPhoneValid = true;

  @override
  void initState() {
    super.initState();
    _loadCountryCodes(); // Gọi hàm đọc dữ liệu khi khởi tạo widget
  }

  Future<void> _loadCountryCodes() async {
    // Chỉ giữ lại 1 hàm _loadCountryCodes()
    final String response =
        await rootBundle.loadString('assets/countryCode.json');
    final List<dynamic> data = json.decode(response);

    // Loại bỏ mã quốc gia trùng lặp, giữ lại mã đầu tiên xuất hiện
    final uniqueCountryCodes =
        data.toSet().toList(); // Loại bỏ mã quốc gia trùng lặp

    setState(() {
      _countryCodes = uniqueCountryCodes;
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Canh giữa các widget con
            children: [
              const SizedBox(height: 20),
              const Text(
                'Join Us',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  text: '已經有帳號了嗎？',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                      text: '登入',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold, // In đậm
                        decoration: TextDecoration.underline, // Gạch chân
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // khung nhập điện thoại
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: '手機號碼',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Màu chữ
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red, // Màu của dấu *
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Dropdown mã quốc gia
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height:
                                      300, // Giới hạn chiều cao của danh sách
                                  child: ListView.builder(
                                    itemCount: _countryCodes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String phoneCode =
                                          _countryCodes[index]['phoneCode'];
                                      String countryCode =
                                          _countryCodes[index]['countryCode'];
                                      return ListTile(
                                        title: Text('$phoneCode $countryCode'),
                                        onTap: () {
                                          setState(() {
                                            _selectedPhoneCode =
                                                '$phoneCode$countryCode';
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(_selectedPhoneCode.split('_')[0]),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Khung nhập số điện thoại
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _isPhoneValid
                                  ? Colors.grey
                                  : Colors
                                      .red, // Đổi màu khung khi không hợp lệ
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                              hintText: '手機號碼',
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly // Chỉ cho phép nhập số
                            ],
                            onChanged: (value) {
                              setState(() {
                                _isPhoneValid = RegExp(r'^\d+$')
                                    .hasMatch(value); // Kiểm tra nếu chỉ có số
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Thêm thuộc tính này
                children: [
                  RichText(
                    text: const TextSpan(
                      text: '密碼',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Màu chữ
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red, // Màu của dấu *
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: '密碼8至12位包含英數字(不含大寫)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: const TextSpan(
                      text: '確認密碼',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Màu chữ
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red, // Màu của dấu *
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: '密碼8至12位包含英數字(不含大寫)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      '我已閱讀並了解會員條款與隱私權聲明與免責聲明等所載內容以及其意義,茲同意該等條款規定,並願遵守網站現金、嗣後規範的各種規則',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 123, 0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        // Thêm thuộc tính shape
                        borderRadius: BorderRadius.circular(
                            6), // Điều chỉnh độ bo góc ở đây
                      ),
                    ),
                    onPressed: _agreedToTerms
                        ? () {
                            // Xử lý khi nút "下一步" được nhấn
                          }
                        : null,
                    child: const Text(
                      '下一步',
                      style: TextStyle(
                        color: Colors.white, // Đổi màu chữ ở đây
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
