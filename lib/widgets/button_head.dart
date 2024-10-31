import 'package:flutter/material.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController scrollController;

  const BackToTopButton({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showButton = widget.scrollController.offset > 200;
    });
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom:
          80, // Cách bottomNavigationBar 16px (giả sử bottomNavigationBar cao 64px)
      right: 16,
      child: _showButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.orange,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_up),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 8,
                    endIndent: 8,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
