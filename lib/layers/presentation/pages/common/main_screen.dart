// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:geolog/layers/presentation/pages/common/home_screen.dart';
import 'package:geolog/layers/presentation/pages/common/location_screen.dart';
import 'package:geolog/layers/presentation/pages/common/profile_screen.dart';
import 'package:geolog/layers/presentation/pages/common/scanner_screen.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  int selectIndex = 0;
  MainPage({
    super.key,
    required this.selectIndex,
  });

  @override
  State<MainPage> createState() => _mainSreenCompanyState();
}

class _mainSreenCompanyState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  late PageController _pageController;
  late List<Widget> _screens;
  late int _index;

  @override
  void initState() {
    super.initState();

    _index = 0;
    _screens = [
      const HomeScreen(),
      const LocationScreen(),
      const ScannerScreen(),
      const ProfileScreen()
    ];
    _pageController = PageController(initialPage: _index);
  }

  void _onTap(int index) {
    setState(() {
      _index = index;
      _pageController.jumpToPage(_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              unselectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
              onTap: _onTap,
              currentIndex: widget.selectIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              selectedLabelStyle: const TextStyle(color: Colors.white),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/image/home.svg',
                    colorFilter: ColorFilter.mode(
                        widget.selectIndex == 0 ? Colors.white : Colors.white,
                        BlendMode.srcIn),
                  ),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: SvgPicture.asset(
                      'assets/image/location.svg',
                      colorFilter: ColorFilter.mode(
                          widget.selectIndex == 1 ? Colors.white : Colors.white,
                          BlendMode.srcIn),
                    ),
                  ),
                  label: 'Профиль',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: SvgPicture.asset(
                      'assets/image/scan.svg',
                      colorFilter: ColorFilter.mode(
                          widget.selectIndex == 2 ? Colors.white : Colors.white,
                          BlendMode.srcIn),
                    ),
                  ),
                  label: 'Сканнер',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/image/profile.svg',
                    colorFilter: ColorFilter.mode(
                        widget.selectIndex == 3 ? Colors.white : Colors.white,
                        BlendMode.srcIn),
                  ),
                  label: 'Профиль',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
