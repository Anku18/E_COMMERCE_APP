import 'package:e_commerce_app/services/firebase_services.dart';
import 'package:e_commerce_app/tabs/home_tab.dart';
import 'package:e_commerce_app/tabs/saved_tab.dart';
import 'package:e_commerce_app/tabs/search_tab.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _tabsPageController;
  int? _selectedTab;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ],
            ),
          ),
          BottomTab(
            selectedTab: _selectedTab,
            tabsPressed: (num) {
              _tabsPageController!.animateToPage(
                num,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
              );
            },
          ),
        ],
      ),
    );
  }
}
