import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _sliderController =
      PageController(initialPage: 0); // Controller cho PageView thứ hai
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
    _pageController.dispose();
    _sliderController.dispose(); // Giải phóng bộ nhớ cho sliderController
    _timer?.cancel();
    super.dispose();
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
          child: Column(children: [
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
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),
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
            GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildGridItem(
                  imagePath: 'images/button1.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/button2.png',
                  label: '購屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/buy');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/button3.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/button4.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/button5.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/button6.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/button7.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
                _buildGridItem(
                  imagePath: 'images/logo-icon.png',
                  label: '租屋',
                  onTap: () {
                    Navigator.pushNamed(context, '/rent');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 358,
              height: 256,
              child: Column(
                children: [
                  Image.asset('images/hinh_duoibt1.png'),
                  const SizedBox(height: 16),
                  Image.asset('images/hinh_duoibt2.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '精選影音',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '查看更多',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 173, 169, 169),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 416,
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _sliderController,
                      onPageChanged: (index) {
                        setState(() {
                          _activePage = index;
                        });
                      },
                      children: [
                        // slide 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo1.png',
                                title: '標題 1',
                                viewCount: '168046',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo2.png',
                                title: '標題 2',
                                viewCount: '168046',
                              ),
                            ),
                          ],
                        ),
                        // slide 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo1.png',
                                title: '標題 1',
                                viewCount: '168046',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo2.png',
                                title: '標題 2',
                                viewCount: '168046',
                              ),
                            ),
                          ],
                        ),
                        // slide 3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo1.png',
                                title: '標題 1',
                                viewCount: '168046',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo2.png',
                                title: '標題 2',
                                viewCount: '168046',
                              ),
                            ),
                          ],
                        ),
                        // slide 4
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo1.png',
                                title: '標題 1',
                                viewCount: '168046',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo2.png',
                                title: '標題 2',
                                viewCount: '168046',
                              ),
                            ),
                          ],
                        ),
                        // slide 5
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo1.png',
                                title: '標題 1',
                                viewCount: '168046',
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildSlideItem2(
                                imagePath: 'images/video_demo2.png',
                                title: '標題 2',
                                viewCount: '168046',
                              ),
                            ),
                          ],
                        ),
                        // Bạn có thể thêm thêm các trang khác ở đây nếu cần
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _sliderController,
                    count: 5, // Tổng số trang
                    effect: WormEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 8,
                      dotColor:
                          Colors.grey, // Màu của các dấu chấm không hoạt động
                      activeDotColor:
                          Colors.orange, // Màu của dấu chấm đang hoạt động
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

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

Widget _buildSlideItem2({
  required String imagePath,
  required String title,
  required String viewCount,
}) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Căn lề trái cho nội dung của Column
    children: [
      Image.asset(imagePath),
      const SizedBox(height: 16),
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: [
            const TextSpan(
              text: '查看數 ',
            ),
            TextSpan(
              text: viewCount,
              style: const TextStyle(
                  color: Colors.orange), // Màu xám cho viewCount
            ),
          ],
        ),
      ),
    ],
  );
}

class slidershow extends StatelessWidget {
  final String imagePath;
  const slidershow({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}
