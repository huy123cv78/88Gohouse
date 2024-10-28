import 'dart:async';
import 'package:flutter/material.dart';

class FeaturedSlideShow extends StatefulWidget {
  const FeaturedSlideShow({Key? key}) : super(key: key);

  @override
  State<FeaturedSlideShow> createState() => _FeaturedSlideShowState();
}

class _FeaturedSlideShowState extends State<FeaturedSlideShow> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> slideData = [
    {
      'imagePath': 'images/video_demo1.png',
      'title': '標題 1',
      'viewCount': '168046',
    },
    {
      'imagePath': 'images/video_demo2.png',
      'title': '標題 2',
      'viewCount': '168046',
    },
    {
      'imagePath': 'images/video_demo1.png',
      'title': '標題 1',
      'viewCount': '168046',
    },
    {
      'imagePath': 'images/video_demo2.png',
      'title': '標題 2',
      'viewCount': '168046',
    },
    // Thêm dữ liệu cho các slide khác ở đây
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < (slideData.length / 2).floor() - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320, // Điều chỉnh chiều cao slideshow
          child: PageView.builder(
            controller: _pageController,
            itemCount: (slideData.length / 2).ceil(), // Số lượng trang
            itemBuilder: (context, index) {
              final firstIndex = index * 2;
              final secondIndex = index * 2 + 1;
              return Stack(
                // Sử dụng Stack để đặt nút tim lên ảnh
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          // Stack cho slide đầu tiên
                          children: [
                            _buildSlideItem(slideData[firstIndex]),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: _buildHeartButton(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16), // Khoảng cách giữa hai slide
                      // Slide thứ hai trong cặp (nếu có)
                      if (secondIndex < slideData.length)
                        Expanded(
                          child: Stack(
                            // Stack cho slide thứ hai
                            children: [
                              _buildSlideItem(slideData[secondIndex]),
                              Positioned(
                                top: 16,
                                right: 16,
                                child: _buildHeartButton(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Positioned(
                    // Định vị nút tim
                    top: 16, // Khoảng cách từ nút tim đến cạnh trên
                    right: 16, // Khoảng cách từ nút tim đến cạnh phải
                    child: _buildHeartButton(),
                  ),
                ],
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 24), // khoảng cách giữa chấm và hình
        _buildDotsIndicator(),
      ],
    );
  }

  Widget _buildSlideItem(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30), // Giảm padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                data['imagePath'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data['title'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14.0),
              children: <TextSpan>[
                const TextSpan(
                    text: '查看數 ', style: TextStyle(color: Colors.grey)),
                TextSpan(
                    text: '${data['viewCount']}',
                    style: const TextStyle(color: Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (slideData.length / 2).ceil(), // Số lượng chấm
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.orange : Colors.grey,
          ),
        ),
      ),
    );
  }
}

Widget _buildHeartButton() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      shape: BoxShape.circle,
    ),
    child: IconButton(
      icon: const Icon(Icons.favorite, color: Colors.grey),
      onPressed: () {
        // Xử lý khi nút tim được nhấn
      },
    ),
  );
}
