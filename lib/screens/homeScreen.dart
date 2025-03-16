import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/tarot_card.dart';
import 'package:horoscope/widgets/custom_appbar.dart';
import 'package:horoscope/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  bool _showBottomNav = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animasyon süresi
    );
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      double appBarHeight = MediaQuery.of(context).size.height - kToolbarHeight;
      bool shouldShowBottomNav = offset >= appBarHeight - kToolbarHeight;

      if (shouldShowBottomNav != _showBottomNav) {
        setState(() {
          _showBottomNav = shouldShowBottomNav;
        });

        if (shouldShowBottomNav) {
          _animationController.forward(); // NavBar'ı yavaşça aç
        } else {
          _animationController.reverse(); // NavBar'ı yavaşça kapat
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double percent =
                    (constraints.maxHeight - kToolbarHeight) /
                    (MediaQuery.of(context).size.height - kToolbarHeight);
                double opacity = percent.clamp(0.0, 1.0);
                return CustomAppBar(opacity: opacity);
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TarotCard(
                  title: "The Magician",
                  subtitle: "Your potential is limitless today.",
                  imagePath: "assets/images/daily.png",
                  onTap: () {
                    debugPrint("The Magician kartına tıklandı!");
                    // Burada başka bir sayfaya yönlendirme yapabilirsin
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TarotCard(
                  title: "The High Priestess",
                  subtitle: "Trust your intuition.",
                  imagePath: "assets/images/weekly.png",
                  onTap: () {
                    debugPrint("The High Priestess kartına tıklandı!");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TarotCard(
                  title: "The Fool",
                  subtitle: "Embrace new beginnings.",
                  imagePath: "assets/images/monthly.png",
                  onTap: () {
                    debugPrint("The Fool kartına tıklandı!");
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child:
            _showBottomNav
                ? BottomNavBar(animationController: _animationController)
                : const SizedBox.shrink(),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
