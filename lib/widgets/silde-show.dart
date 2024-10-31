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
          height: 350, // Điều chỉnh chiều cao slideshow
          child: PageView.builder(
            controller: _pageController,
            itemCount: (slideData.length / 2).ceil(), // Số lượng trang
            itemBuilder: (context, index) {
              final firstIndex = index * 2;
              final secondIndex = index * 2 + 1;
              return Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
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
                      if (secondIndex < slideData.length)
                        Expanded(
                          child: Stack(
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
          SizedBox(
              width: 580,
              height: 280,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  data['imagePath'],
                  fit: BoxFit.cover,
                  width: 500, // Điều chỉnh chiều rộng
                  height: 500, // Điều chỉnh chiều cao
                ),
              )),
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

// silde2
class NewsSlideShow extends StatefulWidget {
  const NewsSlideShow({Key? key}) : super(key: key);

  @override
  State<NewsSlideShow> createState() => _NewsSlideShowState();
}

class _NewsSlideShowState extends State<NewsSlideShow> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> newsData = [
    {
      'imagePath': 'images/hinhslide_1.png',
      'logoPath': 'images/logoslide1.png',
      'title': 'Dự báo xu hướng của thị trường bất động sản 2023',
    },
    {
      'imagePath': 'images/hinhslide_1.png',
      'logoPath': 'images/logoslide1.png',
      'title': 'Dự báo xu hướng của thị trường bất động sản 2023',
    },
    // Thêm dữ liệu cho các slide tin tức khác ở đây
  ];

  @override
  void initState() {
    super.initState();
    // Tự động chuyển slide sau mỗi 3 giây
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < newsData.length - 1) {
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
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, top: 16, bottom: 16), // Thêm padding left: 16
            child: Text(
              '媒體新聞',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300, // Điều chỉnh chiều cao slideshow
          child: PageView.builder(
            controller: _pageController,
            itemCount: newsData.length,
            itemBuilder: (context, index) {
              return _buildNewsItem(newsData[index]);
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        _buildDotsIndicator(),
      ],
    );
  }

  Widget _buildNewsItem(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ), // Chỉ bo góc trên
              child: Image.asset(
                data['imagePath'],
                fit: BoxFit.cover,
                width: double.infinity, // Hình ảnh tràn viền
                height: double.infinity, // Hình ảnh tràn viền
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ), // Chỉ bo góc dưới
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    data['logoPath'],
                    height: 80,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      data['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
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
        newsData.length,
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

//cái cuối
class PartnerSlideShow extends StatefulWidget {
  const PartnerSlideShow({Key? key}) : super(key: key);

  @override
  State<PartnerSlideShow> createState() => _PartnerSlideShowState();
}

class _PartnerSlideShowState extends State<PartnerSlideShow> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8, // Mỗi slide chiếm 80% chiều rộng màn hình
  );
  int _currentPage = 0;
  Timer? _timer;
  final List<String> imagePaths = [
    'images/hinhduoicung.png',
    'images/hinhduoicung.png',
    'images/hinhduoicung.png',
    // Thêm đường dẫn đến các hình ảnh khác ở đây
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
      if (_currentPage < imagePaths.length - 1) {
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
        const Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
          child: Align(
            // Sử dụng Align widget
            alignment: Alignment.centerLeft,
            child: Text(
              '合作夥伴',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildPartnerImage(imagePaths[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPartnerImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
