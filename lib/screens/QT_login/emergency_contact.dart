import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({Key? key}) : super(key: key);

  @override
  State<EmergencyContactPage> createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedRelationship = '秘書/助理';
  String _selectedPhoneCode = '+84/VND';
  List _countryCodes = [];
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    _loadCountryCodes();
  }

  Future<void> _loadCountryCodes() async {
    final String response =
        await rootBundle.loadString('assets/countryCode.json');
    final List<dynamic> data = json.decode(response);
    final uniqueCountryCodes = data.toSet().toList();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Emergency Contact',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                '如遇帳號問題/廣告會員惡意/網站活動等情況，591無法聯絡會員時，將通知緊急聯絡人',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            // Dropdown chọn mối quan hệ
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Thêm thuộc tính này
              children: [
                RichText(
                  text: const TextSpan(
                    text: '緊急聯絡人身份',
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
                DropdownButtonFormField<String>(
                  value: _selectedRelationship,
                  items: ['秘書/助理', '家人', '朋友']
                      .map((String relationship) => DropdownMenuItem<String>(
                            value: relationship,
                            child: Text(relationship),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRelationship = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 20),
                // Khung nhập tên liên hệ
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Thêm thuộc tính này
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: '緊急聯絡人',
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
                      controller: _contactNameController,
                      decoration: InputDecoration(
                        hintText: '姓名',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Dropdown chọn mã quốc gia và khung nhập số điện thoại
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Thêm thuộc tính này
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: '聯絡人電話',
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
                            Container(
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                                        height: 300,
                                        child: ListView.builder(
                                          itemCount: _countryCodes.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String phoneCode =
                                                _countryCodes[index]
                                                    ['phoneCode'];
                                            String countryCode =
                                                _countryCodes[index]
                                                    ['countryCode'];
                                            return ListTile(
                                              title: Text(
                                                  '$phoneCode $countryCode'),
                                              onTap: () {
                                                setState(() {
                                                  _selectedPhoneCode =
                                                      '$phoneCode/$countryCode';
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
                                    Text(_selectedPhoneCode.split('/')[0]),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12),
                                  border: OutlineInputBorder(),
                                  hintText: '手機號碼',
                                ),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '注意事項：\n'
                          '1.緊急聯絡人須為您或您的法定代理人之一，無法代替其他會員提供服務。\n'
                          '2.通知緊急聯絡人視為已通知會員，故聯絡資訊若有變動，應即時更新。 若緊急聯絡人有拒絕接聽、未協助通知會員或聯絡不上等， 致會員未收到通知之情形，與88go無涉，會員須自行負責。',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(-10,
                                  0), // Điều chỉnh giá trị này để căn trái hơn
                              child: Checkbox(
                                value: _agreedToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreedToTerms = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: '我已閱讀並了解',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: '會員條款與隱私權聲明',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey, // Màu xanh
                                          decoration: TextDecoration
                                              .underline, // Gạch chân
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '與',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: '免責聲明',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey, // Màu xanh
                                          decoration: TextDecoration
                                              .underline, // Gạch chân
                                        ),
                                      ),
                                      const TextSpan(
                                        text:
                                            '等所載內容以及其意義，茲同意該等條款規定，並願遵守網站現金、嗣後規範的各種規則',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: _agreedToTerms
                                ? () {
                                    // Xử lý khi nút "註冊" được nhấn
                                  }
                                : null,
                            child: const Text(
                              '註冊',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
