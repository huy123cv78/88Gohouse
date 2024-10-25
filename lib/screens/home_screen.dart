import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final List<String> imagePaths = [
  'images/img-home-bn.png',
  'images/img-home-bn.png',
  'images/img-home-bn.png'
];
late List<Widget> _pages;

int _activePage = 0;

final PageController _pageController = PageController(initialPage: 0);

Timer? _timer;

class _MyAppState extends State<HomeScreen> {
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
        imagePaths.length,
        (index) => ImagesPlacholder(
              imagePath: imagePaths[index],
            ));
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
        body: Column(
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
                // các nút điều hướng của slide dow
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
                // Nút "Previous"
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
            // Các thành phần khác của body
          ],
        ),
      ),
    );
  }
}

class ImagesPlacholder extends StatelessWidget {
  final String? imagePath;
  const ImagesPlacholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}
