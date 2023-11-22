import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

import 'account/view.dart';
import 'home/view.dart';
import 'notifications/view.dart';
import 'orders/view.dart';


class HomeNavBar extends StatefulWidget {
  final int index;
  const HomeNavBar({super.key,this.index =0});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeView(),
    const OrdersView(),
    const NotificationsView(),
    const AccountView(),
  ];

  List<String> titles = [
    "الرئيسية",
    "طلباتي",
    "الإشعارات",
    "حسابي",
  ];

  List<String> icons = [
    "home",
    "orders",
    "notifications",
    "my_account",
  ];
  @override
  void initState() {
    super.initState();
    if(widget.index!=0){
      setState(() {
        currentIndex=widget.index;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          pages.length,
              (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/${icons[index]}.svg",
              color: currentIndex == index ? Colors.white : const Color(0xFFB9C9A8),
            ),
            label: titles[index],
          ),
        ),
        elevation: 0.0,
        backgroundColor: getMaterialColor(),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFB9C9A8),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
