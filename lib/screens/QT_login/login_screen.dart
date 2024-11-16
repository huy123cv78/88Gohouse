import 'dart:convert';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/QT_login/choose_identity.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  List _countryCodes = []; // Danh sách mã quốc gia
  String _selectedPhoneCode = '+84_VN'; // Mã quốc gia mặc định
  final _phoneController =
      TextEditingController(); // Controller cho ô nhập số điện thoại
  bool _isPhoneValid = true; // Trạng thái hợp lệ của số điện thoại

  @override
  void initState() {
    super.initState();
    _loadCountryCodes(); // Gọi hàm đọc dữ liệu khi khởi tạo widget
  }

  Future<void> _loadCountryCodes() async {
    final String response =
        await rootBundle.loadString('assets/countryCode.json');
    final List<dynamic> data = json.decode(response);

    final uniqueCountryCodes =
        data.toSet().toList(); // Loại bỏ mã quốc gia trùng lặp

    setState(() {
      _countryCodes = uniqueCountryCodes;
    });
  }

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
              Navigator.pop(context); // Quay lại trang trước
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
          actions: [
            IconButton(
              icon: const Icon(Icons.language), // Icon quả địa cầu
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            height: 25, // Điều chỉnh chiều cao
                            width: 35, // Điều chỉnh chiều rộng
                            child: CountryFlag.fromCountryCode(
                              'US',
                            ),
                          ),
                          title: const Text('English'),
                          onTap: () async {
                            await context.setLocale(const Locale('en', 'US'));
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: SizedBox(
                            height: 25, // Điều chỉnh chiều cao
                            width: 35, // Điều chỉnh chiều rộng
                            child: CountryFlag.fromCountryCode(
                              'VN',
                            ),
                          ),
                          title: const Text('Tiếng Việt'),
                          onTap: () async {
                            await context.setLocale(const Locale('vi', 'VI'));
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: SizedBox(
                            height: 25, // Điều chỉnh chiều cao
                            width: 35, // Điều chỉnh chiều rộng
                            child: CountryFlag.fromCountryCode(
                              'CN',
                            ),
                          ),
                          title: const Text('中文'),
                          onTap: () async {
                            await context.setLocale(const Locale('zh', 'ZH'));
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
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

              // Hình ảnh đăng nhập
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
              Padding(
                padding: const EdgeInsets.only(left: 1), // Thêm padding left
                child: const Align(
                  alignment: Alignment.centerLeft, // Căn lề trái
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Khung nhập số điện thoại với tiêu đề 手機號碼 *
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'login.phoneNumber'.tr(), //phoneNumber
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
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
                                        title: Text(phoneCode),
                                        onTap: () {
                                          setState(() {
                                            _selectedPhoneCode =
                                                '$phoneCode$countryCode';
                                          });
                                          Navigator.pop(
                                              context); // Đóng danh sách sau khi chọn
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
                              Text(_selectedPhoneCode.split(
                                  '_')[0]), // Hiển thị mã quốc gia đã chọn
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              8), // Thêm khoảng cách 8px giữa mã quốc gia và ô nhập số điện thoại
                      // Khung nhập số điện thoại
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _isPhoneValid
                                    ? Colors.grey
                                    : Colors
                                        .red), // Đổi màu khung khi không hợp lệ
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                              hintText: 'login.phonePlaceholder'
                                  .tr(), // này là phonePlaceholder
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

              // Khung mật khẩu với tiêu đề "密碼 *"
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'login.pwd'.tr(), //phoneNumber
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
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
                          vertical: 14,
                          horizontal: 12,
                        ),
                        border: InputBorder.none,
                        hintText: 'login.pwdplaceholder'
                            .tr(), // này là pwdplaceholder
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
                      Text('login.remember'.tr()), // đây là remember
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn "Quên mật khẩu"
                    },
                    child: Text(
                      'login.forget'.tr(), // đây là forget
                      style: TextStyle(
                        decoration: TextDecoration.underline, // Thêm gạch chân
                        color: Colors.grey, // Đổi màu chữ
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Nút đăng nhập
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(300, 50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  // Xử lý khi nhấn nút "Đăng nhập"
                },
                child: Text(
                  'login.login'.tr(), // đây là login
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
                  Text('login.noAccount'.tr()), // đây là noAccount
                  TextButton(
                    onPressed: () {
                      // Điều hướng đến trang ChooseIdentityPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseIdentityPage(),
                        ),
                      );
                    },
                    child: Text(
                      'login.register'.tr(), // đây là register
                      style: TextStyle(
                        decoration: TextDecoration.underline, // Thêm gạch chân
                        color: Colors.grey,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.zero, // Bỏ padding mặc định của TextButton
                      minimumSize:
                          Size.zero, // Bỏ minimumSize mặc định của TextButton
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Giảm kích thước tap target
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),

              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'login.accountLogin'.tr(),
                    ), // đây là accountLogin
                    const SizedBox(width: 8),
                    IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.g_mobiledata, color: Colors.grey),
                      onPressed: () {
                        // Xử lý khi nhấn nút Google
                      },
                      style: IconButton.styleFrom(
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                        shape: const CircleBorder(),
                      ),
                    ),
                    const SizedBox(width: 2),
                    IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.facebook, color: Colors.grey),
                      onPressed: () {
                        // Xử lý khi nhấn nút Facebook
                      },
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
