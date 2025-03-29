import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final double itemExtent;
  final List<Widget> children;

  const CarouselWidget({
    super.key,
    required this.itemExtent,
    required this.children,
  });

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.itemExtent,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 2.0, // 🔥 Kartlar arasında boşluk bırakır
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: widget.children[index],
                ),
              );
            },
          ),
        ),

        // 📌 **Sayfa İndikatörü**
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.children.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              width: _currentPage == index ? 12 : 8, // Aktif noktayı büyüt
              height: _currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
