import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  Timer? _timer;

  final List<String> imagePaths = [
    'images/img-home-bn.png',
    'images/img-home-bn.png',
    'images/img-home-bn.png',
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
      imagePaths.length,
      (index) => ImagePlaceholder(
        imagePath: imagePaths[index],
      ),
    );
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var child;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          flexibleSpace: Center(
            child: Image.asset(
              'images/logo-icon.png',
              height: 40,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                // Xử lý khi nhấn vào icon thông báo
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          // Sử dụng SingleChildScrollView
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: imagePaths.length,
                      onPageChanged: (value) {
                        setState(() {
                          _activePage = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return _pages[index];
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          _pages.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: Container(
                                width: _activePage == index ? 60 : 60,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: _activePage == index
                                      ? Colors.orange
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 8,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 2.0)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ),
                  // Nút "Next"
                  Positioned(
                    top: MediaQuery.of(context).size.height / 8,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 2.0)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // GridView
              GridView.count(
                crossAxisCount: 4, // 4 cột
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true, // Giới hạn chiều cao của GridView
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildGridItem(
                    imagePath: 'images/button1.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/button2.png',
                    label: '購屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/buy')
                      Navigator.pushNamed(context, '/buy');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/button3.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/button4.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/button5.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/button6.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/button7.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  _buildGridItem(
                    imagePath: 'images/logo-icon.png',
                    label: '租屋',
                    onTap: () {
                      // Chuyển đến màn hình tương ứng (ví dụ: '/rent')
                      Navigator.pushNamed(context, '/rent');
                    },
                  ),
                  // Thêm các nút khác tương tự
                ],
              ),
              // hai hình baner
              const SizedBox(height: 16),
              SizedBox(
                width: 358,
                height:
                    256, // Điều chỉnh kích thước theo nhu cầu (tổng chiều cao của 2 ảnh)
                child: Column(
                  children: [
                    Image.asset(
                      'images/hinh_duoibt1.png',
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      'images/hinh_duoibt2.png',
                    ),
                  ],
                ),
              )
              // Các thành phần khác của body
            ],
          ),
        ),
      ),
    );
  }

// các nút button phần header
  Widget _buildGridItem({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8), // Thêm padding nếu cần
        decoration: BoxDecoration(
          color:
              Color.fromRGBO(255, 254, 254, 1), // Màu background các nut button
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: 25,
              imagePath,
              fit: BoxFit.contain,
            ), // Điều chỉnh kích thước hình ảnh
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String imagePath;
  const ImagePlaceholder({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}
